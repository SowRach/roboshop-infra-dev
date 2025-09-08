pipeline {
    agent {
        node {
            label 'Agent'
        }
    }
    options {
        timeout(time: 1, unit: 'HOURS')
        disableConcurrentBuilds()
    }

    stages {
        stage('s3 Backend') {
            steps {
                sh """
                    cd 00-terraform-s3
                    terraform init -reconfigure
                    terraform plan 
                    terraform apply -auto-approve
                """
            }
        }

        stage('Init') {
            steps {
                sh """
                    cd 01-vpc
                    terraform init -reconfigure 
                """
            }
        }

        stage('Plan') {
            steps {
                sh """
                    cd 01-vpc
                    terraform plan 
                """
            }
        }

        stage('Deploy') {
            input {
                message "Should we continue?"
                ok "Yes, we should."
            }
            steps {
                sh """
                    cd 01-vpc
                    terraform apply -auto-approve
                """
            }
        }

        stage('s3 destroy') {
            steps {
                sh """
                    cd 00-terraform-s3 
                    terraform destroy -auto-approve
                """
            }
        }

        stage('vpc destroy') {
            steps {
                sh """
                    cd 01-vpc
                    terraform destroy -auto-approve
                """
            }
        }
    }

    post {  
        always { 
            echo 'I will always say Hello again!'
        }
        failure { 
            echo 'this runs when pipeline is failed, used generally to send some alerts'
        }
        success {
            echo 'I will say Hello when pipeline is success'
        }
    }
}
