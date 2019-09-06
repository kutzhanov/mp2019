# Create Dockerfile to setup MySQL Server with the following features:
#
# source image is latest amazonlinux;
# image maintainer is defined;
# install latest version of MySQL 8;
# use entrypoint.sh as entrypoint(!!! Do not forget make it executable);
# port 3306 exposed;
# ensure that MySQL service is up and running;

FROM amazonlinux:latest
LABEL maintainer="Timur_Kutzhanov@epam.com"

RUN wget https://repo.mysql.com/mysql80-community-release-el7-1.noarch.rpm
RUN yum localinstall mysql80-community-release-el7-1.noarch.rpm
RUN yum install mysql-community-server

#RUN mkdir /docker-entrypoint-initdb.d

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
