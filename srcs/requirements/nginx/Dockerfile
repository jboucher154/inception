FROM alpine:3.18.5

WORKDIR /etc/nginx/

# COPY install scripts from tools?
RUN apk --no-cache add openssl

RUN apk update && \
	apk add nginx && \
	adduser -D -g 'www' www && \
	mkdir /www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www

RUN mkdir ./ssl && \
	openssl req -x509 -newkey rsa:4096 \
	-keyout ./ssl/jebouche.key -sha256 -days 365 -nodes \
	-out ./ssl/jebouche.crt \
	-subj "/C=FI/ST=Helsinki/L=Helsinki/O=42 School/OU=jebouche/CN=jebouche.42.fr"

EXPOSE 443

RUN rm *.conf

COPY ./conf/nginx.conf nginx.conf

COPY ./tools /www

CMD ["nginx", "-g", "daemon off;"]

# https://www.cyberciti.biz/faq/how-to-install-nginx-web-server-on-alpine-linux/
# https://stackoverflow.com/questions/65627946/how-to-start-nginx-server-within-alpine-image-using-rc-service-command
