FROM alpine:3.18.6

RUN apk update \
	&& apk add --no-cache \
	mariadb \
	mariadb-client

COPY ./tools/init_mydb.sh /bin/init_mydb.sh


COPY ./conf/my.cnf /etc/my.cnf
# COPY ./conf/my.cnf /etc/my.cnf.d/my.cnf

RUN chmod +x /bin/init_mydb.sh \
	&& sh /bin/init_mydb.sh

# COPY ./tools/test.sh /bin/test.sh

# RUN chmod +x /bin/test.sh

EXPOSE 3306

CMD ["mysqld_safe", "--defaults-file=/etc/my.cnf"]
# CMD [ "sh", "/bin/test.sh"]