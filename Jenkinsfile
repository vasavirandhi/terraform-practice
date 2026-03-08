pipeline {
    agent any

    parameters {
        choice(name: 'ENV', choices: ['dev','prod'], description: 'Environment')
        choice(name: 'ACTION', choices: ['apply','destroy'], description: 'Terraform Action')
    }

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-jenkins')
    }

    stages {

        stage('Terraform Init') {
            steps {
                dir("environments/${params.ENV}") {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                dir("environments/${params.ENV}") {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Approval for PROD') {
            when {
                expression { params.ENV == 'prod' && params.ACTION == 'apply' }
            }
            steps {
                input message: "Approve Terraform Apply for PROD?"
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                dir("environments/${params.ENV}") {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                dir("environments/${params.ENV}") {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }

    }
}
