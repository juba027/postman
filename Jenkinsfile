pipeline {
    agent {
    docker{
        image 'postman/newman:latest'
        args '--entrypoint='
           }
    }
    triggers {
        upstream 'cypress-jenkins'
    }
    stages {
        stage('Install dependencies') {
            steps {
                sh 'npm install -g newman'
            }
        }

        stage('Run API Tests') {
            steps {
                   sh './batchs/test_run.sh'
            }
        }
    }

    post {
        always {
            junit 'results/newman-report.xml'
        }
    }
}