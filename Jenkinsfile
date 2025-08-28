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
          set -e
          mkdir -p test-results reports

          for f in POSTMAN/*.postman_collection.json; do
            base="$(basename "$f" .postman_collection.json)"

            # si un env du même nom existe (ex: POSTMAN/get_home.postman_environment.json), on l'utilise
            env_file="POSTMAN/${base}.postman_environment.json"
            env_opt=""
            [ -f "$env_file" ] && env_opt="-e $env_file"

            echo ">>> Running $f $env_opt"
            newman run "$f" $env_opt \
              --reporters cli,junit,htmlextra \
              --reporter-junit-export "test-results/${base}.xml" \
              --reporter-htmlextra-export "reports/${base}.html"
          done
        '''
      }
    }
  }

  post {
    always {
      junit testResults: 'test-results/*.xml', allowEmptyResults: true
      archiveArtifacts artifacts: 'test-results/*.xml,reports/*.html',
                       fingerprint: true, allowEmptyArchive: true
      // Si tu as le plugin HTML Publisher, tu peux aussi publier un des rapports:
      // publishHTML(target: [reportDir: 'reports', reportFiles: 'get_home.html', reportName: 'Postman Report'])
    }
  }
}
