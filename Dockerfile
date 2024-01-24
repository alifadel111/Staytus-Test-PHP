
# Use the official PHP base image
FROM php:8.2-cli

# # Set the working directory
 WORKDIR /var/www/html

# # Install dependencies
 RUN apt-get update && apt-get install -y \
     libonig-dev \
     libzip-dev \
     unzip \
     && docker-php-ext-install pdo_mysql zip

# # Install Composer
 RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# # Copy the code into the container
 COPY . /var/www/html

# # Set permissions
 RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# # Set up Laravel environment
 RUN mv .env.example .env

# RUN php artisan key:generate

 # Expose port 8000 (PHP's built-in server default port)
 EXPOSE 8000

# # Start PHP's built-in server
 CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]# 