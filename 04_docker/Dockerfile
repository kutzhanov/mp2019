# Create Apache Load Balancer configuration which will balance traffic between 'web' service containers by Round Robin method.
#
# Create Dockerfile to setup Apache Load Balancer with the following features:
# 	source image is latest amazonlinux;
# 	image maintainer is defined;
# 	install Apache web server;
# 	copy Load Balancer configuration;
# 	port 80 exposed;
# 	ensure that Apache service is up and running;

FROM amazonlinux:latest

LABEL maintainer="Timur_Kutzhanov@epam.com"

RUN yum -y install httpd

#COPY mod_proxy.conf /etc/httpd/conf.modules.d/
COPY mod_proxy.conf /etc/httpd/conf.d/

EXPOSE 80

CMD /usr/sbin/httpd -D FOREGROUND
