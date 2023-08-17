FROM openjdk:8
EXPOSE 8080
COPY target/devops-pipline.jar devops-pipline.jar
ENTRYPOINT ["java", "-jar", "/devops-pipline.jar"]
