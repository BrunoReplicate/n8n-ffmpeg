# n8n con FFmpeg para procesamiento de video
# Compatible con Easypanel

FROM node:18-bullseye-slim

# Instalar FFmpeg y dependencias
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    mediainfo \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Instalar n8n globalmente
RUN npm install -g n8n@1.121.3

# Crear directorio de n8n
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node

USER node
WORKDIR /home/node

# Puerto por defecto de n8n
EXPOSE 5678

# Comando de inicio
CMD ["n8n", "start"]
