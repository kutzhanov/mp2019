# Dockerfile to setup Apache Load Balancer with the following features:

#	source image is latest amazonlinux;
FROM amazonlinux:2.0.20190823.1

#	image maintainer is defined;
LABEL maintainer="Timur_Kutzhanov@epam.com"

#	install Apache web server;
RUN yum -y install httpd

#	copy Load Balancer configuration;
COPY mod_proxy.conf /etc/httpd/conf.d/

#	port 80 exposed;
EXPOSE 80

#	ensure that Apache service is up and running;
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
