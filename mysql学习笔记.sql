		/*mysql学习笔记整理*/
	
		/*常用的数据库操作对象*/
	
	#库的操作
#创建
#数据库的创建
USE mysql;
CREATE DATABASE db_x;
#删除
#删除数据库
DROP DATABASE db_x;
#删除数据库
#查看
SHOW DATABASES;
#查看数据库
#备份和还原
#备份|还原数据库
mysqldump -u root -p {mysql|--all-DATABASE|--database}[><]{DIRECTORY}
	#表的操作
#创建
#表格的创建
CREATE TABLE tb_x
(
id INT NOT NULL,  
NAME CHAR(10)
);



	/*数据类型和约束*/	
完整约束{NOT NULL:非空约束;UNIQUE:UK:唯一性约束;PRIMARY KEY:PK:主键约束;
AUTO_INCREMENT:自动增长约束;FOREIGN KEY:FK:外键约束,check:CK:检查约束}
CONSTRAINT {PK|FK|UK_tb_name}(column_name):约束名;
PK_FK_UK(column_name1,column_name2):联合约束;
fk(column_name)REFERENCES tb_2(column_name):外键联合

	#表的操作

#删除
#删除表格
DROP TABLE tb_x;
#查看
#查看表格的字段
DESCRIBE tb_xx;
#修改
#表格的修改{rename:重命名表名,add{first(首行);after(字段之后);
#增加字段}
ALTER TABLE tb_x RENAME  tb_xx;
ALTER TABLE tb_xx ADD num VARCHAR(20) FIRST;
ALTER TABLE tb_xx ADD weather CHAR(10) AFTER id ;
#删除表格字段
ALTER TABLE tb_xx DROP weather ;
#修改表格字段数据类型和字段名称{modify(修改和移动字段位置),change}
ALTER TABLE tb_xx MODIFY num  INT;
ALTER TABLE tb_xx MODIFY id INT FIRST;
ALTER TABLE tb_xx MODIFY id INT   AFTER number;
ALTER TABLE tb_xx CHANGE num number  CHAR(10);

	#索引的操作
#创建
#法一:在创建表格的同时，把索引当成字段
INDEX index_name(column_name);
#法二:在库里有这张表的基础上,索引字段
CREATE INDEX index_name ON table_name(column_name);
#法三:把索引同修改表格字段的方式，去映射字段的索引
ALTER TABLE table_name ADD inedx index_name(column_name);
#索引种类
#唯一索引
UNIQUE INDEX index_name;
#全文索引
FULLTEXT INDEX index_name;
#多列索引
INDEX index_name(column_name1,column_name2,......column_namen)
#删除
#删除索引
DROP INDEX index_name;
	#视图的操作
#创建
#创建视图
CREATE VIEW view_name
	AS     #别名
		sql_parmament;	#{这里封装的是查询语句}

#删除
#删除视图
DROP  VIEW  view_name
#修改
#覆盖视图
CREATE  OR REPLACE VIEW view_name
	AS
		new_sql_parmament;
#修改视图
ALTER VIEW view_name
	AS
		new_sql_parmament;
	
#索引同表格相同可执行select和insert及update和delete

		#存储过程的操作
#存储过程的创建
DELIMITER $$
	CREATE PROCEDURE procedure_name()
		{COMMENT|}		#动作
		BEGIN
			sql_parmanment;
		END$$
DELIMITER;
#修改存储过程
ALTER PROCEDURE procecure_name
	{COMMENT|}		

#删除存储过程
DROP PROCEDURE procedure_name;

		#函数的操作
#创建函数
DELIMITER $$			#结束表示符
	CREATE FUNCTION function_name() #---->数据类型
		RETURNS new_type;	#--->新数据类型
			{COMMENT|}	#动作	
			BEGIN				
				RETURN(
					sql_parment;
					)
			END$$
DELIMITER;
#修改存储过程
ALTER FUNCTION function_name
#删除存储过程
DROP FUNCTION finction_name
	
		#触发器的操作

#触发器的创建
#单个动作
CREATE  TRIGGER tri_x
	BEFORE INSERT		#动作的执行前后
		ON tb_x FOR EACH ROW  #是不是要立即触发
			INSERT INTO tb_y VALUES(1,"a"); #触发动作
		
#多个动作
DELIMITER $$
	CREATE TRIGGER tri_y
	  AFTER INSERT
		BEGIN
			ON tb_x FOR EACH ROW
				INSERT INTO tb_y VALUES(1,"a");
		END&&
DELIMITER;


		/*{update,delete,insert 等语句}*/
