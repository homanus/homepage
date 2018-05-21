create table chat(
cnum number not null primary key,
chat_id varchar(100) not null,
nick_name varchar(20) not null,
cdate date not null,
message varchar(200)
);

drop table chat;