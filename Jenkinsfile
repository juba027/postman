pipeline {
    agent {
        docker {
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
                sh 'chmod +x batchs/test_run.sh'
                sh './batchs/test_run.sh'
            }
        }
    }

    post {
        always {
            junit 'test-results/*.xml'   // <-- adapte si ton batch sort ailleurs
            archiveArtifacts artifacts: 'test-results/*.xml', fingerprint: true, allowEmptyArchive: true
        }
    }
}
