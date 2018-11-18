USE mysql;
SHOW  PROCEDURE STATUS; #pro_y ;
	#查看存储过程
SHOW PROCEDURE STATUS  LIKE "pro_y";
	#函数信息
SHOW FUNCTION  STATUS LIKE "fu_y";

#MariaDB [information_schema]> select * from  ROUTINES\G;
	#系统表的存储过程
USE mysql;
SHOW CREATE   FUNCTION  fu_y ;	#函数的简要信息
SHOW CREATE  PROCEDURE pro_y;	#存储过程的简要信息

		/*事务*/
#创建一个表格，为事务提供条件
CREATE TABLE tb_r
(
id INT,
NAME CHAR(10)
);
INSERT INTO tb_r VALUES(1,"a");
BEGIN;		#开始事务
SELECT * FROM tb_r;
UPDATE tb_r SET NAME="b" WHERE id=1;
COMMIT;		#提交事务
DELETE FROM tb_r WHERE NAME=id;
ROLLBACK;	#回滚事务

#修改id字段
BEGIN;	
ALTER  TABLE tb_r MODIFY NAME VARCHAR(10);
COMMIT;
ALTER  TABLE tb_r MODIFY NAME CHAR(10);
ROLLBACK;
DESC tb_r;

			#不可读事务
#A事务
BEGIN;	#开始
SELECT  * FROM tb_r;
#B事务
BEGIN;
UPDATE tb_r SET id=id*2 WHERE NAME="b";
#
SELECT  * FROM tb_r;
#B事务回滚
ROLLBACK;
#A事务脏读
SELECT  * FROM tb_r;
			#不可重复读事务
			
#A事务
SELECT * FROM tb_r;
#B事务
UPDATE  tb_r SET id=id*2 WHERE NAME="b";
#开始A事务
SELECT * FROM tb_r;
#开始B事务
BEGIN;
#B事务提交
COMMIT;
#A事务状态
SELECT * FROM tb_r;
			#隐式提交

#A事务状态
SELECT * FROM tb_r;
#B事务开始
BEGIN;
#B事务DDL语句
UPDATE tb_r SET id=1 WHERE NAME="b";
#COMMIT
#A事务中间状态
SELECT * FROM tb_r;#A事务状态
#除DDL语句触发B事务自动提交
ALTER TABLE tb_r  ADD sex CHAR(10);
#A事务结束状态
SELECT * FROM tb_r;#A事务状态


		#锁机制
#A,B事务开始
BEGIN;	
#A,B事务同时为表单更新id字段
UPDATE tb_r SET id=2*3 WHERE NAME="b";
UPDATE tb_r SET id=2*4 WHERE NAME="b";
#同时提交A,B事务
COMMIT;
#查看A事状态遭到锁机制
SELECT * FROM tb_r;

	#create创建用户
CREATE USER u1@localhost IDENTIFIED BY "123";
	#inset into创建用户
USE mysql;
INSERT INTO USER(HOST,USER,PASSWORD)VALUES("localhost","u2","123");

FLUSH PRIVILEGES;
	#授权并创建用户
GRANT ALL ON   PRIVILEGES mysql.*  TO u3@localhost IDENTIFIED BY "123";
		#修改root密码
#grant select ,show on *.* to "u3"@"localhost" identified by "123";

SET  PASSWORD FOR "u3"@"localhost"=PASSWORD("123");

			#为普通用户创建密码
SET PASSWORD=PASSWORD("123");	
USE mysql;
UPDATE  mysql.user SET PASSWORD=PASSWORD("456")
	WHERE HOST="localhost" AND USER="u3";
SELECT  PASSWORD ,USER FROM  USER;

DROP USER u2@localhost;	#删除用户

CREATE USER u2@localhost;
 
DELETE FROM  mysql.user 
	WHERE USER="u2" AND h7ost="localhost"
	

SELECT * FROM USER;
GRANT  SELECT ON *.* TO u2@localhost  IDENTIFIED BY "123";

		  #作用在所有的表上
SHOW GRANTS FOR u1@localhost;
		#查看用户权限
		

REVOKE SELECT ON  *.* FROM u1@localhost ;
			#回收用户权限
REVOKE ALL PRIVILEGES,GRANT OPTION
	ON *.* FROM u1@localhost;
			
	
#mysqlbinlog :mysql二进制日志


RESET MASTER;   #删除二进制日志

	
SET GLOBAL general_log=ON; #开启通用查询日志

SHOW VARIABLES;    #查看环境变量
				#开启慢查询日志
SET GLOBAL  slow_log=ON;

SELECT * FROM tb_x INTO OUTFILE /home/tb_x;
				#导出表格\

SHOW PROCESSLIST;		#进程
KILL 59;			#中断进程
