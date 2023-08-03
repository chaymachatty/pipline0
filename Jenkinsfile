pipeline {
    agent any

    environment {
        // Set the M3_HOME variable with the correct path to Maven
        M3_HOME = "C:\\Program Files\\apache-maven-3.9.3"
        DOCKER_USERNAME = 'chayma14' 
        DOCKER_PASSWORD = 'chaymachatty14'
        ROBOT_PATH = "C:\\Users\\hp\\Desktop\\pipline\\test3.robot"
        PYTHON_PATH = "C:\\Users\\hp\\AppData\\Local\\Programs\\Python\\Python311\\python.exe"
        PIP_PATH = "C:\\Users\\hp\\AppData\\Local\\Programs\\Python\\Python311\\Scripts\\pip.exe"
        ROBOT_FRAMEWORK_PATH = "C:\\Users\\hp\\AppData\\Local\\Programs\\Python\\Python311\\Scripts\\robot.exe"
        SONAR_SCANNER_PATH = "C:\\Users\\hp\\Downloads\\sonar-scanner-cli-5.0.0.2966-windows\\sonar-scanner-5.0.0.2966-windows\\bin\\sonar-scanner.bat"
        SONARQUBE_PATH = "C:\\Users\\hp\\Downloads\\sonarqube-8.9.10.61524\\sonarqube-8.9.10.61524\\bin\\"
    

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
        

    stage('Run Robot Framework Test') {
    steps {
        // Install Robot Framework using the full path to pip
        bat "\"${PIP_PATH}\" install robotframework"

        // Execute the Robot Framework test with the full path to robot
        bat "\"${ROBOT_FRAMEWORK_PATH}\" --outputdir test_output ${ROBOT_PATH}"
    }
    post {
    always {
        // Archive Robot Framework test results and log from the "report-result" folder
        archiveArtifacts artifacts: "report-result\\test_output\\*"
    }
    }
    } 
      stage('Analyze the app with SonarQube') {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        def projectKey = 'chayma14' // Replace with your project's key in SonarQube
                        def sonarHostUrl = 'http://localhost:9000' // Replace with your SonarQube server URL
                        
                        env.SONAR_LOGIN = credentials('sonar-token') // Set the SONAR_LOGIN environment variable
                        
                
                          // Run the SonarQube analysis with SonarQube Scanner
                        bat "\"${SONAR_SCANNER_PATH}\" -Dsonar.projectKey=${projectKey} -Dsonar.host.url=${sonarHostUrl} -Dsonar.login=%SONAR_LOGIN%"
                    }
                }
            }
            post {
                always {
                    // Archive SonarQube analysis report
                    archiveArtifacts artifacts: '**/target/sonar/*'
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

