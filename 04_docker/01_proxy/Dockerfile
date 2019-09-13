# Dockerfile to setup Apache Load Balancer with the following features:

#	source image is latest amazonlinux;
FROM amazonlinux:latest

#	image maintainer is defined;
LABEL maintainer="Timur_Kutzhanov@epam.com"

#	install Apache web server;
RUN yum -y install httpd

#	copy Load Balancer configuration;
COPY mod_proxy.conf /etc/httpd/conf.d/

#	port 80 exposed;
EXPOSE 80

#	ensure that Apache service is up and running;
CMD /usr/sbin/httpd -D FOREGROUND
