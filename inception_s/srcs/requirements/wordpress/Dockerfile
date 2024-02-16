FROM alpine:3.18.6

RUN apk update \
	&& apk add --no-cache \
	php81 \
	php81-fpm \
	php81-mysqli \
	php81-phar \
	php81-mbstring \
	curl \
	libcurl \
	php81-curl \
	libzip \
	php81-zip \
	wget \
	&& addgroup -S www \
	&& adduser -S -H -g "" www -G www

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

RUN chmod +x /usr/local/bin/wp

RUN mkdir -p /var/www/html /run/php/

EXPOSE 9000

COPY ./tools/entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

COPY ./conf/www.conf	/etc/php81/php-fpm.d/www.conf

ENTRYPOINT [ "/bin/entrypoint.sh" ]

