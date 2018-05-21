drop table bbs;

create table bbs(
bbsno		 NUMBER(7)		NOT NULL,--일련 번호
wname 		 VARCHAR(20)	NOT NULL,--글쓴이
title		 VARCHAR(100)	NOT NULL,--제목
content 	 VARCHAR(4000)	NOT NULL,--글 내용
passwd		 VARCHAR(15)    NOT NULL,--비밀번호
viewcnt		 NUMBER(5)		DEFAULT 0,--조회수,기본값 사용
wdate		 DATE			NOT NULL,--등록날짜
grpno		 NUMBER(7)		DEFAULT 0,--부모글 번호
indent 		 NUMBER(2) 		DEFAULT 0,--답변여부, 답변의 깊이
ansnum 		 NUMBER(5)		DEFAULT 0,--답변 순서
PRIMARY KEY(bbsno)
);

alter table bbs 
add(refnum number default 0);

alter table bbs
add(filename varchar(100) null,
	filesize number default 0);

delete from bbs
where indent>0;

select * from bbs;

--레코드개수
SELECT count(*) FROM bbs
WHERE wname like '%1%';



SELECT nvl(MAX(bbsno),0)+1 as bbsno FROM bbs;

--create
insert into bbs(bbsno, wname, title, content, passwd,
wdate)
values((select NVL(MAX(bbsno),0)+1 as bbsno from bbs),
'왕눈이','제목','내용','123',sysdate);

insert into bbs(bbsno, wname, title, content, passwd,
wdate)
values((select NVL(MAX(bbsno),0)+1 as bbsno from bbs),
'홍순이','제목','내용','123',sysdate);

insert into bbs(bbsno, wname, title, content, passwd,
wdate)
values((select NVL(MAX(bbsno),0)+1 as bbsno from bbs),
'김길순','제목','내용','123',sysdate);

--read
select * from bbs;

--update
UPDATE bbs
SET wname='왕눈이',title='비오는날',content='개구리 연못'
WHERE bbsno = 1;


--delete
delete from bbs;

delete from bbs where bbsno = 1;

--list(paging)
--mysql의 경우 리미트 속성을 이용하면 쉽게 가능.
--oracle은 반드시 3중쿼리를 통해, rownum은 반드시 as 사용
--여러 이용자에게 한 번에 제한된 정보씩 제공하여 서버를 아끼기 위해
--목록엔 기본적으로 페이징과 검색기능이 존재.
SELECT bbsno, wname, title, viewcnt, wdate, grpno,
	indent, ansnum, r
FROM(
	SELECT bbsno, wname, title, viewcnt, wdate, grpno,
	indent, ansnum, rownum r
	FROM(
		SELECT bbsno, wname, title, content, passwd, viewcnt
		,wdate,grpno,indent, ansnum
		FROM bbs
		ORDER BY grpno desc, ansnum
	)
)
WHERE r >= 5 and r <= 10;

--조회수 증가
update bbs
set viewcnt = viewcnt +1
where bbsno = 1;

--pw검증
select count(bbsno) as cnt
from bbs
where bbsno=1 and passwd='123';

--모든 레코드 삭제
DELETE FROM bbs; 
 
 BBSNO  TITLE    GRPNO INDENT ANSNUM 
 -----   -----    ----- ------ ------ 
     1  부모글1      1      0      0 
      
 BBSNO  TITLE    GRPNO INDENT ANSNUM 
 -----  -----    ----- ------ ------ 
     2  부모글2      2      0      0 
     1  부모글1      1      0      0 
 
 BBSNO  TITLE    GRPNO INDENT ANSNUM 
 -----  -----    ----- ------ ------ 
     4  부모글4      4      0      0
     11   부글4답2   4      1      1
     12     4답2답1  4      2      2
     10   부글4답1   4      1      3
     3  부모글3      3      0      0      
     2  부모글2      2      0      0 
     1  부모글1      1      0      0 
     7   부모글1답3  1       1     1
     8		3답1    1      2      2
     9       3답1답1 1      3     3
     13       3111 1       4     4
     14         1  1       5     5
     6   부모글1답2  1       1     6
     5   부모글1답1  1       1     7
     

grpno		 NUMBER(7)		DEFAULT 0,--부모글 번호
indent 		 NUMBER(2) 		DEFAULT 0,--답변여부, 답변의 깊이
ansnum 		 NUMBER(5)		DEFAULT 0,--답변 순서


--부모글 생성
INSERT INTO bbs(
bbsno, wname, title, content, passwd,
wdate,grpno
)
VALUES(
(SELECT NVL(MAX(bbsno),0)+1 as bbsno from bbs)
,'투투','제목3','내용3','123',sysdate,
(SELECT NVL(MAX(grpno),0)+1 as grpno from bbs)
);



select * from bbs;