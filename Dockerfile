# Use openjdk 17 as the base image
FROM openjdk:17-jdk-slim

# Set the environment variable for Maven
ENV MAVEN_VERSION 3.7.0

# Download and install Maven
RUN mkdir -p /usr/share/maven && \
    curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share/maven --strip-components=1 && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# Set Maven environment variables
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

# Set the working directory to /app
WORKDIR /app

# Copy the pom.xml file to the Docker image
COPY pom.xml .

# Copy the rest of the project files
COPY . .

# Run the Maven build command to compile the code
RUN mvn clean package

# Set the default command to run when the Docker container starts
CMD ["java", "-jar", "target/quarkus-app/quarkus-run.jar"]
