drop table member;


CREATE TABLE member(
id    		VARCHAR(10)		NOT null,
passwd 		VARCHAR(20) 	NOT null,
mname 		VARCHAR(20) 	NOT null, --성명
tel			VARCHAR(14)		NOT null,
email		VARCHAR(50)		NOT null UNIQUE, --중복안됨
zipcode 	VARCHAR(7)	        null,
address1	VARCHAR(300)		null,
address2	VARCHAR(300)		null,
job			VARCHAR(20)		NOT null,
mdate 		DATE			NOT null, --가입일
fname		VARCHAR(50)		DEFAULT 'member.jpg', 
grade		CHAR(1)			DEFAULT 'H',-- 일반회원: H, 정지: Y, 손님:Z 
PRIMARY KEY (id)
);


select * from member;

delete from member;

INSERT INTO member(id, passwd, mname, tel, email, zipcode,
address1,address2,job,mdate,fname,grade)
VALUES('op','1234','개발자1','123-1234','email4@mail.com',
'123-123','인천시','남동구','A01',sysdate,'man.jpg','H');

INSERT INTO member(id,passwd,mname,tel,email,zipcode,
address1,address2,job,mdate,fname,grade)
VALUES('user2','1234','개발자2','123-1234','email2@mail.com',
'123-123','광명시','남동구','A01',sysdate,'man.jpg','H');

INSERT INTO member(id,passwd,mname,tel,email,zipcode,
address1,address2,job,mdate,fname,grade)
VALUES('qqqq','1234','개발자3','123-1234','email33@mail.com',
'123-123','용인시','남동구','A01',sysdate,'myface.jpg','H');

INSERT INTO member(id,passwd,mname,tel,email,zipcode,
address1,address2,job,mdate,fname,grade)
VALUES('admin','1234','관리자','123-1234','admin@mail.com',
'123-123','용인시','남동구','A01',sysdate,'member.jpg','A');


SELECT id,passwd,mname,tel,email,zipcode,address1,address2,job,mdate,fname,grade
FROM member
ORDER BY id ASC;


--id 중복검사
SELECT COUNT(id) as cnt
FROM member
WHERE id='user1';

--이메일 중복 확인
SELECT COUNT(email) as cnt
FROM member
WHERE email='user1';

--회원 전체 목록
--	LIKE	 : 정확하게 일치하지 않아도 출력
-- 	=(equal) : 정확하게 일치해야 출력


SELECT id,passwd,mname,tel,email,zipcode,address1,address2,
	   job,mdate,fname,grade
FROM member
WHERE id LIKE '%%' 
ORDER BY id ASC;   


SELECT id,passwd,mname,tel,email,zipcode,
address1,address2,job,mdate,fname
FROM member
ORDER BY mdate DESC;


SELECT id,passwd,mname,tel,email,zipcode,address1,address2,
	job,mdate,fname,grade
FROM member
WHERE id='user1';

--회원 이미지의 수정
UPDATE MEMBER
SET fname=''
WHERE id='user1';

--패스워드 변경
UPDATE MEMBER
SET passwd='1234'
WHERE id='';

SELECT id,mname,passwd
FROM member
ORDER BY id DESC;

--회원 정보 수정
UPDATE member
SET passwd='TEST',
	tel='123-123',
	email='email10',
	zipcode='TEST',
	address1='수원',
	address2='팔달구',
	job='TEST',
WHERE id='user3';


--개발시엔 비권장 한다고 한다.
SELECT * FROM member;

--회원 삭제
DELETE FROM member WHERE mname='dsa';


--로그인 관련 SQL
SELECT COUNT(id) as cnt
FROM member
WHERE id='user1' AND passwd='1234';

--list
SELECT id, mname, tel, email, zipcode, address1,
	address2, fname, r
FROM(
	SELECT id, mname, tel, email, zipcode, address1,
		address2, fname, rownum r
	FROM(
		SELECT id, mname, tel, email, zipcode, address1,
		address2, fname
		FROM member
		WHERE mname like '%홍%'
		ORDER BY mdate desc
	)
)
WHERE r>=1 AND r<=5;

--password check
SELECT count(id) as cnt
FROM member
WHERE id='qqqq' AND passwd='5678';

select * from member;



