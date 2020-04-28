FROM php:7.3-apache
RUN docker-php-ext-install mysqli
COPY . /var/www/html 


RUN sed -i 's/80/${PORT}/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"


