# n8n con FFmpeg para procesamiento de video
# Listo para desplegar en Easypanel

FROM n8nio/n8n:latest

USER root

# Instalar FFmpeg y herramientas de video útiles
RUN apk add --no-cache \
    ffmpeg \
    mediainfo \
    && ffmpeg -version

# Volver al usuario n8n por seguridad
USER node

# Puerto por defecto de n8n
EXPOSE 5678

# Comando de inicio
CMD ["n8n", "start"]
