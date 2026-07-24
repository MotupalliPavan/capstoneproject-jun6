pipeline {
    agent any

    environment {
        TF_DIR = "terraform"
        IMAGE_NAME = "artifact11"
        IMAGE_TAG = "latest"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Git Info') {
            steps {
                sh 'git branch'
                sh 'git log --oneline -5'
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform plan'
                }
            }
        }

        stage('Checkov Scan') {
            steps {
                dir("${TF_DIR}") {
                    sh '/opt/checkov-venv/bin/checkov -d . --soft-fail'
                }
            }
        }

        stage('OPA Policy Check') {
            steps {
                sh 'opa eval --data opa/policy.rego "data.terraform.security.allow"'
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${TF_DIR}") {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Build WAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Verify WAR') {
            steps {
                sh 'ls -lh target'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                    docker rm -f artifact11 || true
                    docker run -d \
                        --name artifact11 \
                        artifact11:latest
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }

        failure {
            echo 'Pipeline failed.'
        }

        always {
            sh 'docker ps -a || true'
        }
    }
}
