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

    // build
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
                // submitter "alice,bob"
                // parameters {
                //     string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
                // }
            }
            steps {
                sh """
                    cd 01-vpc
                    terraform apply -auto-approve
                """
            }
        }
        
    }
    
    // post build
    post {  
        always { 
            echo 'I will always say Hello again!'
        }
        failure { 
            echo 'this runs when pipeline is failed, used generally to send some alerts'
        }
        success{
            echo 'I will say Hello when pipeline is success'
        }
    }
}