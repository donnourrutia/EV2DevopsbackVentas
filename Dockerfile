# ---- Etapa 1: Dependencias y Build (Builder) ----
FROM node:18-alpine AS builder

WORKDIR /app

# Copiamos los archivos de configuración
COPY package*.json ./

# Usamos install para asegurar que se descarguen todas las dependencias
RUN npm install

# Copiamos el resto del código fuente (index.js, routes, controllers, etc.)
COPY . .

# ---- Etapa 2: Producción ----
FROM node:18-alpine

WORKDIR /app

# Copiamos todo desde la etapa builder
COPY --from=builder /app ./

# Exponemos el puerto del backend
EXPOSE 5000

# Cambiamos al usuario "node" (no-root) por seguridad
USER node

# Comando para iniciar la aplicación
CMD ["npm", "start"]