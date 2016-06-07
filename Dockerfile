FROM ubuntu:14.04

RUN apt-get update && apt-get install -y wget
ENV DEBIAN_FRONTEND=noninteractive
RUN wget http://dev.mysql.com/get/mysql-apt-config_0.7.3-1_all.deb
RUN dpkg -i mysql-apt-config_0.7.3-1_all.deb
RUN apt-get update
RUN apt-get install -y mysql-server
COPY ejabberd.sql /ejabberd.sql
COPY updatemysql.sh /updatemysql.sh
COPY my.cnf /etc/mysql/
RUN chmod 755 /etc/mysql/my.cnf
RUN chmod 755 /updatemysql.sh
EXPOSE 3306
RUN service mysql start && /updatemysql.sh && service mysql stop
#ENTRYPOINT service mysql start && tail -f /dev/null
COPY run.sh /run.sh
RUN chmod 755 /run.sh
ENTRYPOINT ["/run.sh"]

