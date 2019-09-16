# Dockerfile to setup Apache Web Server with the following features:

# source image is latest amazonlinux;
FROM amazonlinux:2.0.20190823.1

# image maintainer is defined;
LABEL maintainer="Timur_Kutzhanov@epam.com"

# Apache, php and php-mysql installation happens during the container building process;
RUN yum update -y && yum install -y \
httpd \
php \
php-mysqlnd \
&& yum clean all

# ensure root directory exist;
WORKDIR /var/www/mp2019/

# copy 'index.php' to root directory;
COPY index.php /var/www/mp2019/
RUN chmod 644 /var/www/mp2019/index.php

# copy web server configuration;
COPY httpd.conf /etc/httpd/conf/

# port 8080 exposed;
EXPOSE 8080

# ensure that Apache service is up and running;
CMD /usr/sbin/httpd -D FOREGROUND
