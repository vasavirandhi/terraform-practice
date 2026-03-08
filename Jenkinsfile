pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'prod'],
            description: 'Select environment to deploy'
        )
        
        choice(
            name: 'ACTION',
            choices: ['apply', 'destroy'],
            description: 'Terraform action'
        )
    }

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/YOUR_USERNAME/YOUR_REPO.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir("environments/${params.ENVIRONMENT}") {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("environments/${params.ENVIRONMENT}") {
                    sh 'terraform plan'
                }
            }
        }

        stage('Approval for PROD') {
            when {
                expression {
                    params.ENVIRONMENT == 'prod' && params.ACTION == 'apply'
                }
            }
            steps {
                input message: 'Approve PROD deployment?'
            }
        }

        stage('Terraform Apply') {
            when {
                expression {
                    params.ACTION == 'apply'
                }
            }
            steps {
                dir("environments/${params.ENVIRONMENT}") {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression {
                    params.ACTION == 'destroy'
                }
            }
            steps {
                dir("environments/${params.ENVIRONMENT}") {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
}
