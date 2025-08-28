pipeline {
    agent any

    parameters {
        // Application Node IP added here
        string(name: 'APP_HOST', defaultValue: '13.48.190.155', description: 'Public IP of app node')
    }

    environment {
        APP_SSH_CRED = 'app-ssh'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone your GitHub repo directly
                git branch: 'main',
                    url: 'https://github.com/Darshan6763/addressbook-cicd-project.git'
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
