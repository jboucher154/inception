FROM alpine:3.18.6

WORKDIR /etc/nginx/

RUN apk update && \
	apk --no-cache add openssl

RUN apk update && \
	apk add --no-cache nginx && \
	addgroup -S www && \
	adduser -S -H -g "" www -G www && \
	mkdir -p /var/www/html && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /var/lib/nginx/tmp && \
	chown -R www:www /var/lib/nginx/html && \
	chown -R www:www /var/www/html

RUN mkdir ./ssl && \
	openssl req -x509 -newkey rsa:4096 \
	-keyout ./ssl/jebouche.key -sha256 -days 365 -nodes \
	-out ./ssl/jebouche.crt \
	-subj "/C=FI/ST=Helsinki/L=Helsinki/O=42 School/OU=jebouche/CN=jebouche.42.fr"

COPY ./conf/wordpress.conf ./http.d/default.conf

RUN sed -i 's/user nginx/user www www/' nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

