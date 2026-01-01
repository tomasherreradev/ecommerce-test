FROM php:8.2-cli

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nodejs \
    npm \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establecer directorio de trabajo
WORKDIR /var/www/html

# Copiar archivos de dependencias
COPY composer.json composer.lock ./
COPY package.json package-lock.json ./

# Instalar dependencias de PHP
RUN composer install --no-scripts --no-autoloader

# Instalar dependencias de Node
RUN npm install

# Copiar el resto de los archivos
COPY . .

# Completar instalación de Composer
RUN composer dump-autoload --optimize

# Compilar assets con Vite
RUN npm run build

# Crear enlace simbólico de storage
RUN php artisan storage:link || true

# Configurar permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage \
    && chmod -R 755 /var/www/html/bootstrap/cache

# Exponer puerto (Render usa la variable $PORT)
EXPOSE 8000

# Script de inicio
COPY render-start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/render-start.sh

# Comando de inicio
CMD ["/usr/local/bin/render-start.sh"]

