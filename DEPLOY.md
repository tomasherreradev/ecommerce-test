# 🚀 Guía de Despliegue - Velstore

Esta guía te ayudará a desplegar tu proyecto Laravel en un hosting gratuito.

## 📋 Opciones de Hosting Gratuito

### Opción 1: Render.com (Recomendado) ⭐
- **Plan gratuito**: 750 horas/mes
- **Base de datos**: PostgreSQL gratuita (90 días, luego $7/mes) o MySQL externa gratuita
- **Fácil de configurar**
- **URL**: https://render.com

### Opción 2: Railway.app
- **Plan gratuito**: $5 crédito/mes
- **Base de datos**: MySQL/PostgreSQL incluida
- **Ya tienes configuración preparada**
- **URL**: https://railway.app

---

## 🎯 OPCIÓN 1: Desplegar en Render.com

### Paso 1: Preparar el Repositorio Git

1. **Inicializar Git** (si no lo has hecho):
```bash
git init
git add .
git commit -m "Initial commit"
```

2. **Crear cuenta en GitHub/GitLab/Bitbucket** y subir tu código:
```bash
# Crear repositorio en GitHub, luego:
git remote add origin https://github.com/TU_USUARIO/velstore.git
git branch -M main
git push -u origin main
```

### Paso 2: Crear Base de Datos Gratuita

**Opción A: Usar PlanetScale (MySQL Gratuito)**
1. Ve a https://planetscale.com
2. Crea una cuenta gratuita
3. Crea una base de datos
4. Copia las credenciales de conexión

**Opción B: Usar Aiven (PostgreSQL Gratuito)**
1. Ve a https://aiven.io
2. Crea una cuenta gratuita
3. Crea un servicio PostgreSQL
4. Copia las credenciales

### Paso 3: Desplegar en Render

1. **Crear cuenta en Render.com**:
   - Ve a https://render.com
   - Regístrate con GitHub/GitLab

2. **Crear nuevo Web Service**:
   - Click en "New +" → "Web Service"
   - Conecta tu repositorio de GitHub
   - Selecciona el repositorio `velstore`

3. **Configurar el servicio**:
   - **Name**: `velstore` (o el que prefieras)
   - **Environment**: `PHP`
   - **Build Command**:
     ```bash
     composer install --optimize-autoloader --no-interaction --no-scripts
     npm install
     npm run build
     php artisan storage:link
     ```
   - **Start Command**:
     ```bash
     php artisan migrate --force && php artisan db:seed --force && php artisan config:cache && php artisan serve --host=0.0.0.0 --port=$PORT
     ```
   - **Plan**: Free

4. **Configurar Variables de Entorno**:
   En la sección "Environment Variables", agrega:

   ```
   APP_NAME=Velstore
   APP_ENV=production
   APP_KEY=base64:TU_APP_KEY_AQUI
   APP_DEBUG=false
   APP_URL=https://tu-app.onrender.com
   
   LOG_CHANNEL=stderr
   LOG_LEVEL=error
   
   DB_CONNECTION=mysql
   DB_HOST=TU_DB_HOST
   DB_PORT=3306
   DB_DATABASE=TU_DB_NAME
   DB_USERNAME=TU_DB_USER
   DB_PASSWORD=TU_DB_PASSWORD
   
   BROADCAST_DRIVER=log
   CACHE_DRIVER=file
   FILESYSTEM_DISK=local
   QUEUE_CONNECTION=sync
   SESSION_DRIVER=file
   SESSION_LIFETIME=120
   ```

   **⚠️ IMPORTANTE**: 
   - Genera `APP_KEY` ejecutando: `php artisan key:generate` localmente y copia el valor
   - O usa: `php artisan key:generate --show` y copia la clave

5. **Crear Base de Datos en Render** (Opcional):
   - Click en "New +" → "PostgreSQL" o "MySQL"
   - Plan: Free
   - Copia las credenciales y úsalas en las variables de entorno

6. **Desplegar**:
   - Click en "Create Web Service"
   - Render comenzará a construir y desplegar tu aplicación
   - Espera 5-10 minutos para el primer despliegue

