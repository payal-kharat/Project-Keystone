pipeline {

    agent any

    parameters {

        choice(
            name: 'DEPLOY_ENV',
            choices: ['dev', 'qa', 'uat', 'prod'],
            description: 'Select the environment where you want to deploy'
        )
    }

    environment {

        DEV_REGISTRY =
            "docker.io/payalkharat/jenkins-backend-dev"

        QA_REGISTRY =
            "docker.io/payalkharat/jenkins-backend-qa"

        STAGE_REGISTRY =
            "docker.io/payalkharat/jenkins-backend-stage"

        PROD_REGISTRY =
            "docker.io/payalkharat/jenkins-backend-prod"

        EKS_CLUSTER = "cluster-1"
        AWS_REGION  = "us-east-1"

        DEV_NAMESPACE   = "dev"
        QA_NAMESPACE    = "qa"
        STAGE_NAMESPACE = "uat"
        PROD_NAMESPACE  = "prod"

        DEV_DOCKER_CREDS   = "dh_cred_dev"
        QA_DOCKER_CREDS    = "dh_cred_qa"
        STAGE_DOCKER_CREDS = "dh_cred_stage"
        PROD_DOCKER_CREDS  = "dh_cred_prod"

        DEPLOY_ENV = "${params.DEPLOY_ENV}"
    }

    stages {

        stage('Checkout') {

            steps {

                checkout scm

                script {

                    env.COMMIT_ID = sh(
                        script: "git rev-parse --short HEAD",
                        returnStdout: true
                    ).trim()

                    echo "COMMIT ID: ${env.COMMIT_ID}"
                    echo "DEPLOY ENVIRONMENT: ${env.DEPLOY_ENV}"
                }
            }
        }

        stage('Connect to EKS') {

            steps {

                sh """
                    aws eks update-kubeconfig \
                        --name ${EKS_CLUSTER} \
                        --region ${AWS_REGION}

                    kubectl get nodes
                """
            }
        }

        stage('Create Kubernetes Namespaces') {

            steps {

                sh """
                    kubectl get namespace ${DEV_NAMESPACE} \
                    || kubectl create namespace ${DEV_NAMESPACE}

                    kubectl get namespace ${QA_NAMESPACE} \
                    || kubectl create namespace ${QA_NAMESPACE}

                    kubectl get namespace ${STAGE_NAMESPACE} \
                    || kubectl create namespace ${STAGE_NAMESPACE}

                    kubectl get namespace ${PROD_NAMESPACE} \
                    || kubectl create namespace ${PROD_NAMESPACE}
                """
            }
        }

        stage('Docker Login') {

            steps {

                withCredentials([
                    usernamePassword(
                        credentialsId: 'Docker-hub-id',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {

                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login \
                            docker.io \
                            -u "$DOCKER_USERNAME" \
                            --password-stdin
                    '''
                }
            }
        }

        stage('Build Backend Image') {

            steps {

                script {

                    def image =
                        "${DEV_REGISTRY}:${COMMIT_ID}"

                    sh """
                        docker build \
                            -f APP-1/nginx-flask-mysql/backend/Dockerfile \
                            -t ${image} \
                            APP-1/nginx-flask-mysql/backend/

                        docker push ${image}
                    """

                    echo "IMAGE: ${image}"
                }
            }
        }

        stage('Deploy Backend - DEV') {

            when {

                expression {
                    env.DEPLOY_ENV == 'dev'
                }
            }

            steps {

                script {

                    deployBackend(
                        DEV_NAMESPACE,
                        DEV_REGISTRY,
                        "APP-1/kube/backend-deployment.yaml",
                        "APP-1/kube/backend-service.yaml"
                    )
                }
            }
        }

        stage('Promote Backend DEV → QA') {

            when {

                expression {
                    env.DEPLOY_ENV == 'qa'
                }
            }

            steps {

                script {

                    promoteImage(
                        "${DEV_REGISTRY}:${COMMIT_ID}",
                        "${QA_REGISTRY}:${COMMIT_ID}",
                        DEV_DOCKER_CREDS,
                        QA_DOCKER_CREDS
                    )
                }
            }
        }

        stage('Deploy Backend - QA') {

            when {

                expression {
                    env.DEPLOY_ENV == 'qa'
                }
            }

            steps {

                script {

                    deployBackend(
                        QA_NAMESPACE,
                        QA_REGISTRY,
                        "APP-1/kube/backend-deployment.yaml",
                        "APP-1/kube/backend-service.yaml"
                    )
                }
            }
        }

        stage('Promote Backend QA → UAT') {

            when {

                expression {
                    env.DEPLOY_ENV == 'uat'
                }
            }

            steps {

                script {

                    promoteImage(
                        "${QA_REGISTRY}:${COMMIT_ID}",
                        "${STAGE_REGISTRY}:${COMMIT_ID}",
                        QA_DOCKER_CREDS,
                        STAGE_DOCKER_CREDS
                    )
                }
            }
        }

        stage('Deploy Backend - UAT') {

            when {

                expression {
                    env.DEPLOY_ENV == 'uat'
                }
            }

            steps {

                script {

                    deployBackend(
                        STAGE_NAMESPACE,
                        STAGE_REGISTRY,
                        "APP-1/kube/backend-deployment.yaml",
                        "APP-1/kube/backend-service.yaml"
                    )
                }
            }
        }

        stage('Promote Backend UAT → PROD') {

            when {

                expression {
                    env.DEPLOY_ENV == 'prod'
                }
            }

            steps {

                script {

                    promoteImage(
                        "${STAGE_REGISTRY}:${COMMIT_ID}",
                        "${PROD_REGISTRY}:${COMMIT_ID}",
                        STAGE_DOCKER_CREDS,
                        PROD_DOCKER_CREDS
                    )
                }
            }
        }

        stage('Deploy Backend - PROD') {

            when {

                expression {
                    env.DEPLOY_ENV == 'prod'
                }
            }

            steps {

                script {

                    deployBackend(
                        PROD_NAMESPACE,
                        PROD_REGISTRY,
                        "APP-1/kube/backend-deployment.yaml",
                        "APP-1/kube/backend-service.yaml"
                    )
                }
            }
        }
    }

    post {

        always {

            echo "Cleaning Jenkins workspace..."

            cleanWs()
        }
    }
}


def deployBackend(
    String namespace,
    String registry,
    String deploymentYaml,
    String serviceYaml
) {

    def image =
        "${registry}:${env.COMMIT_ID}"

    echo "Namespace : ${namespace}"
    echo "Image     : ${image}"

    sh """
        kubectl apply \
            -f ${deploymentYaml} \
            -n ${namespace}
    """

    sh """
        kubectl apply \
            -f ${serviceYaml} \
            -n ${namespace}
    """

    sh """
        kubectl -n ${namespace} set image \
            deployment/backend \
            backend=${image}
    """

    sh """
        kubectl -n ${namespace} rollout status \
            deployment/backend \
            --timeout=180s
    """

    sh """
        kubectl get deployment backend \
            -n ${namespace}

        kubectl get service app1-backend \
            -n ${namespace}

        kubectl get pods \
            -n ${namespace}
    """
}


def promoteImage(
    String sourceImage,
    String targetImage,
    String sourceCredentials,
    String targetCredentials
) {

    echo "Source : ${sourceImage}"
    echo "Target : ${targetImage}"

    withCredentials([
        usernamePassword(
            credentialsId: sourceCredentials,
            usernameVariable: 'DOCKER_USERNAME',
            passwordVariable: 'DOCKER_PASSWORD'
        )
    ]) {

        sh """
            echo "\$DOCKER_PASSWORD" | docker login \
                docker.io \
                -u "\$DOCKER_USERNAME" \
                --password-stdin

            docker pull ${sourceImage}
        """
    }

    sh """
        docker tag \
            ${sourceImage} \
            ${targetImage}
    """

    withCredentials([
        usernamePassword(
            credentialsId: targetCredentials,
            usernameVariable: 'DOCKER_USERNAME',
            passwordVariable: 'DOCKER_PASSWORD'
        )
    ]) {

        sh """
            echo "\$DOCKER_PASSWORD" | docker login \
                docker.io \
                -u "\$DOCKER_USERNAME" \
                --password-stdin

            docker push ${targetImage}
        """
    }

    sh """
        docker rmi ${sourceImage} || true
        docker rmi ${targetImage} || true
    """
}