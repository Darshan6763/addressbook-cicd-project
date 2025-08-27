pipeline {
  agent any

  parameters {
    string(name: 'APP_HOST', defaultValue: '', description: 'Public IP of app node')
  }

  environment {
    APP_SSH_CRED = 'app-ssh'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build WAR') {
      steps {
        sh 'mvn clean package -DskipTests'
        sh 'cp target/*.war app.war'
      }
    }

    stage('Deploy') {
      steps {
        withCredentials([sshUserPrivateKey(credentialsId: "${APP_SSH_CRED}", keyFileVariable: 'SSH_KEY', usernameVariable: 'SSH_USER')]) {
          sh '''
            echo "[app]" > inventory.ini
            echo "${APP_HOST}" >> inventory.ini
            ansible-playbook -i inventory.ini ansible/tomcat.yml \
              --private-key "$SSH_KEY" -u "$SSH_USER" \
              -e "war_src=app.war"
          '''
        }
      }
    }
  }

  post {
    success {
      echo "App deployed successfully at http://${params.APP_HOST}:8080/app/"
    }
  }
}
