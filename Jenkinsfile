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
    newman run POSTMAN/get_home.postman_collection.json --reporters cli,junit --reporter-junit-export test-results/get_home.xml
    newman run POSTMAN/get_welcome.postman_collection.json --reporters cli,junit --reporter-junit-export test-results/get_welcome.xml
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
