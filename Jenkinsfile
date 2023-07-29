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

        stage('Install and Configure Robot Framework') {
            steps {
                // Install Python and Robot Framework
                bat 'choco install python3'
                bat 'C:\\Users\\hp\\AppData\\Local\\Programs\\Python\\Python311\\Scripts\\pip.exe install --upgrade pip'
                bat 'C:\\Users\\hp\\AppData\\Local\\Programs\\Python\\Python311\\Scripts\\pip.exe install robotframework'

                // Install WebDriverManager
                bat 'C:\\Users\\hp\\AppData\\Local\\Programs\\Python\\Python311\\Scripts\\pip.exe install webdrivermanager'
                bat 'C:\\Users\\hp\\AppData\\Local\\Programs\\Python\\Python311\\python.exe -m webdrivermanager firefox chrome --linkpath C:\\Users\\hp\\Downloads\\edgedriver_win64'
            }
        }

        stage('Robot Framework Testing') {
            steps {
                // Run Robot Framework tests with the Edge browser
                dir('C:\\Users\\hp\\Desktop\\pipline') {
                    bat 'robot --outputdir robot-output --variable BROWSER:Edge --variable webdriver_path:"C:\\Users\\hp\\Downloads\\edgedriver_win64\\msedgedriver.exe" test.robot'
                }
            }
            post {
                always {
                    // Archive test results
                    junit 'C:\\Users\\hp\\Desktop\\pipline\\output.xml'
                }
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
        }
    }
}
