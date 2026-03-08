pipeline {
    agent any

    parameters {
        choice(name: 'ENV', choices: ['dev', 'prod'], description: 'Environment')
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Terraform Action')
    }

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-jenkins')
    }

    stages {

        stage('Terraform Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'aws-jenkins']]) {
                    dir("environments/${params.ENV}") {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'aws-jenkins']]) {
                    dir("environments/${params.ENV}") {
                        sh 'terraform plan'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'aws-jenkins']]) {
                    dir("environments/${params.ENV}") {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'aws-jenkins']]) {
                    dir("environments/${params.ENV}") {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }

    }
}
