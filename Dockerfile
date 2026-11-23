FROM eclipse-temurin:21-jre

WORKDIR /app

COPY target/resume-builder-system-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 10000

ENTRYPOINT ["java", "-jar", "app.jar"]