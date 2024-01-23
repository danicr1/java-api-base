FROM eclipse-temurin:21-jre-alpine
VOLUME /tmp
# Base path is defined in docker compose build context - and that is the project's root
COPY target/my-rest-api-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]