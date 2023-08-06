FROM openjdk:11 AS builder
WORKDIR /backend
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
RUN chmod +x ./gradlew
RUN ./gradlew bootJar

FROM openjdk:11
COPY --from=builder /backend/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
VOLUME /tmp