FROM openjdk:11-jre-slim

WORKDIR /backend

COPY ./backend-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 9999

ENTRYPOINT ["java", "-jar", "/app.jar"]