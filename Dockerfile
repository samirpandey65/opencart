# Use the official PHP image as a base
FROM php:7.4-apache

# Set the working directory to the Apache root directory
WORKDIR /var/www/html

# Install required dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libonig-dev \
    libzip-dev \
    curl \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli pdo pdo_mysql zip opcache

# Enable Apache rewrite module
RUN a2enmod rewrite

# Clone your GitHub repository (replace with your repo link)
RUN git clone https://github.com/yourusername/your-opencart-repo.git /var/www/html

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
