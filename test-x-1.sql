USE mysql;
CREATE TABLE tb_x
(
id INT,
NAME CHAR(10)
);
INSERT INTO tb_x VALUES(5,"a");
SELECT COUNT(*)  AS total_Pepolefrom FROM tb_x WHERE id>0;	
	#统计函数:条目数
#再次通过修改tb_x增加一个字段用于一下统计
ALTER TABLE tb_x ADD money INT;

#单独选择money字段插入测试值
INSERT INTO tb_x(money)VALUES(210);

SELECT AVG(money) ,MAX(money),MIN(money),SUM(money) speend FROM tb_x;
	#统计函数:{平均值,最大值，最小值，求和}
	
#
SELECT  id, GROUP_CONCAT(NAME) AS NAMES ,COUNT(NAME) FROM tb_x  GROUP BY id;
				#对指定字段进行分组,以筛选不必要的数据
	    #分组实现统计查询

				
SELECT * FROM tb_x;
SELECT id,money,GROUP_CONCAT(NAME) AS NAMES,COUNT(NAME) FROM tb_x GROUP BY id,money;
	    #分组实现多字段查询并统计
	    


#创建一张新表包含{ename,salary,id)
CREATE TABLE   tb_y
(
id INT,
ename VARCHAR(20),
salary INT
);
INSERT INTO tb_y VALUES(6,"ru",490);


SELECT  salary,ename ,GROUP_CONCAT(ename) AS  enames,COUNT(ename) FROM tb_y GROUP BY 
ename HAVING salary>1000;
	#限制分组的条目
	
#实现多表连接查询


DROP TABLE tb_z;
CREATE TABLE tb_z
(
id INT,
ename  CHAR(10),
lname  VARCHAR(40)
);

DROP TABLE tb_w;
CREATE TABLE tb_w
(
id INT,
wname  CHAR(10),
sex  VARCHAR(40)
);

CREATE TABLE tb_n
(
id INT,
nname CHAR(10),
nsex VARCHAR(20)
);

INSERT INTO  tb_z VALUES(1,"aa","ab"),(2,"fg","women"),(5,"tg","man"),(3,"oe","man");
INSERT INTO tb_w VALUES(1,"aa","aa"),(4,"ty","man"),(6,"yi","man"),(5,"oy","women");
INSERT INTO tb_n VALUES(2,"aa","aa"),(6,"fi","po"),(5,"yi","woap"),(1,"fj","wjw");


SELECT * FROM tb_z;
SELECT * FROM tb_w;
#单张表实现内连接

				#where 实现内连接
SELECT z.ename ,z.id,l.lname 
	FROM tb_z z ,tb_z l
		WHERE z.ename=l.lname;
					#inner join on实现内连接

SELECT z.ename,z.id,l.lname
	FROM tb_z  z INNER   JOIN tb_z  l   ON z.ename=l.lname;
	  
		

#多张表实现内连接

SELECT z.ename,z.lname,w.wname
	FROM tb_z z INNER JOIN tb_w w 
		ON z.ename=w.wname;
SELECT z.ename,z.lname,w.sex
	FROM tb_z z,tb_w w
		WHERE z.ename=w.wname;
		
		
#再次把内连接扩大化
SELECT  z.ename,z.lname,w.sex,n.nsex
	FROM tb_z z /*inner join*/LEFT JOIN tb_w w ON z.ename=w.wname
		/*inner join*/LEFT JOIN tb_n n ON n.nname=w.wname;
				#通过修改连接形式{左连接,右连接，外连接}
SELECT z.ename,z.lname,w.sex,n.nsex
	FROM tb_z z,tb_w w,tb_n n
		WHERE z.ename=w.wname AND n.nname=w.wname;
	
SELECT * FROM tb_w
		UNION	ALL #联合多个表,合并字段{all不可避免重复数据}
SELECT * FROM tb_z;
		

CREATE TABLE company
(
id INT,
salary INT,
NAME VARCHAR(20)
);
INSERT INTO company VALUES(2,5670,"smith"),(2,5670,"zburk"),(7,6678,"amblamba"),(2,5569,"tines");

SELECT * FROM company;
	#实现子查询,规定薪水大于员工smith的
SELECT * FROM company WHERE salary >(
			SELECT salary FROM company
				WHERE NAME="smith"
				);
	#实现子查询，规定编号和薪水和员工smith相同的员工
SELECT  NAME,id,salary FROM company WHERE(id,salary)=ANY(
			SELECT id,salary FROM company
				WHERE NAME="smith"#limit 1
				);
						#报错:子查询无法匹配多个参数字段?
							#解决:limit 1:限制显示条目数
							 #     any:匹配符合条件的全部条目
							 

