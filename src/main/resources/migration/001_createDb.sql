create database db_example; -- Creates the new database
create user 'testuser'@'%' identified by 'password'; -- Creates the user
grant all on db_example.* to 'testuser'@'%'; -- Gives all privileges to the new user on the newly created database