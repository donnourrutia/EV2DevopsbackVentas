# ---- Etapa 1: Construcción y dependencias (Builder) ----
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app


# 1. Copiamos el archivo de configuración de Maven
COPY pom.xml .

# 2. Descargamos las dependencias (esto se guarda en caché si no cambia el pom.xml)
RUN mvn dependency:go-offline -B

# 3. Copiamos todo el código fuente del backend
COPY src ./src

# 4. Compilamos y generamos el archivo .jar (saltamos los tests para acelerar el pipeline)
RUN mvn package -DskipTests

# ---- Etapa 2: Imagen de producción ultra ligera ----
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# 5. Copiamos el .jar compilado desde la etapa anterior
# (Buscamos cualquier jar en /target y lo renombramos a app.jar)
COPY --from=builder /app/target/*.jar app.jar

# 6. El puerto por defecto donde escucha Spring Boot
EXPOSE 8080
 

# 7. Comando para ejecutar la aplicación Java
ENTRYPOINT ["java", "-jar", "app.jar"]