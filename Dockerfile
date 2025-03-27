# Этап сборки
FROM eclipse-temurin:17-jdk-alpine as builder
WORKDIR /app
COPY . .
RUN chmod +x gradlew
RUN ./gradlew build

# Финальный этап
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/build/libs/cdkl5-all.jar app.jar
CMD ["java", "-jar", "app.jar"]