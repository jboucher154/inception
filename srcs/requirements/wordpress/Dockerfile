FROM alpine:3.18.6

ARG hello=world

ENV h2=${hello}

# apk --no-cache add php82 php82-fpm php82-mysqli php82-mbstring curl libcurl php82-curl libzip php82-zip php82-phar

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
	wget

# command line tools for wordpress, may not need wget anymore
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

RUN chmod +x /usr/local/bin/wp

RUN mkdir -p /var/www/html

# WORKDIR /var/www/html

# RUN wp core download --allow-root 

EXPOSE 9000

# temp inf loop script to allow testing in image
COPY ./tools/test.sh /bin/test.sh
# CMD run the stuffs
CMD [ "sh", "/bin/test.sh" ]