
pipeline {

    agent any

    parameters {

        choice(
            name: 'DEPLOY_ENV',
            choices: ['dev', 'qa', 'uat', 'prod'],
            description: 'Select the environment where you want to deploy the application'
        )
    }

    environment {

        DEV_REGISTRY =
            "docker.io/payalkharat/jenkins-frontend-dev"

        QA_REGISTRY =
            "docker.io/payalkharat/jenkins-frontend-qa"

        STAGE_REGISTRY =
            "docker.io/payalkharat/jenkins-frontend-uat"

        PROD_REGISTRY =
            "docker.io/payalkharat/jenkins-frontend-prod"

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

        FRONTEND_DEPLOYMENT_YAML =
            "APP-1/kube/frontend-deployment.yaml"

        FRONTEND_SERVICE_YAML =
            "APP-1/kube/frontend-service.yaml"
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

                    echo "======================================"
                    echo "COMMIT ID: ${env.COMMIT_ID}"
                    echo "SELECTED ENVIRONMENT: ${params.DEPLOY_ENV}"
                    echo "======================================"
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

        stage('Build Frontend Image') {

            steps {

                script {

                    def image =
                        "${DEV_REGISTRY}:${COMMIT_ID}"

                    docker.withRegistry(
                        'https://index.docker.io/v1/',
                        'Docker-hub-id'
                    ) {

                        sh """
                            docker build \
                                -f APP-1/nginx-flask-mysql/proxy/Dockerfile \
                                -t ${image} \
                                APP-1/nginx-flask-mysql/proxy/

                            docker push ${image}
                        """
                    }

                    echo "======================================"
                    echo "FRONTEND IMAGE BUILT AND PUSHED"
                    echo "IMAGE: ${image}"
                    echo "======================================"
                }
            }
        }

        stage('Deploy Frontend - DEV') {

            when {

                expression {
                    params.DEPLOY_ENV == 'dev'
                }
            }

            steps {

                script {

                    deployFrontend(
                        DEV_NAMESPACE,
                        DEV_REGISTRY,
                        FRONTEND_DEPLOYMENT_YAML,
                        FRONTEND_SERVICE_YAML
                    )
                }
            }
        }

        stage('Promote Frontend DEV → QA') {

            when {

                anyOf {

                    expression {
                        params.DEPLOY_ENV == 'qa'
                    }

                    expression {
                        params.DEPLOY_ENV == 'uat'
                    }

                    expression {
                        params.DEPLOY_ENV == 'prod'
                    }
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

        stage('Deploy Frontend - QA') {

            when {

                expression {
                    params.DEPLOY_ENV == 'qa'
                }
            }

            steps {

                script {

                    deployFrontend(
                        QA_NAMESPACE,
                        QA_REGISTRY,
                        FRONTEND_DEPLOYMENT_YAML,
                        FRONTEND_SERVICE_YAML
                    )
                }
            }
        }

        stage('Promote Frontend QA → UAT') {

            when {

                anyOf {

                    expression {
                        params.DEPLOY_ENV == 'uat'
                    }

                    expression {
                        params.DEPLOY_ENV == 'prod'
                    }
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

        stage('Deploy Frontend - UAT') {

            when {

                expression {
                    params.DEPLOY_ENV == 'uat'
                }
            }

            steps {

                script {

                    deployFrontend(
                        STAGE_NAMESPACE,
                        STAGE_REGISTRY,
                        FRONTEND_DEPLOYMENT_YAML,
                        FRONTEND_SERVICE_YAML
                    )
                }
            }
        }

        stage('Production Approval') {

            when {

                expression {
                    params.DEPLOY_ENV == 'prod'
                }
            }

            steps {

                input(
                    message: "Deploy Frontend ${COMMIT_ID} to PROD?",
                    ok: "Deploy Frontend to PROD"
                )
            }
        }

        stage('Promote Frontend UAT → PROD') {

            when {

                expression {
                    params.DEPLOY_ENV == 'prod'
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

        stage('Deploy Frontend - PROD') {

            when {

                expression {
                    params.DEPLOY_ENV == 'prod'
                }
            }

            steps {

                script {

                    deployFrontend(
                        PROD_NAMESPACE,
                        PROD_REGISTRY,
                        FRONTEND_DEPLOYMENT_YAML,
                        FRONTEND_SERVICE_YAML
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

def deployFrontend(
    String namespace,
    String registry,
    String deploymentYaml,
    String serviceYaml
) {

    def image =
        "${registry}:${env.COMMIT_ID}"

    echo "======================================"
    echo "DEPLOYING FRONTEND"
    echo "======================================"
    echo "Namespace : ${namespace}"
    echo "Image     : ${image}"
    echo "======================================"

    echo "Applying Frontend Deployment..."

    sh """
        kubectl apply \
            -f ${deploymentYaml} \
            -n ${namespace}
    """

    echo "Applying Frontend Service..."

    sh """
        kubectl apply \
            -f ${serviceYaml} \
            -n ${namespace}
    """

    echo "Updating Frontend Image..."

    sh """
        kubectl -n ${namespace} set image \
            deployment/frontend \
            frontend=${image}
    """

    echo "Waiting for Frontend Rollout..."

    sh """
        kubectl -n ${namespace} rollout status \
            deployment/frontend \
            --timeout=300s
    """

    echo "Frontend Deployment Status:"

    sh """
        kubectl get deployment frontend \
            -n ${namespace}

        kubectl get service app1-frontend \
            -n ${namespace}

        kubectl get pods \
            -n ${namespace}
    """

    echo "======================================"
    echo "FRONTEND DEPLOYMENT COMPLETED"
    echo "======================================"
}

def promoteImage(
    String sourceImage,
    String targetImage,
    String sourceCredentials,
    String targetCredentials
) {

    echo "======================================"
    echo "IMAGE PROMOTION"
    echo "======================================"
    echo "Source : ${sourceImage}"
    echo "Target : ${targetImage}"
    echo "======================================"

    docker.withRegistry(
        'https://index.docker.io/v1/',
        sourceCredentials
    ) {

        sh """
            docker pull ${sourceImage}
        """
    }

    sh """
        docker tag \
            ${sourceImage} \
            ${targetImage}
    """

    docker.withRegistry(
        'https://index.docker.io/v1/',
        targetCredentials
    ) {

        sh """
            docker push ${targetImage}
        """
    }

    sh """
        docker rmi ${sourceImage} || true
        docker rmi ${targetImage} || true
    """

    echo "======================================"
    echo "IMAGE PROMOTION COMPLETED"
    echo "======================================"
}

