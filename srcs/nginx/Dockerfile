FROM debian:buster

RUN apt-get -y update \
	&& apt-get -y install nginx \
	openssl

RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-subj "/C=IT/ST=Rome/L=Rome/O=42School/OU=arbutnar/CN=arbutnar"

COPY ./tools/default etc/nginx/sites-enabled/default

RUN mkdir -p /run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
