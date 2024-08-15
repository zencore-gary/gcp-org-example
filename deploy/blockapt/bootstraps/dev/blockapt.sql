REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'blockapt-dev-master'@'%';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'blockapt-dev-socket'@'%';
GRANT ALL PRIVILEGES ON blockapt.* TO 'blockapt-dev-master'@'%';
GRANT ALL PRIVILEGES ON blockapt.* TO 'blockapt-dev-socket'@'%';
FLUSH PRIVILEGES;
