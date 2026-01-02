# 🔧 Solución: Errores de Base de Datos con Render

## ❌ Errores Comunes

### Error 1: "Access denied" (SkySQL/Railway)
```
SQLSTATE[HY000] [1045] Access denied for user 'usuario'@'IP' (using password: YES)
```

### Error 2: "getaddrinfo failed" (InfinityFree)
```
php_network_getaddresses: getaddrinfo for sql103.infinityfree.com failed: No address associated with hostname
```

### Error 3: "railway.internal failed" (Railway)
```
getaddrinfo for mysql.railway.internal failed: Name or service not known
```

## 🗄️ Bases de Datos Gratuitas Recomendadas para Render

### Opción 1: Railway MySQL ⭐ RECOMENDADO
- ✅ MySQL gratuito ($5 crédito/mes)
- ✅ Permite conexiones remotas
- ✅ Muy fácil de configurar
- **URL**: https://railway.app

**Configuración:**
1. Crea cuenta en Railway
2. "New Project" → "Database" → "MySQL"
3. Ve a "Variables" y copia `MYSQLHOST` (NO uses `MYSQLHOSTPRIVATE`)
4. En Render, configura:
```
DB_CONNECTION=mysql
DB_HOST=TU_HOST_PUBLICO.railway.app
DB_PORT=TU_PUERTO
DB_DATABASE=railway
DB_USERNAME=root
DB_PASSWORD=TU_PASSWORD
```

**⚠️ IMPORTANTE**: Usa el hostname **público** (termina en `.railway.app`), NO `mysql.railway.internal`

### Opción 2: Aiven (PostgreSQL o MySQL)
- ✅ PostgreSQL o MySQL gratuito
- ✅ Permite conexiones remotas
- ⚠️ 1 mes gratis, luego $5/mes
- **URL**: https://aiven.io

**Configuración PostgreSQL:**
```
DB_CONNECTION=pgsql
DB_HOST=TU_HOST.aivencloud.com
DB_PORT=12345
DB_DATABASE=defaultdb
DB_USERNAME=avnadmin
DB_PASSWORD=TU_PASSWORD
```

**Nota**: Laravel funciona perfectamente con PostgreSQL, solo cambia `DB_CONNECTION=pgsql`

### Opción 3: PlanetScale (PostgreSQL)
- ✅ PostgreSQL gratuito
- ✅ Permite conexiones remotas
- ⚠️ **Ya NO ofrece MySQL**, solo PostgreSQL
- **URL**: https://planetscale.com

**Configuración:**
```
DB_CONNECTION=pgsql
DB_HOST=TU_HOST.psdb.cloud
DB_PORT=3306
DB_DATABASE=TU_DATABASE
DB_USERNAME=TU_USERNAME
DB_PASSWORD=TU_PASSWORD
```

### Opción 4: Render PostgreSQL
- ✅ Integrado con Render
- ✅ Muy fácil de configurar
- ⚠️ Solo 90 días gratis, luego $7/mes
- Render conecta automáticamente las variables de entorno

## 🔍 Soluciones por Error

### Solución 1: Error "Access denied" (SkySQL/Railway)

#### 1.1. Verificar Variables de Entorno en Render

**Paso 1**: Ve a tu servicio en Render → **"Environment"**

**Paso 2**: Verifica que estas variables estén correctamente configuradas:

```
DB_CONNECTION=mysql
DB_HOST=serverless-europe-west2.sysp0000.db2.skysql.com
DB_PORT=4050
DB_DATABASE=defaultdb
DB_USERNAME=dbpgf35543126
DB_PASSWORD=E1lc(M7wdRJqxkxvy97Tq8U
```

**⚠️ IMPORTANTE**:
- Verifica que **NO haya espacios** antes o después del `=` en las variables
- Verifica que la contraseña esté **exactamente** como aparece en SkySQL
- Algunos caracteres especiales pueden necesitar ser escapados

**Paso 3**: Si la contraseña tiene caracteres especiales, intenta:
- Copiar la contraseña directamente desde SkySQL
- Si tiene paréntesis `()`, verifica que se copien correctamente

#### 1.2. Configurar Permisos de IP en SkySQL

SkySQL puede requerir que agregues la IP de Render a la lista blanca.

**Paso 1**: Ve a tu panel de SkySQL (app.skysql.com)

**Paso 2**: Busca la sección de **"Network Access"** o **"Allowed IPs"** o **"Firewall"**

**Paso 3**: Agrega la IP de Render: `74.220.48.240`
- O mejor aún, agrega el rango de IPs de Render
- O permite todas las IPs (`0.0.0.0/0`) temporalmente para probar

**Nota**: La IP puede cambiar, así que es mejor permitir todas las IPs o usar un rango.

#### 1.3. Verificar Nombre de Base de Datos

