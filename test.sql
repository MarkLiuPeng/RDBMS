DATABASE CHANGED
MariaDB [mysql]> GRANT ALL  PRIVILEGES  ON mysql.* TO root@'%' IDENTIFIED BY '123';
QUERY OK, 0 ROWS affected (0.02 sec)
							//为特定数据库授予远程访问权限
MariaDB [mysql]> 
MariaDB [mysql]> 
MariaDB [mysql]> `mysql`
MariaDB [mysql]> 
MariaDB [mysql]> FLUSH  PRIVILEGES;				//刷新权限信息
QUERY OK, 0 ROWS affected (0.00 sec)
