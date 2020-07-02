FROM mysql: 8.0
COPY my.cnf /etc/my.cnf
EXPOSE 3306 33060
CMD ["mysqld"]