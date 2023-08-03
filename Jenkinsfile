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
    stage("Check SonarQube Quality") {
    steps {
        script {
            withSonarQubeEnv(credentialsId: 'sonar-token') {
                // Run SonarQube analysis
                bat "\"%M3_HOME%\\bin\\mvn\" clean install sonar:sonar"
                
                // Wait for the SonarQube quality gate to complete
                timeout(time: 1, unit: 'HOURS') {
                    def qg = waitForQualityGate()
                    if (qg.status != 'OK') {
                        error "Pipeline aborted due to quality gate failure: ${qg.status}"
                    }
                }
            }
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

