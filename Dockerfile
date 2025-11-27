# Dockerfile para desplegar Spring Boot en Render
FROM eclipse-temurin:17-jdk-alpine as build

# Directorio de trabajo
WORKDIR /app

# Copiar archivos de configuración de Maven
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Dar permisos de ejecución a mvnw
RUN chmod +x mvnw

# Descargar dependencias
RUN ./mvnw dependency:go-offline -B

# Copiar código fuente
COPY src src

# Compilar la aplicación
RUN ./mvnw package -DskipTests

# Etapa final - imagen ligera
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copiar el JAR compilado desde la etapa de build
COPY --from=build /app/target/desplieg-0.0.1-SNAPSHOT.jar app.jar

# Exponer el puerto (Render usa la variable PORT)
EXPOSE ${PORT:-8080}

# Comando para ejecutar la aplicación
# Render establece la variable de entorno PORT automáticamente
ENTRYPOINT ["sh", "-c", "java -Dserver.port=${PORT:-8080} -Dspring.profiles.active=prod -jar app.jar"]

