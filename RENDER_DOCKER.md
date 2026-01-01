# 🐳 Desplegar en Render.com usando Docker

## ✅ Configuración en Render

### Paso 1: Seleccionar Docker
En el formulario de creación del servicio:
- **Environment / Language**: Selecciona **"Docker"** ⭐

### Paso 2: Dejar comandos vacíos
- **Build Command**: Déjalo **VACÍO** (Render usará el Dockerfile automáticamente)
- **Start Command**: Déjalo **VACÍO** (El Dockerfile ya tiene el comando configurado)

### Paso 3: Configuración básica
- **Name**: `velstore`
- **Region**: Elige la más cercana
- **Branch**: `main`
- **Root Directory**: (vacío)
- **Plan**: `Free`

### Paso 4: Variables de Entorno
Agrega todas las variables de entorno (ver `RENDER_PASOS.md` o `RENDER_ENV_VARS.txt`)

## 📋 Resumen de Configuración

```
Environment: Docker
Build Command: (vacío)
Start Command: (vacío)
```

**¡Eso es todo!** Render detectará automáticamente tu `Dockerfile` y lo usará para construir y ejecutar tu aplicación.

## 🔍 ¿Qué hace el Dockerfile?

1. ✅ Instala PHP 8.2 con todas las extensiones necesarias
2. ✅ Instala Composer y Node.js/npm
3. ✅ Instala dependencias de PHP (`composer install`)
4. ✅ Instala dependencias de Node (`npm install`)
5. ✅ Compila los assets con Vite (`npm run build`)
6. ✅ Crea el enlace simbólico de storage
7. ✅ Ejecuta migraciones y seeders al iniciar
8. ✅ Inicia el servidor Laravel en el puerto correcto

## ✅ Archivos necesarios (ya los tienes)

- ✅ `Dockerfile` - Configuración de Docker
- ✅ `render-start.sh` - Script de inicio
- ✅ Variables de entorno configuradas

## 🚀 Siguiente paso

1. Haz clic en **"Create Web Service"**
2. Render comenzará a construir tu aplicación (5-10 minutos)
3. ¡Listo! Tu aplicación estará disponible en la URL que Render te proporcione

