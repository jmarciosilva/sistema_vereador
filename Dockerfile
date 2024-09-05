  # Use a imagem base do PHP com Apache
  FROM php:8.2-apache
  
  # Instala dependências necessárias
  RUN apt-get update && apt-get install -y \
      libpng-dev \
      libjpeg-dev \
      libfreetype6-dev \
      zip \
      unzip \
      && docker-php-ext-configure gd --with-freetype --with-jpeg \
      && docker-php-ext-install gd \
      && docker-php-ext-install pdo pdo_mysql \
      && apt-get install -y curl git \
      && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
  
  # Ajuste as permissões da pasta html
  RUN chown -R www-data:www-data /var/www/html \
      && chmod -R 777 /var/www/html
  
  
  # Exponha a porta 8080
  EXPOSE 8080 
  
  # Inicie o servidor Apache
  CMD ["apache2-foreground"]