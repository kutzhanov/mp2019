# Dockerfile to setup MySQL Server with the following features

# source image is latest amazonlinux;
FROM amazonlinux:2.0.20190823.1

# image maintainer is defined;
LABEL maintainer="Timur_Kutzhanov@epam.com"

# install latest version of MySQL 8;
RUN curl "https://repo.mysql.com/mysql80-community-release-el7-1.noarch.rpm" -o mysql80-community-release-el7-1.noarch.rpm
RUN yum localinstall mysql80-community-release-el7-1.noarch.rpm -y
RUN yum install mysql-community-server -y

COPY mysql_user /run/secrets/mysql_user
COPY mysql_pass /run/secrets/mysql_pass
COPY mysql_root_pass /run/secrets/mysql_root_pass
COPY mysql_db /run/secrets/mysql_db

ENV MYSQL_USER_FILE="/run/secrets/mysql_user"
ENV MYSQL_PASSWORD_FILE="/run/secrets/mysql_pass"
ENV MYSQL_ROOT_PASSWORD_FILE="/run/secrets/mysql_root_pass"
ENV MYSQL_DATABASE_FILE="/run/secrets/mysql_db"

# use entrypoint.sh as entrypoint(!!! Do not forget make it executable);
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 755 /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# port 3306 exposed;
EXPOSE 3306

# ensure that MySQL service is up and running;
CMD ["mysqld"]
