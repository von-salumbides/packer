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
        stage('Latest AMI') {
            steps {
                script {
                    SOURCE_AMI = sh(returnStdout: true, script:"aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --region ${AWS_DEFAULT_REGION} | jq '.Parameters[0].Value'").trim()
                    sh "echo ${SOURCE_AMI}"
                }
            }
        }
        stage ('Packer Build') {
            steps {
                script {
                    println('Building AMI')
                    sh "make"
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