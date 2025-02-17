# Utiliser une image PHP avec FPM
FROM php:8.0-fpm

# Définir le répertoire de travail
WORKDIR /var/www

# Copier les fichiers du projet dans le conteneur
COPY . .

# Installer les dépendances nécessaires pour Laravel et PostgreSQL
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip git libpq-dev

# Installer les extensions PHP pour PostgreSQL et autres dépendances
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd pdo pdo_pgsql

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Installer les dépendances PHP via Composer
RUN composer install --no-dev --optimize-autoloader

# Exposer le port 80
EXPOSE 80

# Démarrer le serveur PHP-FPM
CMD ["php-fpm"]