### Paso 4: Verificar el Despliegue

1. Una vez completado, Render te dará una URL como: `https://velstore.onrender.com`
2. Visita la URL para verificar que todo funciona
3. Revisa los logs si hay errores

---

## 🎯 OPCIÓN 2: Desplegar en Railway.app

### Paso 1: Preparar el Repositorio Git

Igual que en Render, asegúrate de tener tu código en GitHub/GitLab.

### Paso 2: Desplegar en Railway

1. **Crear cuenta en Railway**:
   - Ve a https://railway.app
   - Regístrate con GitHub

2. **Crear nuevo proyecto**:
   - Click en "New Project"
   - Selecciona "Deploy from GitHub repo"
   - Selecciona tu repositorio `velstore`

3. **Railway detectará automáticamente**:
   - Tu archivo `nixpacks.toml` ya está configurado
   - El script `railway-start.sh` se ejecutará automáticamente

4. **Agregar Base de Datos**:
   - En tu proyecto, click en "New" → "Database" → "MySQL"
   - Railway creará una base de datos MySQL automáticamente
   - Las variables de entorno se configurarán automáticamente

5. **Configurar Variables de Entorno**:
   En "Variables", agrega:

   ```
   APP_NAME=Velstore
   APP_ENV=production
   APP_KEY=base64:TU_APP_KEY_AQUI
   APP_DEBUG=false
   APP_URL=https://tu-app.up.railway.app
   
   LOG_CHANNEL=stderr
   LOG_LEVEL=error
   ```

   **Nota**: Las variables de base de datos (`DB_*`) se configuran automáticamente cuando agregas la base de datos.

6. **Generar APP_KEY**:
   - En la pestaña "Deployments", abre el terminal
   - Ejecuta: `php artisan key:generate`
   - Copia el valor y agrégalo a las variables de entorno

7. **Desplegar**:
   - Railway desplegará automáticamente cuando hagas push a GitHub
   - O puedes hacer "Redeploy" manualmente

### Paso 3: Configurar Dominio Personalizado (Opcional)

1. En Railway, ve a "Settings" → "Networking"
2. Click en "Generate Domain"
3. O agrega tu propio dominio personalizado

---

## 🔧 Solución de Problemas Comunes

### Error: "APP_KEY is not set"
- Genera una clave: `php artisan key:generate --show`
- Agrega el valor a las variables de entorno como `APP_KEY`

### Error: "Database connection failed"
- Verifica que las credenciales de la base de datos sean correctas
- Asegúrate de que la base de datos esté accesible desde internet
- Para PlanetScale, verifica que el branch esté activo

### Error: "Storage link failed"
- El comando `php artisan storage:link` debe ejecutarse en el build
- Verifica que el directorio `public/storage` exista

### Error: "Vite manifest not found"
- Asegúrate de que `npm run build` se ejecute en el build command
- Verifica que `public/build/manifest.json` exista después del build

### La aplicación se ve sin estilos
- Verifica que Vite esté compilando correctamente
- Revisa que `APP_ENV=production` esté configurado
- Asegúrate de que `npm run build` se ejecute en el build

---

## 📝 Checklist Pre-Despliegue

- [ ] Código subido a GitHub/GitLab
- [ ] `.env` no está en el repositorio (está en `.gitignore`)
- [ ] `APP_KEY` generado y listo para agregar
- [ ] Base de datos creada y credenciales disponibles
- [ ] Variables de entorno preparadas
- [ ] `npm run build` funciona localmente
- [ ] `composer install` funciona sin errores

---

## 🎉 ¡Listo!

Una vez desplegado, tu aplicación estará disponible en una URL pública que puedes compartir con tu cliente.

**Nota**: Los planes gratuitos pueden tener limitaciones:
- Render: La aplicación se "duerme" después de 15 minutos de inactividad (se despierta en ~30 segundos)
- Railway: $5 crédito/mes (suficiente para proyectos pequeños)

Para producción real, considera un plan de pago.

