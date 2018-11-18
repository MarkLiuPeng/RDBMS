USE mysql;
DROP TABLE test_x;
CREATE TABLE test_x
(
id INT,
NAME CHAR(10)
);

CREATE TABLE test_y
(
id INT,
NAME CHAR(10)
);

				#多插
INSERT INTO test_x VALUES(NULL,NULL),(NULL,NULL),(NULL,NULL);

INSERT INTO test_y(id,NAME)
	SELECT  id,NAME FROM test_x;
					#将查询结果插入记录

SELECT * FROM test_y;

UPDATE test_y 
	SET id=1
		WHERE NAME="wd";
		
		
DELETE FROM test_y
	WHERE id=2;

SELECT DISTINCT * FROM test_x;
		#distinct 排除重复的字段
 
SELECT (id+10)/(10*9-1) AS math_id,NAME FROM test_x;
			#支持四则运算，“AS”作为别名

SELECT CONCAT(id,NAME)  total		
	FROM test_x;		#同时为多列合并成新列

SELECT  DISTINCT * FROM 	 test_x 	#逻辑运算和比较运算符筛选字段
	#where id=2 and name="wd";
	#where id=2 && name="wd";
	#where id=2 || name="wd";
	#where id!=10 and id>2&&id<110;
	#where id not between 5 and 10;#between  | not between关键字筛选
	#where id is not null;		#null| not null关键字筛选	
	#where  not id is null;		
	#where id  not in(5,10);		#in | not in:关键字查询
	#where  name like "_p%";
	#where name not like "%t%";	
	/*like关键字模糊匹配{%:特定字符开头;
	_:特定字符;
	%char_name%:包含字符;
	%%：《=》*;
	*/
	#where id  in(2,10) order by  id asc limit 2;#desc;
	WHERE id  BETWEEN 2 AND 10 LIMIT 2,3;
	
			
			#排序{asc:升序;desc:降序};
					#limit:限制显示字段的条目数量{数组起始值,步数};
					
	