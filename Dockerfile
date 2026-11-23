# Build stage
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app

# Copy Maven project files
COPY pom.xml .
COPY src ./src

# Build with retry if Maven Central is temporarily unavailable
RUN for i in 1 2 3 4 5; do \
    mvn -B -ntp clean package -DskipTests && exit 0; \
    echo "Maven download failed. Retrying in 30 seconds..."; \
    sleep 30; \
done; \
exit 1

# Runtime stage
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 10000

ENTRYPOINT ["java", "-jar", "app.jar"]