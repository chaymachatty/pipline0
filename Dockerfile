# Use the official Spring Boot base image
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the compiled JAR file to the container
COPY target/myapp.jar .

# Expose the port the app runs on
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "myapp.jar"]

