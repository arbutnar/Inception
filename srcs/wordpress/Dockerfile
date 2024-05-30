FROM debian:buster

RUN apt-get -y update && apt-get -y upgrade \
	&& apt-get -y install -y php7.3 \
	php-mysqli \
	php-fpm \
	wget \
	curl \
	mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

COPY tools/www.conf /etc/php/7.3/fpm/pool.d

RUN mkdir -p /run/php
RUN touch /run/php/php7.3-fpm.pid

WORKDIR /var/www/html/

RUN chown -R www-data /var/www/html \
	&& chmod -R 775 /var/www/html

COPY tools/script.sh /usr/local/bin/
RUN chmod 775 /usr/local/bin/script.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/script.sh"]
