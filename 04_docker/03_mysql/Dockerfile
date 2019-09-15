# Dockerfile to setup MySQL Server with the following features

# source image is latest amazonlinux;
FROM amazonlinux:2.0.20190823.1

# image maintainer is defined;
LABEL maintainer="Timur_Kutzhanov@epam.com"

# install latest version of MySQL 8;
RUN wget https://repo.mysql.com/mysql80-community-release-el7-1.noarch.rpm
RUN yum localinstall mysql80-community-release-el7-1.noarch.rpm -y
RUN yum install mysql-community-server -y

RUN mkdir /docker-entrypoint-initdb.d

# use entrypoint.sh as entrypoint(!!! Do not forget make it executable);
COPY docker-entrypoint.sh /usr/local/bin/
RUN c /usr/local/bin/docker-entrypoint.sh
RUN ln -s /usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]

# port 3306 exposed;
EXPOSE 3306

# ensure that MySQL service is up and running;
CMD ["mysqld"]
# CMD ["run-mysqld"]
