#!/bin/sh

if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else
	#Download wordpress and all config file
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	#Inport env variables in the config file
	sed -i "s/username_here/${MYSQL_USER}/g" wp-config-sample.php
	sed -i "s/password_here/${MYSQL_USER_PASSWORD}/g" wp-config-sample.php
	sed -i "s/localhost/${MYSQL_HOST}/g" wp-config-sample.php
	sed -i "s/database_name_here/${MYSQL_DATABASE_NAME}/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php
    
    wp core download --allow-root
    wp core install --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USR} --admin_password=${WP_ADMIN_PWD} --admin_email=${WP_ADMIN_EMAIL} --allow-root
    wp user create ${WP_USER_USR} ${WP_USER_EMAIL} --role=author --user_pass=${WP_USER_PWD} --allow-root
    wp theme install inspiro --activate --allow-root
fi

exec /usr/sbin/php-fpm7.3 -F
