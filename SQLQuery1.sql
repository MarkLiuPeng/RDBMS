use DB_x
go
drop database DB_y
create database DB_y				--创建数据库
on primary						--指定主数据文件
(
name=db,			--逻辑名
filename='d:\db.mdf',	--文件位置
size=3MB,	--初始大小
maxsize=10MB,	--最大增长
filegrowth=1MB		--增长方式
)
log on								--指定日志文件
(
name=ldb,
filename='d:\ldb.ldf',
size=3MB,
maxsize=10MB,
filegrowth=1MB
)
alter database DB_y			--修改数据库
add file						--添加主数据文件或日志等存储文件
(
name=dbs,
filename='d:\dbs.ndf',
size=1MB,
maxsize=10MB,
filegrowth=2%
)

create partition  function x(int)		--创建分区函数
	as range left for values(10,20,30,50)

create partition  scheme x					--创建分区方案
	as partition  x
		to  (group1,group2,group3,PRIMARY)

drop table tb_x
create table tb_x					--为表格分区
(
id int not null ,
name char(10)
)
on x

alter table tb_x add num int
use DB_x
select * from tb_x
union all
select * from tb	
alter table tb add constraint PK_id primary	key(id)			--insert两种插入数据方法
insert into tb_x values(10,'a',5)
insert into tb_x(id) select id  from tb
						--查看视图定义
exec sp_helptext vi_x

select * from tb

declare @x char(10)		--声明变量
set @x='hello world'	--为变量赋值
print @x		--打印变量

declare @y int
select    @y=id  from tb  where name='tindy'   --用select选择字段为变量赋值
print @y
select * from tb
--insert into tb values(1,'b','women')
update tb set id=1 where id=2 
	if @@ERROR=2627					--全局变量@@ERROR自定义错误信息
		print '你的查询有错误'
select @@version
								--版本号及开发信息
declare @x_x int,@y_y int			--局部变量结合运算符表达式的运算
set @x_x=10
set @y_y=90
print @x_x+@y_y

select  tb.id ,tb_x.name					--T-sql 同mysql处理多表连接
	from tb 
		full  join tb_x 
			on tb.id=tb_x.id

select * from tb
select sex='man' from tb where  not exists(				--T-sql子查询not|exists语句共存判断条件
	select id='1' from tb
	)
set showplan_all on		--开启查询过程索引连接搜索功能
select * from tb_x
set showplan_all off
						--整理数据磁盘文件
set statistics  IO off
DBCC  showcontig(tb) with fast

if exists(select sex='mans' from  tb)	--exists执行判断是否满足select选择性删除索引
	drop index tb_x.in_x

select  * from tb
alter table tb add constraint CK_tb check(id>0)		--检查约束



begin					--begin...end:sql代码块开始与结束控制
declare @x int,@y char(10),@z char(10)
set @x=10
set @y='my'
set @z='sql'
print @x
end
print @y+@z


declare @x int,@y int			--if..else分支判断语句
set @x=0
set @y=0
if @x>0
	print '@x@y在一四象限'
	else
		print '@x@y在坐标原点'
if @x<0
		print '@x@y在二三象限'
	else
		print '@x@y在坐标原点'
		
select * from tb

select id=					--case循环分支语句
	case
		when id>1 and id<3  then  'jark'
		when id>3 and id<6  then 'tindy'
		else 'a'
		end
	from tb

declare @i int,@sum int						--while循环语句	
set @i=1
set @sum=0
while @i<=10
begin
	print '死循环'
/*
	if @i%2=0
		--set @sum=@sum+@i
		--set @i=@i+1
	continue
	--else
		--print '查询有误'	
set @sum=@sum+@i
set @i=@i+1
*/
end
print '1-100的和是:'
print @sum

declare @x int
set @x=10
print @x
return				--语句返回，忽视下面语句
print '还可以输出吗'


declare @y int 
select @y=1
example:
	print @y
	select @y=@y+1
		if @y%2=0
while @y<10 goto example					--跳转


waitfor delay'00:00:01'			--语句延迟和执行时间
drop table tb
print '现在删除DB_x库里的tb表'

exec sp_addtype  y , 'char(10)','not null'	--自定义数据类型
						--形参
create function fun_max(@x int ,@y int )		--自定义函数
	returns int				--返回新的数据类型
		as
			begin
				if @x<@y
					set @x=@y
						return @x
			end

declare @a int,@b int
set @a=2
set @b=10
print  fun_max(@a,@b )			--调用自定义的最大值函数，代入实参


create function find(@z int)		--自定义筛选函数		
	returns table				
		as
		return(select * from tb_x where id>@z)
select * from find(4)				--赋形参为4，筛选id>4的行

use DB_x
create procedure pro_tb_x			--存储过程创建
	as
		select * from tb_x

exec  sp_helptext  pro_tb_x			--执行和查看存储过程
use DB_x
drop  table tb_x
create trigger tri_x			--触发器创建
	on database				--对于库的触发
		for  DROP_TABLE,ALTER_TABLE			--触发条件
			as
		begin
			print '你确定要触发这个触发器'
			rollback
		end

drop trigger tri_y
create trigger tri_y		
	on all server			--对于服务器的触发
		for create_login	
			as
				begin
					print '你没有权限创建用户'
				end
			
create login  u1  with password='123'

create trigger tri_z
	on 
		for  drop_table
			as
				begin
					print '删除了一张表'
				end

drop  trigger tri_x
	
create login u4 with  password='123' --创建登陆账号
/*alter*/ drop  login u1 /*with password='456'*/--修改和删除登陆账号
			
			
	
	


