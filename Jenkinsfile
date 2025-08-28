pipeline {
  agent {
    docker { image 'docker:cli' args '-v /var/run/docker.sock:/var/run/docker.sock' }
  }

  stages {
    stage('Run Postman Tests') {
      steps {
        sh '''
          chmod +x batchs/test_run.sh
          ./batchs/test_run.sh
        '''
      }
    }
  }

  post {
    always {
      junit testResults: 'test-results/*.xml', allowEmptyResults: true
      archiveArtifacts artifacts: 'test-results/*.xml', fingerprint: true, allowEmptyArchive: true
    }
  }
}