#为公司创建另一张表为办理离职
CREATE TABLE  company_x
(
NAME VARCHAR(20),
dates TIME,
days INT
);
INSERT INTO  company_x VALUES("poqe",2018,100),("tya",2016,27),("quenn",2018,104);
			
SELECT * FROM company_x;


#规定子查询，凡是入职的员工在离职的员工表出现过，给与其办理离职手续
SELECT * FROM company WHERE NAME IN (
	SELECT NAME FROM company_x
		);
#规定子查询，对于入职的员工的薪水在离职的员工工作时间在100到200天的办理离职

SELECT NAME,salary FROM company WHERE  salary =ALL /*any*/(
	SELECT salary FROM company_x 
		WHERE days IN(100,200)
		);
						#all,any子查询关键字,匹配范围和条件不同
						
	
SELECT * FROM company;
SELECT * FROM company_x;
	#exists子查询关键字，布尔匹配
SELECT * FROM company castQ
		WHERE  EXISTS (
			SELECT *
				FROM company_x 
					WHERE NAME=c.name
			);
		


SELECT * FROM company;
		#运算符
		
SELECT salary/10 AS salary_x  ,5*10+1-2 ,10/5+1*2  FROM company;
				#算数运算符:{+,-，*，/}
		
SELECT  1>2 AND 3<2
UNION ALL
SELECT "abc"<>"def"
UNION ALL
SELECT "abc"<=>"abc";		#比较运算符:{>,<,<>,<=>,!=}

				#特殊比较运算符:正则匹配
SELECT "hello" REGEXP "o$"	#结尾
UNION ALL
SELECT "hello" REGEXP "^h"	#开头
UNION ALL
SELECT "hello" REGEXP "[h..o]"	#字符中间
UNION ALL
SELECT "hello" REGEXP "[a-b]"   #范围
UNION ALL
SELECT "hello" REGEXP "[^g~z]"  #范围之外
UNION ALL
SELECT "hello" REGEXP "h+o"     #字符包含
UNION ALL
SELECT "hello" REGEXP "h*o"
UNION ALL
SELECT "hello" REGEXP "h|e|o"   #存在
UNION ALL
SELECT "hello" REGEXP "l{2}"  #出现次数
UNION ALL
SELECT "hello" REGEXP "1{0,2}";

SELECT 1  ||  2 		#逻辑运算符:{||(or),&&(and),xor}
UNION ALL
SELECT 1  OR 2
UNION ALL
SELECT 1 && 2
UNION ALL  
SELECT 1 AND 2 
UNION ALL
SELECT 1 XOR 2
/*
union  all
select 1 not  2;

*/					#位运算符:{|,&,^,~,>>,<<}
SELECT 3|4|5,BIN(3|4|5)		#按位或
UNION ALL
SELECT 3 & 4 & 5,BIN(3 & 4 & 5)	     #按位与
UNION ALL
SELECT 3 ^ 4 ^ 5,BIN(3 ^ 4 ^ 5)       #按位异或
UNION ALL
SELECT ~1,BIN(~1)      			#取反
UNION ALL
SELECT 3>>4,BIN(3>>4)				#右移
UNION ALL
SELECT 4<<5,BIN(4<<5);			#左移

	
	#函数
	
	
SELECT CONCAT_WS("-",NULL,"10","20");	
	#字符函数:{concat():连接字符串,concat_ws():条件分割连接字符串}
	
SELECT STRCMP("abc","abc"),STRCMP("abc","abb"),STRCMP("abc","abd");

SELECT LENGTH("mysql"),CHAR_LENGTH("mysql");
	#字符函数:{strcmp():比较字符串大小;length()&&char_length():字符串长度}
	
SELECT UPPER("mysql"),UCASE("mysql"),LOWER("MYSQL"),LCASE("MYSQL");
	#字符串函数:{upper&&ucase:字符转大写;lower&&lcase:字符转小写}
SELECT FIND_IN_SET("mysql","oracle,sql server,mysql"),
FIELD("mysql","oracle","sql server","mysql"),
INSTR("mysql","q"),
LOCATE("mysql","veryfastandmysqlisyoubielve"),
POSITION("mysql" IN "veryfastandmysqlisyoubielve")
;	#字符串函数:{find_in_set(),locate(),position(),filed(),insert():查找字符串的位置}


SELECT ELT(2,"cisco","h3c","huawei");
SELECT  BIN(7),MAKE_SET(7,"cisco","h3c","huawei");
		#字符串函数:{elt():指定要显示特定字符串位置,make_set():按二进制匹配};

SELECT LEFT("mysql",2),RIGHT("mysql",3),SUBSTRING("mysql",3,3),MID("mysql",3,3);
		#字符串函数:{left():左截取;right():右截取;substring(),med():按位置和长度截取}
		
