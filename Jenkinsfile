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
        stage('Run API Tests') {
            steps {
                sh 'chmod +x batchs/test_run.sh'
                sh './batchs/test_run.sh'
            }
        }
    }

    post {
        always {
            junit 'test-results/*.xml'
            archiveArtifacts artifacts: 'test-results/*.xml', fingerprint: true, allowEmptyArchive: true
        }
    }
}
