# Microservicio Backend - Ventas | ITPCARGO 🛒

Este repositorio contiene el microservicio de **Ventas** para el ecosistema de ITPCARGO. Está encargado de la gestión, registro y consulta de las órdenes de compra generadas en el sistema.

## 🏗️ Arquitectura y Tecnologías
Este servicio opera de manera independiente y está construido con:
* **Framework:** Java Spring Boot.
* **Base de Datos:** MySQL 8.0 (Desplegada en un contenedor independiente).
* **Contenedores:** Docker y Docker Compose.
* **CI/CD:** GitHub Actions.

## 🚀 Automatización CI/CD
El pipeline de integración y despliegue continuo (`deploy.yml` / `main.yml`) está configurado para ejecutarse automáticamente.
1. **Detección de Cambios:** Al realizar un push a las ramas de integración (`deploy`) o producción (`main`).
2. **Construcción:** Se empaqueta la aplicación Java y se construye la imagen de Docker.
3. **Despliegue en AWS EC2:** La imagen actualizada se transfiere y se levanta en el servidor, reemplazando la versión anterior sin afectar la persistencia de datos.

## 🔐 Datos y Persistencia
* **Volúmenes:** Se utiliza un *Named Volume* para el directorio `/var/lib/mysql` del contenedor de la base de datos, garantizando que el historial de órdenes de compra no se pierda entre despliegues.
* **Datos Iniciales:** El archivo `data.sql` en los recursos de Spring Boot inyecta órdenes de compra de prueba para facilitar las pruebas del Frontend.

## 🛠️ Ejecución Local

### Requisitos Previos
* Docker Engine y Docker Compose instalados.

### Pasos para levantar el servicio
1. Clona el repositorio y ubícate en la carpeta principal:
   ```bash
   git clone [https://github.com/donnourrutia/EV2DevopsbackVentas.git](https://github.com/donnourrutia/EV2DevopsbackVentas.git)
   cd EV2DevopsbackVentas/Springboot-API-REST
   ```
2. Levanta el stack (API + Base de Datos) en segundo plano:
   ```bash
   docker-compose up -d
   ```
3. Para revisar que el servicio levantó correctamente, puedes consultar los logs:
   ```bash
   docker-compose logs -f
   ```
