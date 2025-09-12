pipeline {
    agent {
        node {
            label 'Agent'
        }
    }
    options {
        ansiColor('xterm')
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

        stage('vpc') {
            steps {
                sh """
                    cd 01-vpc
                    terraform init -reconfigure
                    terraform plan
                    terraform apply -auto-approve
                """
            }
        }

        stage('SG') {
            steps {
                sh """
                    cd 02-sg
                    terraform init -reconfigure
                    terraform plan
                    terraform apply -auto-approve
                """
            }
        }

        stage('VPN') {
            steps {
                sh """
                    cd 03-vpn
                    terraform init -reconfigure
                    terraform plan
                    terraform apply -auto-approve
                """
            }
        }

        stage('Databases') {
            steps {
                sh """
                    cd 04-databases
                    terraform init -reconfigure
                    terraform plan
                    terraform apply -auto-approve
                """
            }
        }

        // stage('Application-ALB') {
        //     steps {
        //         sh """
        //             cd 05-app-alb
        //             terraform init -reconfigure
        //             terraform plan
        //             terraform apply -auto-approve
        //         """
        //     }
        // }
    }  // ✅ closing stages

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
