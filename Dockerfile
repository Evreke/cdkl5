FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY . .
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]