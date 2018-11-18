#use  mysql;
/*
show tables;
select * from user;
use mysql;
show databases;
#create database db1;	     
#drop database  test;		
#show engines\g;   #存储引擎
#show engine\G;			#"\g,\G友好形式

#show variables  like "Storage_engine%";   #系统全部存储引擎
				#default	InnoB 
#HELP  contents;						#帮助
			
#use mysql;            
#create  table test(  id  int);
#insert into test  values(1),(-1),(10000000000);
#show warnings;				#警告

#select * from test;    

#数据类型
#use mysql;
#create table test2( a float(1,2),b double(1,10));
#insert into test2 values(1.00000,4.00);
#create table test3 (a bit(10));
#insert into test3 values(11,b'11');
#select  * from test3;

 
create table date_test(
f_date  DATE,					#日期类型
f_datetime datetime,
f_timestmp timestamp,
f_time 	time,
f_year	year
);

insert into date_test values(curdate(),now(),now(),time(now()),year(now()));

select * from  date_test;
*/
#字符型
/*
create table   date_test_2(
id int,
name char(10),
sex  varchar(10),
number binary(3)
);
insert into date_test_2 values(1,"张三","man",0);
insert into date_test_2 values(2,"李四","man",1);
insert into date_test_2 values(3,"吴燕","women",0);
insert into date_test_2 values(4,"赵九","man",1);
*/
#select * from date_test_1;

 #use mysql;
 #describe   example_1;  #date_test_2；					#定义
#drop table example_1;										#删除
#show create table example_1;					#详细定义

#use mysql;
#alter table  example  RENAME example_2;					#修改
#describe example_2;

#alter table example_2 add sex  varchar(10);					#最后增加列

#describe example_2;

#alter table example_2 add money int  first;					#在首行增加列
#describe  example_2;

#alter table example_2	add   weather varchar(10) after name;		#指定字段后增减列
#describe example_2;

#alter table example_2  drop sex ;							#删除字段


#alter table example_2 modify name varchar(10);				#修改字段数据类型

#alter table example_2 change names name varcharacter(10);			#修改字段名称
									#并发修改字段和数据类型
								
												#调至首位，放置其后
#alter table example_2    modify   id  int  first ;  			
/*
alter  table example_2 modify money int after weather;
describe example_2;
*/

#约束

/*
#非空完整性约束
describe  example_4;
create table example_4(id int not null,name varchar(10),sex char(10));
							
							*/
							#试图插入数据，遭非空约束屏蔽
#insert into example_4(id,name,sex)values(null,"王明","man");
															#字段默认值
#drop table example_4;
#use mysql;
#create table example_6( id int not null, name varchar(20) default '王大牛', sex  char(10));
#describe example_6;

			
#create table example_7(id int not null, name char(10) unique,sex  varchar(10) default 'man');
/*drop table example_7;
											#唯一约束
create table example_7(id int not null, name char(10) ,
constraint uk_name unique(name));					#约束名:唯一简写_字段名
*/														#主键约束:非空+唯一
/*
create table example_7( id  int primary key,name char(10),sex varchar(20));
describe example_7;									#试图插入重复数据，报错脚本显示主建生效
insert into example_7(id,name,sex)values(1,"李兰","women");
insert into example_7(id,name,sex)values(1,"江山","man");
*/
/*
create table example_7(id int,name char(10),tempature bit(11),
constraint PK_id_tempature primary key(id,tempature)			#联合主键
);
*/					
/*										#自动属性
drop table example_7;
#create table example_7(id int primary key auto_increment,name char(10),sex varchar(20));
describe example_7;
*/

							


            