**Paso 1**: En SkySQL, verifica el nombre real de tu base de datos
- Puede ser `defaultdb` o puede tener otro nombre
- Anota el nombre exacto

**Paso 2**: En Render, actualiza la variable `DB_DATABASE` con el nombre correcto

#### 1.4. Configurar SSL (si es requerido)

SkySQL puede requerir conexiones SSL. Agrega estas variables en Render:

```
MYSQL_ATTR_SSL_CA=
DB_SSL_CA=
```

O en el archivo de configuración de Laravel, pero primero intenta sin SSL.

#### 1.5. Verificar Credenciales en SkySQL

**Paso 1**: Ve a SkySQL y verifica:
- Usuario: `dbpgf35543126`
- Contraseña: Copia la contraseña exacta desde SkySQL
- Host: `serverless-europe-west2.sysp0000.db2.skysql.com`
- Puerto: `4050`

**Paso 2**: Prueba conectarte localmente con estas credenciales para verificar que funcionan:
```bash
mysql -h serverless-europe-west2.sysp0000.db2.skysql.com -P 4050 -u dbpgf35543126 -p
```

#### 1.6. Actualizar Variables y Reiniciar

### Solución 2: Error "getaddrinfo failed" (InfinityFree u otros hostings)

**Causa**: El hosting NO permite conexiones remotas desde fuera de su red.

**Solución**: Cambia a una base de datos que permita conexiones remotas:
- Railway MySQL (recomendado)
- Aiven PostgreSQL/MySQL
- PlanetScale PostgreSQL
- Render PostgreSQL

**InfinityFree, 000webhost y similares NO funcionan con Render** porque bloquean conexiones remotas.

### Solución 3: Error "railway.internal failed" (Railway)

**Causa**: Estás usando el hostname interno de Railway (`mysql.railway.internal`) que solo funciona dentro de Railway.

**Solución**:
1. En Railway → Tu servicio MySQL → "Variables"
2. Busca `MYSQLHOST` (hostname público, NO `MYSQLHOSTPRIVATE`)
3. En Render, actualiza `DB_HOST` con el hostname público (termina en `.railway.app`)

**Ejemplo correcto:**
```
DB_HOST=containers-us-west-xxx.railway.app
```

**Ejemplo incorrecto:**
```
DB_HOST=mysql.railway.internal  ❌
```

**Paso 1**: Después de hacer cambios en las variables de entorno en Render
**Paso 2**: Ve a **"Manual Deploy"** → **"Clear build cache & deploy"**
**Paso 3**: Esto reiniciará el servicio con las nuevas variables

## 🔄 Pasos Recomendados para Solucionar Errores

### Si usas SkySQL:
1. ✅ **Verifica las variables de entorno en Render** (sin espacios, contraseña correcta)
2. ✅ **Configura permisos de IP en SkySQL** (permite la IP de Render o todas las IPs)
3. ✅ **Verifica el nombre de la base de datos** en SkySQL y actualiza `DB_DATABASE`
4. ✅ **Reinicia el servicio** en Render (Manual Deploy → Clear cache & deploy)

### Si usas Railway:
1. ✅ **Usa el hostname público** (`MYSQLHOST`), NO el interno (`mysql.railway.internal`)
2. ✅ **Habilita Public Networking** en Railway si es necesario
3. ✅ **Verifica las variables** en Render
4. ✅ **Reinicia el servicio** en Render

### Si usas InfinityFree u otro hosting que no permite conexiones remotas:
1. ✅ **Cambia a Railway, Aiven o PlanetScale** (ver opciones arriba)
2. ✅ **Configura las nuevas credenciales** en Render
3. ✅ **Reinicia el servicio** en Render

## 📝 Checklist

- [ ] Variables de entorno sin espacios antes/después del `=`
- [ ] Contraseña copiada exactamente desde SkySQL
- [ ] IP de Render agregada a la lista blanca en SkySQL
- [ ] Nombre de base de datos verificado y correcto
- [ ] Servicio reiniciado después de cambios

## 🆘 Si nada funciona

1. **Cambia a Railway MySQL** (la opción más fácil y confiable)
2. **O usa Aiven PostgreSQL** (Laravel funciona perfectamente con PostgreSQL)
3. **Verifica que el hosting permita conexiones remotas** (InfinityFree, 000webhost, etc. NO funcionan)

## 💡 Recomendación Final

**Para proyectos en Render, usa Railway MySQL:**
- ✅ Gratis ($5 crédito/mes, suficiente para proyectos pequeños)
- ✅ Muy fácil de configurar
- ✅ Permite conexiones remotas
- ✅ Compatible con Laravel sin cambios

## 📞 Información de Debug

Para obtener más información, puedes agregar temporalmente en Render:

```
APP_DEBUG=true
LOG_LEVEL=debug
```

Esto te dará más detalles del error (recuerda cambiarlo de vuelta a `false` y `error` después).