#更新字段
UPDATE  table_name SET COLUMN=new_column;
#删除|不加where，删除全部
DELETE FROM table_name {WHERE sql_if_else};	#条件语句
#插入
INSERT INTO table_name VALUES(values_1,values_2,....values_n),(,,,);
insert into table_name1 select coulumn_name	 from table_name2
		
		/*函数及如何准确高效的select*/
#运算符
#1:算数运算符:{+,-，*，/};
#2:比较运算符:{>,<,<>,<=>,!=}
#3:特殊比较运算符:正则匹配REGEXP 
/*{"o$"	#结尾   "^h"	#开头  "[h..o]"	#字符中间

"[a-b]"   #范围 "[^g~z]"  #范围之外 "h+o"     #字符包含

 "h*o" "h|e|o"   #存在 "l{2}"  #出现次数 "1{0,2}";*/
 
#4:逻辑运算符:{||(or),&&(and),xor,!}
#5:位运算符:{|,&,^,~,>>,<<}
#6:模糊运算符:not |in(),between and,null | not null,like ,;


#条件查询
GROUP BY(columan_name);
HAVING :现状分组查询;
UNION ALL:联合表格{all不排除重复};
ORDER BY DESC|ASC:排序{降序|升序};
LIMIT:限制行数;
DISTINCT:排除重复;


#多表连接
法一:
{内连接,外连接，左连接，右连接}
{INNER|OUT|LEFT|RIGHT|JOIN   table_name   
ON  table_name1.column_1=table_name2.column_1;
 法二:
 SELECT table1_name.column1_name,table2_name.column2_name
	FROM table1_name,table2_name
		WHERE table1_name.column1=table2_name.column2
		
#子查询
SELECT column_name FROM table_name WHERE column_name{运算符}
	#运算符{>,<,=,in,any.....}
	(
		SELECT column_name FROM table_name
		);

#函数
#字符串函数
#1:{concat():连接字符串,concat_ws():条件分割连接字符串}	
#2:{strcmp():比较字符串大小;length()&&char_length():字符串长度}
#3:{upper&&ucase:字符转大写;lower&&lcase:字符转小写}
#4:{find_in_set(),locate(),position(),filed(),insert():查找字符串的位置}
#5::{elt():指定要显示特定字符串位置,make_set():按二进制匹配};
#6:{left():左截取;right():右截取;substring(),med():按位置和长度截取}
#7:{ltrim(),trim():处理字符串中的空格}
#8:{insert():替换指定位置的字符}
#9:{replace():字符替换函数}
#数学函数
#{fllor(),cell(),trucate(),round()};
#日期函数
#{now(),current_date(),current_time()}
#datediff():计算日期差
#系统函数
#VERSION() "系统版本",USER() "登陆用户";
#LAST_INSERT_ID()执行系统函数获取最后自增的id字段号
#其它函数
#INET_ATON("127.0.0.1")"ip地址转数字";
#INET_NTOA("1230133112")"数字转ip地址";
		
		/*用户及权限的管理*/
#用户的创建
#法一:create
CREATE USER u5@localhost IDENTIFIED BY "123";
#法二:insert
INSERT INTO USER(HOST,USER,PASSWORD)VALUES("localhost","u6",123);
#法三:grant
GRANT ALL PRIVILEGES ON *.* TO u7@localhost  IDENTIFIED BY "123";
#查看创建的用户
USE mysql;
SELECT * FROM USER;
#删除用户
#法一:drop
DROP USER u6@localhost;
#法二:delete
DELETE FROM mysql.user WHERE USER="u4" AND HOST="localhost";
#为用户设置密码
#法一:SET
SET  PASSWORD FOR "u3"@"localhost"=PASSWORD("123");
SET PASSWORD=PASSWORD("456");
#法二:update
UPDATE  mysql.user SET PASSWORD=PASSWORD("456")
	WHERE HOST="localhost" AND USER="u6";
	
#权限:
#设置权限
#全部权限|部分权限
GRANT {ALL(SELECT,DROP,delete...} PRIVILEGES ON *.* TO root@localhost IDENTIFIED BY "password";
#查看权限
SHOW GRANT "user_name"@"host_name";
#收回权限
REVOKE {SELECT|DROP|DELTE|...} FROM "USER_NAME"@"HOST_NAME";
REVOKE ALL PRIVILEGES ,GRANT OPTION ON "USER_NAME"@"HOST_NAME";
#刷新权限
FLUSH PRIVILEGES;



#其它的一些mysql服务优化

#日志:{二进制日志,错误日志,慢查询日志,简要查询日志}

mysql -p FLUSH-LOG:清除日志


#紧急救援
mysqld --initialize-insecure

			/*练习*/

USE mysql;


  INSERT INTO tb_y VALUES(2,"b");
  
  SELECT  * FROM  tb_y WHERE  id <(
		SELECT id FROM tb_y LIMIT 1);
		
		





