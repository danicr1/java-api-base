FROM mysql:8.2.0

ENV MYSQL_ROOT_PASSWORD rootpass
ENV MYSQL_DATABASE db_example
ENV MYSQL_USER testuser
ENV MYSQL_PASSWORD password1234

# Files with extensions .sh, .sql and .sql.gz that are found in /docker-entrypoint-initdb.d  will be executed in alphabetical order.
#ADD ../../src/main/resources/migration/001_createDb.sql /docker-entrypoint-initdb.d

EXPOSE 3306