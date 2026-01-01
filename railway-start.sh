#!/bin/bash
set -e

echo "🚀 Iniciando aplicación Laravel en Railway..."

# Limpiar configuración cacheada
echo "📦 Limpiando configuración..."
php artisan config:clear

# Ejecutar migraciones
echo "🗄️  Ejecutando migraciones..."
php artisan migrate --force

# Ejecutar seeders (solo si la variable RUN_SEEDERS está configurada o si es el primer despliegue)
if [ "$RUN_SEEDERS" = "true" ] || [ ! -f "/tmp/.seeders-run" ]; then
    echo "🌱 Ejecutando seeders..."
    php artisan db:seed --force && touch /tmp/.seeders-run || echo "⚠️  Advertencia: Los seeders pueden haber fallado o ya se ejecutaron"
else
    echo "⏭️  Saltando seeders (ya ejecutados anteriormente)"
fi

# Cachear configuración
echo "⚡ Cacheando configuración..."
php artisan config:cache

# Iniciar servidor
echo "🌐 Iniciando servidor en puerto $PORT..."
php artisan serve --host=0.0.0.0 --port=$PORT

