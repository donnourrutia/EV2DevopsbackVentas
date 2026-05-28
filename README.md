# Backend - Microservicio de Ventas (Innovatech Chile) 🛒
Este repositorio contiene el microservicio de Ventas, desarrollado en Java Spring Boot, que actúa como el núcleo de lógica de negocio y persistencia de datos para el ecosistema de ITPCARGO.

🏗️ Arquitectura y Justificación Técnica
La aplicación está diseñada bajo principios de arquitectura desacoplada para facilitar su escalabilidad:

Java Spring Boot: Framework elegido por su robustez, excelente manejo de dependencias y capacidad para crear API RESTful de alto rendimiento.

Base de Datos MySQL: Utilizada para garantizar consistencia transaccional en las órdenes de compra.

Contenedorización (Multi-Stage):

El Dockerfile utiliza un enfoque Multi-stage build: la primera etapa compila el proyecto y la segunda etapa (runtime) solo contiene el archivo JAR ejecutable y el JRE. Esto optimiza el tamaño de la imagen final y mejora la seguridad.

Usuario No-Root: Se implementó el uso de un usuario no privilegiado dentro del contenedor (USER appuser), mitigando riesgos de seguridad en caso de vulnerabilidad en el proceso.

💾 Persistencia de Datos
La persistencia es crítica para la continuidad operativa de Innovatech Chile.

Estrategia: Se utiliza un Named Volume de Docker para el directorio /var/lib/mysql.

Justificación: Elegimos Named Volumes sobre Bind Mounts porque son gestionados directamente por Docker, ofreciendo mejor rendimiento, mayor aislamiento del host y una migración de datos más sencilla entre contenedores sin depender de las rutas del sistema operativo del servidor.

🚀 Pipeline CI/CD (GitHub Actions)
La automatización garantiza que cada actualización en el código llegue de manera segura a la infraestructura AWS:

Trigger: Activación automática mediante push a la rama deploy o main.

Build & Test: GitHub Actions construye la imagen Docker validando la correcta compilación del código Java.

Push: Publicación de la imagen en el registro de contenedores (ECR/DockerHub) con versionado.

Deploy: Conexión segura vía SSH a la instancia EC2 para ejecutar docker-compose up -d, actualizando el servicio sin tiempo de inactividad (Zero Downtime).

Seguridad: Todas las credenciales de AWS y tokens se gestionan a través de GitHub Secrets, evitando la exposición de datos sensibles.

🛠️ Ejecución Local
Requisitos Previos
Docker Engine y Docker Compose instalados.

Pasos para levantar el servicio
Clona el repositorio:

Bash
git clone https://github.com/donnourrutia/EV2DevopsbackVentas.git
cd EV2DevopsbackVentas/Springboot-API-REST
Levanta el stack completo (Backend + MySQL) en segundo plano:

Bash
docker-compose up -d
Verifica el estado de los contenedores:

Bash
docker-compose ps
docker-compose logs -f app-backend
⚙️ Principios DevOps Aplicados
Automatización: Flujo CI/CD completo desde el commit hasta el servidor.

Trazabilidad: Uso de historial de commits descriptivos para auditoría de cambios.

Gestión de Entornos: Configuración desacoplada del código mediante variables de entorno (DB_URL, DB_USER, etc.), permitiendo cambiar entre entorno de desarrollo y AWS sin tocar el código fuente.

Documentación: Este repositorio sigue estándares de documentación técnica para asegurar la mantenibilidad del proyecto a largo plazo.
