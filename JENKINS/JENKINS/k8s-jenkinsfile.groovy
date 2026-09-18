@Library('my-shared-library') _

pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Java') {
            steps {
                buildJava()
            }
        }

        stage('Test') {
            steps {
                testJava()
            }
        }

        stage('Docker Login') {
            steps {
                dockerLogin()
            }
        }

        stage('Docker Build') {
            steps {
                dockerBuild(
                    'payalkharat/jenkins-demo',
                    "${BUILD_NUMBER}"
                )
            }
        }

        stage('Docker Push') {
            steps {
                dockerPush(
                    'payalkharat/jenkins-demo',
                    "${BUILD_NUMBER}"
                )
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                    export KUBECONFIG=/var/lib/jenkins/.kube/config

            kubectl apply -f k8s/deployment.yaml

            kubectl set image deployment/jenkins-demo \
                jenkins-demo=payalkharat/jenkins-demo:${BUILD_NUMBER}

            kubectl rollout status deployment/jenkins-demo
                """
            }
        }
    }
}