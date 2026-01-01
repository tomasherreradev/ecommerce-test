# 🚀 Pasos para Desplegar en Render.com

## ✅ Lo que ya tienes:
- ✅ Proyecto en GitHub
- ✅ Base de datos MySQL en SkySQL
- ✅ Credenciales de la base de datos

## 📝 Pasos a seguir:

### 1. Crear cuenta en Render.com
- Ve a https://render.com
- Regístrate con tu cuenta de GitHub (recomendado)

### 2. Crear nuevo Web Service
1. En el dashboard de Render, haz clic en **"New +"** → **"Web Service"**
2. Conecta tu repositorio de GitHub
3. Selecciona el repositorio `velstore`

### 3. Configurar el servicio

**Configuración básica:**
- **Name**: `velstore` (o el nombre que prefieras)
- **Environment**: Selecciona **"Docker"** ⭐ (ya que PHP no está disponible)
- **Region**: Elige la más cercana (ej: `Oregon (US West)`)
- **Branch**: `main` (o la rama que uses)
- **Root Directory**: (déjalo vacío)
- **Plan**: `Free`

**Build Command:**
- **Déjalo VACÍO** - Render usará automáticamente el `Dockerfile` que ya está en tu proyecto

**Start Command:**
- **Déjalo VACÍO** - El Dockerfile ya tiene configurado el comando de inicio

### 4. Configurar Variables de Entorno

**⚠️ IMPORTANTE**: Agrega estas variables ANTES de hacer clic en "Create Web Service"

En la sección **"Environment Variables"**, haz clic en **"Add Environment Variable"** y agrega una por una:

#### Variables de Aplicación:
```
APP_NAME = Velstore
APP_ENV = production
APP_KEY = base64:iifI4zEyTG+K+cwH1G79izy7Xfsx+TYPWjnZYvKcx2Y=
APP_DEBUG = false
APP_URL = https://velstore.onrender.com
```

**Nota**: `APP_URL` se actualizará después con la URL real que Render te asigne.

#### Variables de Logging:
```
LOG_CHANNEL = stderr
LOG_LEVEL = error
```

#### Variables de Base de Datos (SkySQL):
```
DB_CONNECTION = mysql
DB_HOST = serverless-europe-west2.sysp0000.db2.skysql.com
DB_PORT = 4050
DB_DATABASE = defaultdb
DB_USERNAME = dbpgf35543126
DB_PASSWORD = E1lc(M7wdRJqxkxvy97Tq8U
```

**⚠️ IMPORTANTE sobre DB_DATABASE**:
- Verifica en SkySQL cuál es el nombre real de tu base de datos
- Puede ser `defaultdb` o el nombre que hayas creado
- Si no estás seguro, usa `defaultdb` primero

#### Variables de Configuración Laravel:
```
BROADCAST_DRIVER = log
CACHE_DRIVER = file
FILESYSTEM_DISK = local
QUEUE_CONNECTION = sync
SESSION_DRIVER = file
SESSION_LIFETIME = 120
```

### 5. Crear el servicio
1. Revisa que todas las variables estén agregadas
2. Haz clic en **"Create Web Service"**
3. Render comenzará a construir tu aplicación (esto tomará 5-10 minutos)

### 6. Actualizar APP_URL después del despliegue
1. Una vez que Render termine el despliegue, te dará una URL como: `https://velstore-xxxx.onrender.com`
2. Ve a **Settings** → **Environment** en tu servicio
3. Actualiza la variable `APP_URL` con la URL real que Render te asignó
4. Haz clic en **"Save Changes"** (esto reiniciará el servicio)

### 7. Verificar el despliegue
1. Visita la URL que Render te proporcionó
2. Revisa los **Logs** en Render si hay algún error
3. Si todo está bien, deberías ver tu aplicación funcionando

## 🔧 Solución de Problemas

### Error: "Database connection failed"
- Verifica que las credenciales de SkySQL sean correctas
- Asegúrate de que el nombre de la base de datos (`DB_DATABASE`) sea correcto
- Verifica que SkySQL permita conexiones desde internet (debería estar habilitado por defecto)

### Error: "APP_KEY is not set"
- Ya está configurado, pero si aparece el error, verifica que la variable esté escrita correctamente

### Error: "Vite manifest not found"
- Verifica que `npm run build` se ejecute correctamente en el build
- Revisa los logs de build en Render

### La aplicación se ve sin estilos
- Verifica que `npm run build` se ejecute sin errores
- Revisa los logs de build

### La aplicación tarda en cargar
- En el plan gratuito, Render "duerme" la aplicación después de 15 minutos de inactividad
- La primera carga después de dormir puede tardar ~30 segundos
- Esto es normal en el plan gratuito

## 📝 Checklist Final

- [ ] Cuenta creada en Render.com
- [ ] Repositorio conectado
- [ ] Build Command configurado
- [ ] Start Command configurado
- [ ] Todas las variables de entorno agregadas
- [ ] APP_KEY configurado
- [ ] Credenciales de base de datos correctas
- [ ] Servicio creado y desplegándose
- [ ] APP_URL actualizado después del despliegue
- [ ] Aplicación funcionando correctamente

## 🎉 ¡Listo!

Una vez completado, tu aplicación estará disponible en una URL pública que puedes compartir con tu cliente.

**URL de ejemplo**: `https://velstore-xxxx.onrender.com`

