pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = "us-east-2"
    }
    stages {
        stage('Switch Environment') {
            steps {
                script {
                    switch(DEPLOY_ENV) {
                        case "nonprod":
                            AWS_ACCOUNT_ID = ""
                            break
                        default:
                            failBuild("No builds defined for ${DEPLOY_ENV}")
                            break
                    }
                }
            }
        }
        stage ('Packer Build') {
            steps {
                script {
                    println('Building AMI')
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}