SELECT "未处理的字符串长度",CHAR_LENGTH(CONCAT("-"," mysql ","-"))
UNION ALL
SELECT "处理后的字符串长度",CHAR_LENGTH(CONCAT("-",TRIM(" mysql "),"-"));
		#字符串函数:{ltrim(),trim():处理字符串中的空格}

SELECT "是个不错的mysql数据库" AS "原字符串" ,
INSERT("是个不错的mysql数据库",10,1,"oracle")
AS "目的字符串";
		#字符串函数:{insert():替换指定位置的字符}

SELECT REPLACE("高性能的网站后台处理mysql数据库","mysql","oracle");
		#字符串函数:{replace():字符替换函数}

		#数学函数:{fllor(),cell(),trucate(),round()};
SELECT  FLOOR(2.45) AS "取大的整数",CEIL(4.02) AS "取小的整数",
TRUNCATE(45.00,-1) AS "保留小数后一位" ,ROUND(3.1415926,3) AS "四舍五入";
		#日期函数:{now(),current_date(),current_time()}
SELECT NOW() AS "现在的日期和时间",
CURRENT_DATE() AS "现在的日期",
CURRENT_TIME() AS "现在的时间"
;

SELECT UNIX_TIMESTAMP(NOW()) AS "unix时间",
FROM_UNIXTIME(NOW()) "普通时间"
;

SELECT UTC_DATE() AS "中文国际日期",
UTC_TIME() AS "中文国际时间";


SELECT  NOW() AS "当前的日期" , QUARTER(NOW())"当前的季度",  YEAR(NOW()) AS "当前的年份",
MONTH(NOW()) AS "当前的月份",MINUTE(NOW()) AS "当前的分钟" , HOUR(NOW())  AS "当前的小时"
;

SELECT MONTHNAME(NOW()) "英文月份",DAYOFMONTH(NOW())  "月的第几天" ,DAYNAME(NOW()) 
"英文天数",WEEKOFYEAR(NOW()) "年的第几周",WEEKDAY(NOW()) "星期的第几天";


SELECT EXTRACT(YEAR FROM NOW()) "年" ,EXTRACT(MONTH FROM NOW()) "月"
,EXTRACT(WEEK FROM NOW()) "星期";

SELECT NOW() "当前时间",TO_DAYS(NOW())"据原始的时间", 
FROM_DAYS(TO_DAYS (NOW())) "相差的时间";

SELECT DATEDIFF(NOW(),"2000-01-20");	#datediff():计算日期差

SELECT ADDDATE(CURDATE(),5) AS "5天后的日期",SUBDATE(CURDATE(),5) "5天前的日期";


SELECT CURDATE() "当前的日期",ADDDATE(CURDATE(),INTERVAL "2,3" YEAR_MONTH) "2年3个月后的日期",
SUBDATE(CURDATE(),INTERVAL "2,3" YEAR_MONTH) "2年3个月之前的日期";




SELECT  CURTIME() "当前的时间",ADDTIME(CURTIME(),5) "5s后的时间",SUBTIME(CURTIME(),5)
"5s前的时间";



SELECT VERSION() "系统版本",USER() "登陆用户";

#为last_inset_id创建一张表
DROP TABLE test_x;
CREATE TABLE test_x
(
id INT   NOT NULL AUTO_INCREMENT UNIQUE
);

INSERT INTO test_x VALUES(NULL);

#执行系统函数获取最后自增的id字段号
SELECT LAST_INSERT_ID(id) FROM test_x;

			#其它函数
SELECT INET_ATON("127.0.0.1") AS "ip地址转数字";
SELECT INET_NTOA("1230133112") AS "数字转ip地址";


#为存储过程创建一张表
CREATE TABLE tb_y
(
id INT,
salary INT
);
INSERT INTO tb_y VALUES(1,130);

#创建一个存储过程为查询字段salary
DELIMITER $$
DROP PROCEDURE pro_y;	#删除存储过程
CREATE PROCEDURE  pro_y()
	COMMENT "开始这个存储过程"
	BEGIN
		SELECT salaryi/*id*/ FROM tb_y;
	END$$

ALTER PROCEDURE pro_y		#修改存储过程
	COMMENT "对存储过程修改";
	
DELIMITER;
#使用这个存储过程

DELIMITER $$	
DROP FUNCTION fu_y;			#删除函数
	#创建函数
	CREATE FUNCTION fu_y(id INT) #函数参数
	
	RETURNS  INT  #返回另一个数据类型
		COMMENT "这是一个函数"
	BEGIN
		RETURN(
			SELECT salary FROM tb_y
				WHERE tb_y.id=id
				);
	END$$
DELIMITER;


ALTER FUNCTION fu_y
	COMMENT "修改这个函数";		#修改函数
	
	

/*
create view vi_y
	as
		select  salary  from tb_y;
*/		
	


























