pipeline {
  agent any

  stages {
    stage('Run Postman (Newman)') {
      agent {
        docker {
          image 'postman/newman:alpine'
          args '-u 1000:1000'   
        }
      }
      steps {
            sh '''
            mkdir -p test-results
            chmod +x batchs/test_run.sh
          ./batchs/test_run.sh
        '''
}

    }
  }

  post {
    always {
      junit testResults: 'test-results/*.xml', allowEmptyResults: true
      archiveArtifacts artifacts: 'test-results/*.xml,reports/*.html',
                       fingerprint: true, allowEmptyArchive: true
    }
  }
}
