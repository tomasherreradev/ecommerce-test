#!/bin/bash
set -e

echo "🚀 Iniciando aplicación Laravel en Render..."

# Limpiar configuración cacheada
echo "📦 Limpiando configuración..."
php artisan config:clear || echo "⚠️  Error al limpiar configuración"

# Ejecutar migraciones
echo "🗄️  Ejecutando migraciones..."
php artisan migrate --force || echo "⚠️  Error al ejecutar migraciones"

# Ejecutar seeders
echo "🌱 Ejecutando seeders..."
if php artisan db:seed --force; then
    echo "✅ Seeders ejecutados correctamente"
else
    echo "❌ ERROR: Los seeders fallaron. Revisa los logs arriba."
fi

# Cachear configuración
echo "⚡ Cacheando configuración..."
php artisan config:cache || echo "⚠️  Error al cachear configuración"

# Iniciar servidor
echo "🌐 Iniciando servidor en puerto $PORT..."
php artisan serve --host=0.0.0.0 --port=$PORT

