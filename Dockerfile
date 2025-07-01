# You can change this to a newer version of MySQL available at
# https://hub.docker.com/r/mysql/mysql-server/tags/
FROM mysql/mysql-server:8.4.5

COPY initdb/init.sql /docker-entrypoint-initdb.d/
COPY config/user.cnf /etc/mysql/my.cnf
