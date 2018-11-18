use  mysql;
create  table company(
id int primary key,
name char(10),
login time
);							#父表注册主键为id字段
create table employ(
pople varchar(10),
sex char(10),
id int primary key,
constraint  FK_id foreign key(id) references company(id)	#子表外键id字段继承父表id属性
);


describe employ;
describe company;


