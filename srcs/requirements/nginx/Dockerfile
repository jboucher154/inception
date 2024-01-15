FROM alpine:3.18.5

WORKDIR /app

# COPY install scripts from tools?

RUN apk update && \
	apk add nginx && \
	adduser -D -g 'www' www && \
	mkdir /www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www

EXPOSE 443

RUN rm /etc/nginx/*.conf

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./tools /www

CMD ["nginx", "-g", "daemon off;"]

# https://www.cyberciti.biz/faq/how-to-install-nginx-web-server-on-alpine-linux/
# https://stackoverflow.com/questions/65627946/how-to-start-nginx-server-within-alpine-image-using-rc-service-command
