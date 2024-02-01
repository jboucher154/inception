FROM alpine:3.18.5

RUN apk update && \
	apk add --no-cache add \
	mariadb \
	mariadb-client

COPY ./conf/my.cnf /etc/my.cnf

EXPOSE 3306

# CMD [ "executable" ]