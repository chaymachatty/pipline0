pipeline {
    agent any

    environment {
        // Set the M3_HOME variable with the correct path to Maven
        M3_HOME = "C:\\Program Files\\apache-maven-3.9.3"
        DOCKER_USERNAME = 'chayma14' 
        DOCKER_PASSWORD = 'chaymachatty14'
        ROBOT_PATH = "C:\\Users\\hp\\Desktop\\pipline\\test.robot"
        PYTHON_PATH = "C:\\Users\\hp\\AppData\\Local\\Programs\\Python\\Python311\\python.exe"
        EDGE_DRIVER_PATH = "C:\\Users\\hp\\Downloads\\edgedriver_win64\\msedgedriver.exe"
        HTML_FILE_PATH = "C:\\Users\\hp\\Desktop\\pipline\\MainClass.html"
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

        stage('Run Robot Tests') {
            steps {
                // Install required Python packages (if not already installed)
                bat "\"%PYTHON_PATH%\" -m pip install --upgrade robotframework"
                bat "\"%PYTHON_PATH%\" -m pip install --upgrade robotframework-seleniumlibrary"

                // Execute the Robot Framework tests
                bat "\"%PYTHON_PATH%\" -m robot --variable BROWSER:edge --variable DRIVER_PATH:\"%EDGE_DRIVER_PATH%\" --variable HTML_FILE_PATH:\"%HTML_FILE_PATH%\" \"%ROBOT_PATH%\""
            }
            post {
                always {
                    // Archive Robot Framework test results
                    junit '**/output.xml'
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
