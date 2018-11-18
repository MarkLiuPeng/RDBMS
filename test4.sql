/*
use mysql;
drop table index_test;
create table index_test(
id int,
name char(10),
index index_x(name)					#在表的新建过程中引入索引到name字段
);

show create table index_test;

EXPLAIN 									#检验索引是不是有效
	select * from index_test where name=1;
    
    
	*/
#use mysql;															#在原有表的基础上创建索引
#create index index_test_y  on  index_test(id);
#show create table index_test;
/*
alter table  index_test add sex varchar(20);								#通过修改表格时创建索引
alter table index_test add index index_test_z(sex);

explain 
	select * from index_test where sex=1;
  */
  
/*
create table index_test1(
id int,
name char(10),
unique index index_test_w(id)								#唯一索引{指定自动索引和手动索引}
);
show create table index_test1;

*/
/*
create unique index index_test_q  on  index_test1(name);				#在已存在的表上创建唯一索引
show create table index_test1;
*/

/*
alter table  index_test1  add sex varchar(20);
alter table    index_test1 add unique index index_test_r(sex);				#修改表格的基础上映射sex字段唯一索引
explain
	select * from index_test1 where sex=1;
    
  */
/*
create table index_test2(
id int,
name varchar(40),
fulltext index index_test2_x(name)												#创建表格的同时为name字段设置全文索引
);																						#fulltext针对{char,varchar,test}
show create table index_test2;
*/
/*
explain 
	select  * from index_test2 where name=1;
  */  
  
  /*
  drop table index_test2;

  create table index_test2(
  id  char(10) ,
  name varchar(30)
  );
  
  #create fulltext index  index_test2_y on index_test2(name);						#在已有的表格上为name字段设置全文索引
  
  
  #show create table index_test2;
  
  
  alter table index_test2  add fulltext   index index_test2_z(id);						#修改时增加id字段全文索引
  show create table index_test2;
  
  */
  
  /*
  
  create table  index_test3(
  id int,
  name char(10),
  index index_test3_x(id,name)
  );
  show create  table index_test3;							#在创建表格的同时，指定id和name字段关联为多列索引
  
  */
  /*
  create table index_test4(
  id int,
  name varchar(10)
  );/*
  create index index_test4_x on index_test4(id,name);					#在已存在的表格上为id和name字段关联多列索引
  show  create table index_test4;
  */
  /*
  drop table index_test5;
  create table index_test5(									#修改字段的同时为id和name设置多列索引
  id int,
  name varchar(10)
  );
  /*
  alter table   index_test5 add index index_test_5(id,name);
  show  create table index_test5;
  */
  /*
    use mysql; 
	drop index index_test_5  on index_test5;						#删除索引
    */
    
    /*
    use mysql;
    drop view view_index5;
    create view  view_index5
		as											#把id,name字段看成别名作为视图的特定查询
			select  id,name from index_test5;					
		
	select * from view_index5;
    describe view_index5;
    
																			#视图封装
    drop view view_x;
	create view view_x			
		as 
			select 3.1415926;							#封装数据类型视图
	select * from view_x;
    
    insert into index_test5 values(1,"xm");
    insert into index_test5 values(4,"wu");
    insert into index_test5 values(3,"zl");
    drop view view_y;
    create view view_y											#封装按统计id行数的视图
		as
			select  count(id) from  index_test5      ;
            
	select * from view_y;
    
    
    
    
    
    drop view view_z;
    create view view_z 
		as 
			select * from  index_test5 order by id  asc; #desc;					#封装按id字段升序|降序的视图

	select * from  view_z;
    
				*/
                
	drop table view_test_x;
	create table  view_test_x(
	id int,
    name char(10)
    );
    /*
    insert into view_test_x values(1,"xm");
    insert into view_test_x values(4,"zw");
    insert into view_test_x values(10,"lt");
    
    drop table  view_test_y;
    create table  view_test_y(
	number int,
    sex char(10)
    );
    insert into view_test_x values(1,"man");
    insert into view_test_x values(5,"women");
    insert into view_test_x values(10,"women");
    */
   # drop view view_f;
    create view view_f 
		as
			select * from view_test_x;						#封装联合表view_test_x和view_test_y的视图
	
    /*
    union all
            select * from view_test_y;
	select * from view_f;
    
    show tables;									#可用来显示视图名		
    show table  status 	from mysql like "view_f";								#来自mysql库内的视图状态
								#like通配查询
    */
    show create view view_f;							#显示视图的详细信息
    desc  view_f;
    
    
    