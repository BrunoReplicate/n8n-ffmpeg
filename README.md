# n8n + FFmpeg para Easypanel

n8n con FFmpeg integrado, listo para desplegar en Easypanel. Ideal para automatizar procesamiento de video en tus flujos de trabajo.

## Instalación en Easypanel

### Opción 1: Desde GitHub (Recomendado)

1. Sube este repositorio a tu GitHub
2. En Easypanel, crea un **nuevo proyecto**
3. Agrega un servicio tipo **App**
4. Selecciona **GitHub** como fuente
5. Conecta tu repositorio
6. Easypanel detectará el `Dockerfile` automáticamente
7. En **Environment**, agrega:
   - `GENERIC_TIMEZONE` = `America/Lima`
   - `N8N_PROTOCOL` = `https`
8. En **Domains**, agrega tu dominio (ej: `n8n.tudominio.com`)
9. Haz clic en **Deploy**

### Opción 2: Docker Compose

1. En Easypanel, crea un **nuevo proyecto**
2. Agrega un servicio tipo **Docker Compose**
3. Pega el contenido de `docker-compose.yml`
4. Haz clic en **Deploy**

## Verificar la instalación

Abre la consola del servicio en Easypanel y ejecuta:

```bash
ffmpeg -version
```

## Comandos FFmpeg útiles para n8n

Usa estos comandos en el nodo **Execute Command** de n8n.

### Convertir formato

```bash
ffmpeg -i /files/input.mp4 -c:v libx264 -c:a aac /files/output.mkv
```

### Extraer audio de un video

```bash
ffmpeg -i /files/video.mp4 -vn -acodec libmp3lame -q:a 2 /files/audio.mp3
```

### Comprimir video (reducir tamaño)

```bash
ffmpeg -i /files/input.mp4 -c:v libx264 -crf 28 -preset fast -c:a aac -b:a 128k /files/output_comprimido.mp4
```

### Cortar un clip (de 00:01:00 a 00:02:30)

```bash
ffmpeg -i /files/input.mp4 -ss 00:01:00 -to 00:02:30 -c copy /files/clip.mp4
```

### Generar thumbnail de un video

```bash
ffmpeg -i /files/video.mp4 -ss 00:00:05 -frames:v 1 /files/thumbnail.jpg
```

### Cambiar resolución a 720p

```bash
ffmpeg -i /files/input.mp4 -vf scale=1280:720 -c:a copy /files/output_720p.mp4
```

### Unir varios videos

```bash
# Primero crea un archivo lista.txt con:
# file '/files/video1.mp4'
# file '/files/video2.mp4'
ffmpeg -f concat -safe 0 -i /files/lista.txt -c copy /files/video_unido.mp4
```

### Extraer frames como imágenes

```bash
ffmpeg -i /files/video.mp4 -vf fps=1 /files/frame_%04d.jpg
```

### Agregar marca de agua

```bash
ffmpeg -i /files/video.mp4 -i /files/logo.png -filter_complex "overlay=10:10" /files/video_con_marca.mp4
```

### Convertir video a GIF

```bash
ffmpeg -i /files/video.mp4 -vf "fps=10,scale=480:-1" -t 5 /files/output.gif
```

## Notas

- El volumen `/files` es compartido para entrada/salida de archivos
- En n8n, usa nodos como **HTTP Request** para descargar videos antes de procesarlos
- Usa **Execute Command** para correr los comandos de FFmpeg
- Los archivos procesados pueden subirse a Google Drive, S3, etc. con los nodos correspondientes
- El timezone está configurado para Lima, Perú

## Stack incluido

- **n8n**: Última versión
- **FFmpeg**: Última versión disponible en Alpine
- **mediainfo**: Para obtener información técnica de archivos multimedia
