pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'us-east-1'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/vasavirandhi/terraform-demo.git'
            }
        }

        stage('Terraform DEV Init') {
            steps {
                dir('environments/dev') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform DEV Validate') {
            steps {
                dir('environments/dev') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform DEV Plan') {
            when {
                changeRequest()
            }
            steps {
                dir('environments/dev') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform DEV Apply') {
            when {
                branch 'main'
            }
            steps {
                dir('environments/dev') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Terraform PROD Init') {
            steps {
                dir('environments/prod') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform PROD Validate') {
            steps {
                dir('environments/prod') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform PROD Plan') {
            when {
                changeRequest()
            }
            steps {
                dir('environments/prod') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Approval for PROD Apply') {
            when {
                branch 'main'
            }
            steps {
                input message: "Approve Terraform Production Apply?"
            }
        }

        stage('Terraform PROD Apply') {
            when {
                branch 'main'
            }
            steps {
                dir('environments/prod') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

    }
}
