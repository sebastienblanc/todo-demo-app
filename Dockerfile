# Use openjdk 17 as the base image
FROM maven:3-openjdk-17-slim

# Set the working directory to /app
WORKDIR /app

# Copy the rest of the project files
COPY . /app

# Run the Maven build command to compile the code
RUN mvn clean package

# Set the default command to run when the Docker container starts
CMD ["java", "-jar", "target/quarkus-app/quarkus-run.jar"]
