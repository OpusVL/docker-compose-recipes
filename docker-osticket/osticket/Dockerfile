FROM php:7.0-fpm

RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
		libjpeg-dev \
		libpng-dev \
		zlib1g-dev \
		libicu-dev \
		g++ \
		libkrb5-dev \
		libc-client-dev \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-configure imap --with-kerberos --with-imap-ssl; \
	docker-php-ext-configure intl; \
	docker-php-ext-install gd mysqli imap intl opcache

RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

VOLUME /var/www/html

ENV OSTICKET_VERSION 1.10.4

RUN set -ex; \
	curl -o osticket.tar.gz -fSL "https://github.com/osTicket/osTicket/archive/v${OSTICKET_VERSION}.tar.gz"; \
	tar -xzf osticket.tar.gz -C /usr/src/; \
	rm osticket.tar.gz; \
	chown -R www-data:www-data /usr/src/osTicket-${OSTICKET_VERSION}

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
