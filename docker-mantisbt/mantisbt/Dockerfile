FROM php:7.1-fpm

RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
		libjpeg-dev \
		libpng-dev \
		libpq-dev \
		libldap2-dev \
		libxml2-dev \
                git \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-configure ldap --with-libdir=/lib/x86_64-linux-gnu; \
	docker-php-ext-install gd pgsql mysqli soap opcache ldap zip

RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

VOLUME /var/www/html

ENV MANTISBT_VERSION 2.24.1
ENV MANTISBT_SHA1 fa452e391efe054bd225df45afb37e55b39b5e19

RUN set -ex; \
	curl -o mantisbt.tar.gz -fSL "https://github.com/mantisbt/mantisbt/archive/release-${MANTISBT_VERSION}.tar.gz"; \
        echo "$MANTISBT_SHA1 *mantisbt.tar.gz" | sha1sum -c -; \
	tar -xzf mantisbt.tar.gz -C /usr/src/; \
	rm mantisbt.tar.gz; \
	chown -R www-data:www-data /usr/src/mantisbt-release-${MANTISBT_VERSION}

WORKDIR /usr/src/mantisbt-release-${MANTISBT_VERSION}

RUN curl -sS https://getcomposer.org/installer | php \
    && php composer.phar install

WORKDIR /var/www/html

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
CMD ["php-fpm"]