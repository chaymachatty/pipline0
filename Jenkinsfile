pipeline {
    agent any

    environment {
        // Set the M3_HOME variable with the correct path to Maven
        M3_HOME = "C:\\Program Files\\apache-maven-3.9.3"
        DOCKER_USERNAME = 'chayma14' 
        DOCKER_PASSWORD = 'chaymachatty14'
        
    }

    stages {
        stage('Checkout Git') {
            steps {
                git branch: 'main', url: 'https://github.com/chaymachatty/pipline0'
            }
        }

        stage('Build with Maven') {
            steps {
                // Use the M3_HOME variable to call Maven
                bat "\"%M3_HOME%\\bin\\mvn\" clean package"
            }
        }
      stage('JUnit Test') {
            steps {
                // Use the M3_HOME variable to call Maven for running tests
                bat "\"%M3_HOME%\\bin\\mvn\" test"
            }
            post {
                always {
                    // Archive test results
                    junit '**/target/surefire-reports/*.xml'
                }
            }
      }
   stage('Robot Framework Testing') {
    steps {
        // Run Robot Framework tests
             bat 'C:\\Users\\hp\\AppData\\Local\\Programs\\Python\\Python311\\Scripts\\robot.exe --pythonpath C:\\Users\\hp\\AppData\\Local\\Programs\\Python\\Python311\\Lib\\site-packages C:\\Users\\hp\\Desktop\\pipeline\\test.robot'
            }
    }


      stage('Build docker image') {
             steps {
        script {
            bat 'docker build -t chayma14/devops-pipline .'
        }
    }
         }
           stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId:'chayma14', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        bat "docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%"
                    }
                    bat "docker tag $DOCKER_USERNAME/devops-pipline $DOCKER_USERNAME/devops-pipline:latest"
                    bat "docker push $DOCKER_USERNAME/devops-pipline:latest"
                }
            }

        }}
}