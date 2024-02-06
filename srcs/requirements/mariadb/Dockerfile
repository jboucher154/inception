FROM alpine:3.18.6

RUN apk update \
	&& apk add --no-cache \
	mariadb \
	mariadb-client

COPY ./tools/init_mydb.sh /bin/init_mydb.sh

COPY ./conf/my.cnf /etc/my.cnf

RUN chmod +x /bin/init_mydb.sh

EXPOSE 3306

CMD [ "sh", "/bin/init_mydb.sh"]