pipeline {
    agent any

    parameters {
        choice(name: 'ENV', choices: ['dev', 'prod'], description: 'Environment')
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Terraform Action')
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
            steps {
                dir("environments/${params.ENV}") {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                dir("environments/${params.ENV}") {
                    sh 'terraform apply -auto-approve'
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
