FROM ubuntu:14.04

RUN apt-get -y update && apt-get install -y wget
ENV DEBIAN_FRONTEND=noninteractive
RUN wget http://dev.mysql.com/get/mysql-apt-config_0.7.3-1_all.deb
RUN dpkg -i mysql-apt-config_0.7.3-1_all.deb
RUN apt-get -y update && apt-get install -y --force-yes mysql-server
COPY ejabberd.sql /ejabberd.sql
COPY updatemysql.sh /updatemysql.sh
COPY my.cnf /etc/mysql/
RUN chmod 755 /etc/mysql/my.cnf
RUN chmod 755 /updatemysql.sh
EXPOSE 3306
RUN service mysql start && /updatemysql.sh && service mysql stop
COPY run.sh /run.sh
RUN chmod 755 /run.sh
ENTRYPOINT ["/run.sh"]

