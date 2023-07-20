FROM openjdk:8
EXPOSE 8080
ADD target/devops-pipline.jar devops-pipline.jar
ENTRYPOINT ["java","-jar","/devops-integration.jar"]