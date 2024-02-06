FROM alpine:3.18.6

RUN apk update \
	&& apk add --no-cache \
	php81 \
	php81-fpm \
	php81-mysqli \
	php81-phar \
	wget

# command line tools for wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp

RUN chmod +x /usr/local/bin/wp

# RUN script for wordpress install ad CMD (should clt for wp be done in here?)

EXPOSE 9000

# temp inf loop script to allow testing in image
COPY ./tools/test.sh /bin/test.sh
# CMD run the stuffs
CMD [ "sh", "/bin/test.sh" ]