use master;
exec  sp_tables;
create table text_tb(
id int not null,
name char(10) unique
);
select count(id) as count_number  ,name  
from text_tb
where name between  'A' and 'B'
group by id,name

;

insert into text_tb values(1,'C');



declare @x  int
set @x=10                                                                                                                                        
print  @x;


create view text_tb_view
	as
		select id from text_tb;

create index text_tb_index
	on 
		text_tb(name);

