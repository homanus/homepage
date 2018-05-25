<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
</head> 
<body>
create table image(
ino number not null,
title varchar(20) not null,
content varchar(300) not null,
passwd varchar(20) not null,
mname varchar(20) not null,
fname varchar(50) not null,
wdate date not null,
primary key(ino)
);


create table member(
id          varchar(10)     not null,
mname       varchar(20)     not null,
passwd      varchar(20)     not null,
tel         varchar(14)     not null,
email       varchar(50)     not null,
fname       varchar(50)     default 'member.jpg',
filesize    number          default 0,
zipcode     varchar(7)      null,
address1    varchar(300)    null,
address2    varchar(300)    null,
grade       char(1)         default 'n' null,
job         varchar(20)     not null,
mdate       date            not null,
survey      char(1)         default 'N' null,
primary key(id)
);

update grade의 경우 n 다음 S, 그리고 V이다.
admin의 경우는 A로 고정이다.


create table chat_room(
chat_index number not null,
chat_title varchar(100) not null,
chat_nickname varchar(100) not null,
id          varchar(10)     not null,
cdate   date    not null,
primary key(chat_index),
foreign key(id) references member(id)
);

select * from chat_room;
select * from chat_message;


create table chat_message(
chat_message_index number not null,
chat_content varchar(100) not null,
chat_index number not null,
chat_date date not null,
nickname varchar(20) not null,
primary key(chat_message_index),
foreign key(chat_index) references chat_room(chat_index)
);

</body>
</html> 