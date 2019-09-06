# Create Dockerfile to setup Apache Web Server with the following features:
#
# source image is latest amazonlinux;
# image maintainer is defined;
# Apache, php and php-mysql installation happens during the container building process;
# ensure root directory exist;
# copy 'index.php' to root directory;
# copy web server configuration;
# port 8080 exposed;
# ensure that Apache service is up and running;

FROM amazonlinux:latest
LABEL maintainer="Timur_Kutzhanov@epam.com"

RUN yum update -y && yum install -y \
httpd \
php \
php-mysql \
&& yum clean all

WORKDIR /var/www/mp2019/

COPY index.php /var/www/mp2019/
RUN chmod 644 /var/www/mp2019/index.php

COPY httpd.conf /etc/httpd/conf.d/

EXPOSE 8080

CMD /usr/sbin/httpd -D FOREGROUND
