FROM php:7.1-fpm

RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
		libjpeg-dev \
		libpng-dev \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-install gd pdo_mysql mysqli opcache

RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

VOLUME /var/www/html

ENV WEBTREES_VERSION 1.7.9

RUN set -ex; \
	curl -o webtrees.tar.gz -fSL "https://github.com/fisharebest/webtrees/archive/${WEBTREES_VERSION}.tar.gz"; \
	tar -xzf webtrees.tar.gz -C /usr/src/; \
	rm webtrees.tar.gz; \
	chown -R www-data:www-data /usr/src/webtrees-${WEBTREES_VERSION}

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
