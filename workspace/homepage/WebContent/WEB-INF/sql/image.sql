drop table image;

 
create table image(
ino 	number	 not null,
title 	varchar(100) not null,
fname 	varchar(100) not null,
content 	varchar(300) not null,
passwd 	varchar(100) not null,
mname 	varchar(100) not null,
wdate 	DATE 	 not null,
primary key(ino)
)

select * from image;

delete image;

--pwCheck
select count(*) as cnt
from image
where ino=1 and passwd='123';

--total
select count(*) as cnt
from image
WHERE "+col+" like '%'||?||'%';
