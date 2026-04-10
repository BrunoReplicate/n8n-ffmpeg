# n8n 2.15.0 con FFmpeg para procesamiento de video
# Compatible con Easypanel

FROM node:20-bookworm-slim

# Instalar FFmpeg y dependencias (incluye libass para quemar subtitulos)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    mediainfo \
    ca-certificates \
    git \
    openssl \
    libass-dev \
    fonts-freefont-ttf \
    && rm -rf /var/lib/apt/lists/*

# Instalar n8n 2.15.0
RUN npm install -g n8n@2.15.0

# Crear directorio de n8n
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node

USER node
WORKDIR /home/node

EXPOSE 5678

CMD ["n8n", "start"]
