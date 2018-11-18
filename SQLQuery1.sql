use DB_x
go
drop database DB_y
create database DB_y				--�������ݿ�
on primary						--ָ���������ļ�
(
name=db,			--�߼���
filename='d:\db.mdf',	--�ļ�λ��
size=3MB,	--��ʼ��С
maxsize=10MB,	--�������
filegrowth=1MB		--������ʽ
)
log on								--ָ����־�ļ�
(
name=ldb,
filename='d:\ldb.ldf',
size=3MB,
maxsize=10MB,
filegrowth=1MB
)
alter database DB_y			--�޸����ݿ�
add file						--����������ļ�����־�ȴ洢�ļ�
(
name=dbs,
filename='d:\dbs.ndf',
size=1MB,
maxsize=10MB,
filegrowth=2%
)

create partition  function x(int)		--������������
	as range left for values(10,20,30,50)

create partition  scheme x					--������������
	as partition  x
		to  (group1,group2,group3,PRIMARY)

drop table tb_x
create table tb_x					--Ϊ������
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
alter table tb add constraint PK_id primary	key(id)			--insert���ֲ������ݷ���
insert into tb_x values(10,'a',5)
insert into tb_x(id) select id  from tb
						--�鿴��ͼ����
exec sp_helptext vi_x

select * from tb

declare @x char(10)		--��������
set @x='hello world'	--Ϊ������ֵ
print @x		--��ӡ����

declare @y int
select    @y=id  from tb  where name='tindy'   --��selectѡ���ֶ�Ϊ������ֵ
print @y
select * from tb
--insert into tb values(1,'b','women')
update tb set id=1 where id=2 
	if @@ERROR=2627					--ȫ�ֱ���@@ERROR�Զ��������Ϣ
		print '��Ĳ�ѯ�д���'
select @@version
								--�汾�ż�������Ϣ
declare @x_x int,@y_y int			--�ֲ����������������ʽ������
set @x_x=10
set @y_y=90
print @x_x+@y_y

select  tb.id ,tb_x.name					--T-sql ͬmysql����������
	from tb 
		full  join tb_x 
			on tb.id=tb_x.id

select * from tb
select sex='man' from tb where  not exists(				--T-sql�Ӳ�ѯnot|exists��乲���ж�����
	select id='1' from tb
	)
set showplan_all on		--������ѯ��������������������
select * from tb_x
set showplan_all off
						--�������ݴ����ļ�
set statistics  IO off
DBCC  showcontig(tb) with fast

if exists(select sex='mans' from  tb)	--existsִ���ж��Ƿ�����selectѡ����ɾ������
	drop index tb_x.in_x

select  * from tb
alter table tb add constraint CK_tb check(id>0)		--���Լ��



begin					--begin...end:sql����鿪ʼ���������
declare @x int,@y char(10),@z char(10)
set @x=10
set @y='my'
set @z='sql'
print @x
end
print @y+@z


declare @x int,@y int			--if..else��֧�ж����
set @x=0
set @y=0
if @x>0
	print '@x@y��һ������'
	else
		print '@x@y������ԭ��'
if @x<0
		print '@x@y�ڶ�������'
	else
		print '@x@y������ԭ��'
		
select * from tb

select id=					--caseѭ����֧���
	case
		when id>1 and id<3  then  'jark'
		when id>3 and id<6  then 'tindy'
		else 'a'
		end
	from tb

declare @i int,@sum int						--whileѭ�����	
set @i=1
set @sum=0
while @i<=10
begin
	print '��ѭ��'
/*
	if @i%2=0
		--set @sum=@sum+@i
		--set @i=@i+1
	continue
	--else
		--print '��ѯ����'	
set @sum=@sum+@i
set @i=@i+1
*/
end
print '1-100�ĺ���:'
print @sum

declare @x int
set @x=10
print @x
return				--��䷵�أ������������
print '�����������'


declare @y int 
select @y=1
example:
	print @y
	select @y=@y+1
		if @y%2=0
while @y<10 goto example					--��ת


waitfor delay'00:00:01'			--����ӳٺ�ִ��ʱ��
drop table tb
print '����ɾ��DB_x�����tb��'

exec sp_addtype  y , 'char(10)','not null'	--�Զ�����������
						--�β�
create function fun_max(@x int ,@y int )		--�Զ��庯��
	returns int				--�����µ���������
		as
			begin
				if @x<@y
					set @x=@y
						return @x
			end

declare @a int,@b int
set @a=2
set @b=10
print  fun_max(@a,@b )			--�����Զ�������ֵ����������ʵ��


create function find(@z int)		--�Զ���ɸѡ����		
	returns table				
		as
		return(select * from tb_x where id>@z)
select * from find(4)				--���β�Ϊ4��ɸѡid>4����

use DB_x
create procedure pro_tb_x			--�洢���̴���
	as
		select * from tb_x

exec  sp_helptext  pro_tb_x			--ִ�кͲ鿴�洢����
use DB_x
drop  table tb_x
create trigger tri_x			--����������
	on database				--���ڿ�Ĵ���
		for  DROP_TABLE,ALTER_TABLE			--��������
			as
		begin
			print '��ȷ��Ҫ�������������'
			rollback
		end

drop trigger tri_y
create trigger tri_y		
	on all server			--���ڷ������Ĵ���
		for create_login	
			as
				begin
					print '��û��Ȩ�޴����û�'
				end
			
create login  u1  with password='123'

create trigger tri_z
	on 
		for  drop_table
			as
				begin
					print 'ɾ����һ�ű�'
				end

drop  trigger tri_x
	
create login u4 with  password='123' --������½�˺�
/*alter*/ drop  login u1 /*with password='456'*/--�޸ĺ�ɾ����½�˺�
			
			
	
	


