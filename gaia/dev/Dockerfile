FROM mileschou/phalcon:7.4-apache

RUN apt-get update

RUN apt-get install -y default-mysql-client iputils-ping
RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN printf "\n" | pecl install imagick
RUN docker-php-ext-enable imagick

RUN apt-get update
RUN apt-get install -y libzip-dev zip \
  && docker-php-ext-install zip


COPY ./ /var/www/html

# composer installation
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

WORKDIR /var/www/html

# install dependencies
RUN a2enmod rewrite
RUN composer install

# change ownership to www-data
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# ---these packages are required for xhgui (start)---
# install profiler using repository
RUN curl "http://pecl.php.net/get/xhprof-2.3.2.tgz" -fsL -o ./xhprof-2.3.2.tgz && \
    mkdir /var/xhprof && tar xf ./xhprof-2.3.2.tgz -C /var/xhprof && \
    cd /var/xhprof/xhprof-2.3.2/extension && \
    phpize && \
    ./configure && \
    make && \
    make install

# enable profiler    
RUN docker-php-ext-enable xhprof    

# install mongodb extension
RUN pecl install mongodb \
    &&  echo "extension=mongodb.so" > $PHP_INI_DIR/conf.d/mongo.ini
# ---these packages are required for xhgui (end)---
    
#install phpunit
RUN curl --location --output /usr/local/bin/phpunit https://phar.phpunit.de/phpunit-5.7.27.phar

RUN chmod +x /usr/local/bin/phpunit

#install and enable xdebugger
RUN pecl install xdebug-3.1.4 \
    && docker-php-ext-enable xdebug

CMD ["apache2-foreground"]