/*
use mysql;
show table status;
create table test_x(
id int  primary key,
name char(10)
);
alter table test_x add index index_test on test_x(name);

show index index_test;

select * from index_test;
insert into test_x values(1,'赵武');
INSERT INTO test_x VALUES(2,'迈克');

select * from test_x;
*/
/*
use mysql;
drop view view_text_x;
create view   view_test_x
      as
	select * from  test_x;

#show view view_test_x;
	
*/


			#创建表格和视图的映射关系
CREATE TABLE test_y
(
id INT,
NAME CHAR(10)
);
CREATE VIEW view_testy
	AS 
		SELECT * FROM test_y;
		
SELECT * FROM view_testy;

DROP VIEW view_testy;				#删除视图

CREATE OR REPLACE VIEW view_testy		#覆盖原来的视图
	AS
		SELECT NAME FROM test_y;

ALTER VIEW view_testy				#修改视图映射表格字段
	AS
		SELECT * FROM test_y;
		
INSERT INTO view_testy VALUES(2,"b");		#视图同表格具有同理数据插入


CREATE OR REPLACE view_testy
	AS
		SELECT id ,NAME FROM test_y;
		
DELETE FROM view_testy
	WHERE id=2;
UPDATE  view_testy
	SET id=1;
		WHERE NAME="b";
		
	

	

