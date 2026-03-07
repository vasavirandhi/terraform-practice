pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/vasavirandhi/terraform-practice.git'
            }
        }

        stage('Terraform DEV Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    dir('environments/dev') {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform DEV Validate') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    dir('environments/dev') {
                        sh 'terraform validate'
                    }
                }
            }
        }

        stage('Terraform DEV Apply') {
            when {
                branch 'main'
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    dir('environments/dev') {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Terraform PROD Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    dir('environments/prod') {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform PROD Validate') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    dir('environments/prod') {
                        sh 'terraform validate'
                    }
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
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    dir('environments/prod') {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

    }
}
