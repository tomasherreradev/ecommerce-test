# 🚀 Render.com - Cuando NO aparece "PHP" como opción

## ✅ Solución Rápida

Si en Render.com **NO aparece "PHP"** en las opciones de Environment, tienes 3 opciones:

### Opción 1: Dejar que Render detecte automáticamente (RECOMENDADO) ⭐

1. En **Environment**, selecciona **"Auto-detect"** o simplemente **no seleccionar nada** (déjalo en blanco)
2. Render detectará automáticamente tu archivo `nixpacks.toml` y usará Nixpacks
3. **Build Command**: Déjalo **vacío**
4. **Start Command**: Déjalo **vacío**
5. Render usará automáticamente la configuración de `nixpacks.toml`

### Opción 2: Usar Docker

1. En **Environment**, selecciona **"Docker"**
2. Render detectará automáticamente tu `Dockerfile`
3. **Build Command**: Déjalo **vacío**
4. **Start Command**: Déjalo **vacío**
5. Render construirá usando el Dockerfile

### Opción 3: Usar Nixpacks explícitamente

1. En **Environment**, si aparece **"Nixpacks"**, selecciónalo
2. Render usará tu archivo `nixpacks.toml`
3. **Build Command**: Déjalo **vacío**
4. **Start Command**: Déjalo **vacío**

## 📝 Configuración Recomendada

**Para la mayoría de casos, usa la Opción 1 (Auto-detect):**

```
Environment: (déjalo en blanco o selecciona "Auto-detect")
Build Command: (déjalo vacío)
Start Command: (déjalo vacío)
```

Render detectará automáticamente:
- ✅ Tu archivo `nixpacks.toml`
- ✅ Que es un proyecto Laravel
- ✅ Las dependencias necesarias (PHP 8.2, Composer, Node.js)
- ✅ Los comandos de build y start

## ⚙️ Variables de Entorno

**IMPORTANTE**: No olvides agregar todas las variables de entorno antes de crear el servicio (ver `RENDER_PASOS.md`)

## 🔍 Verificación

Después de crear el servicio:
1. Ve a la pestaña **"Logs"**
2. Verás que Render está usando Nixpacks o Docker
3. El build debería ejecutarse correctamente

## ❓ ¿Qué archivo usa Render?

- Si tienes `nixpacks.toml` → Render usará Nixpacks
- Si tienes `Dockerfile` → Render usará Docker
- Si tienes ambos → Render priorizará Nixpacks (o puedes elegir Docker manualmente)

## ✅ Archivos que ya tienes configurados

- ✅ `nixpacks.toml` - Configuración para Nixpacks
- ✅ `Dockerfile` - Configuración para Docker
- ✅ `render-start.sh` - Script de inicio
- ✅ `railway-start.sh` - Script de inicio alternativo

**¡Todo está listo! Solo deja que Render detecte automáticamente.**

