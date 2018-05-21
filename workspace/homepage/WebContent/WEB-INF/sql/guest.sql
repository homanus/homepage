drop table guest;

CREATE table guest(
gno 		NUMBER			not null,
fname		VARCHAR(100) 	default 'member.jpg',
gname		VARCHAR(300) 	not null,
content		VARCHAR(300)	not null,
gdate		DATE			not null,
primary key(gno)
);

alter table guest
add(
id 		VARCHAR(100) not null
);

delete GUEST
where gno=1;




INSERT INTO guest(
gno,fname,gname,content,gdate,id)
VALUES((SELECT NVL(MAX(gno),0)+1 as gno from guest),
'1','2','3',sysdate,'ad');

select * from guest;


SELECT gno,fname,gname,content,gdate,r
FROM(
	SELECT gno,fname,gname,content,gdate, rownum r
	FROM(
		SELECT gno,fname,gname,content,gdate
		FROM guest
		ORDER BY gdate DESC
	)
)
WHERE r>=1 and r<=5;

select * from guest;


select gno,fname,gname,content,gdate
from guest
where gno = 2;