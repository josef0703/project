-- SELECT
SELECT * FROM userdto;
SELECT * FROM seller;
SELECT * FROM project_funding;
SELECT * FROM funded;
SELECT * FROM delivery;
SELECT * FROM likes;
SELECT * FROM notice;
SELECT * FROM inquire;
SELECT * FROM inquire_answer;

SELECT f_prnum prnum FROM funded WHERE f_useremail = "1101@naver.com";
DELETE FROM funded WHERE f_fundingdate ="2021-10-04 01:36:32";

INSERT INTO delivery (dv_prnum, dv_num, dv_addr, dv_check, dv_useremail) VALUES (3, "1234567890", "주소", 0, "c@c.com");
INSERT INTO delivery (dv_prnum, dv_num, dv_addr, dv_check, dv_useremail) VALUES (4, "1", "주소", 0, "c@c.com");
INSERT INTO funded (f_prnum, f_useremail, f_fundingdate) VALUES (4, "c@c.com", now());
DESC delivery;
SELECT * FROM delivery d ;
select dv_prnum prnum, dv_num num, dv_useremail useremail
			from Delivery 
			where dv_prnum = "1";

-- 기본 INSERT
INSERT INTO userdto (user_email, user_name, user_role) VALUES ("김30", "aaa", "ROLE_USER");

INSERT INTO seller VALUES ("c@c.c", "c", "c", "c", "c");

INSERT INTO project_funding (pf_selid, pf_title, pf_content, pf_itemprice, pf_price, pf_category, pf_startdate, pf_enddate)
VALUES ("dcc", "c", "c", 10, 10, "c", now(), now());

INSERT INTO funded values(3, "a@a.a", now());
INSERT INTO funded values(5, "a@a.a", now());
INSERT INTO funded values(5, "test", now());

INSERT INTO likes values(123, "a");


-- DAO 검사용
SELECT sum(p.pf_itemprice) FROM funded f, project_funding p WHERE f.f_prnum = p.pf_prnum GROUP BY (f.f_useremail) HAVING f.f_useremail = "test";
SELECT count(*) FROM likes GROUP BY lk_prnum HAVING lk_prnum = 123;
SELECT * FROM project_funding ;
SELECT count(*) FROM project_funding WHERE date_format(pf_regdate, '%Y-%m-%d') = "2021-09-27"; 
SELECT * FROM project_funding WHERE date_format(pf_regdate, '%Y-%m-%d') <= date_format(now(), '%Y-%m-%d'); 

INSERT INTO #seller(sel_useremail useremail, sel_business business, sel_jumin jumin, sel_selid selid, sel_name name)
		VALUES("test@nav.com", "3452", "203949","3409", "대표자");
		
SELECT f_prnum ,f_fundingdate FROM funded WHERE f_useremail = "김30";
SELECT pf_prnum, pf_title, pf_price, pf_category, pf_regdate, pf_startdate, pf_enddate from project_funding;
	
SELECT *FROM funded where f_useremail = "김30" ;
SELECT *FROM userdto ;
SELECT *FROM funded ;
SELECT *FROM project_funding ;
INSERT INTO funded VALUES (2,"1101@naver.com",now());
SELECT f_prnum, f_useremail,f_fundingdate FROM funded where f_useremail = "1101@naver.com";
SELECT f_prnum, f_useremail,f_fundingdate FROM funded where f_useremail = "rarz1176@daum.net";

SELECT *FROM delivery ;
SELECT *FROM funded where f_useremail = "1101@naver.com" ;
select * from funded f where f_useremail = "1101@naver.com" group by (f_useremail);
SELECT f_prnum FROM funded where f_useremail = "1101@naver.com" ;
INSERT INTO funded VALUES (2,"rarz1176@daum.net",now());
INSERT INTO funded VALUES (2,"1101@naver.com",now());
SELECT * FROM funded ;
SELECT * FROM project_funding ;


INSERT INTO Delivery VALUES(1,"1234567890","평택",1,"rarz1176@daum.net","배송컨택1");
INSERT INTO Delivery VALUES(2,"640663262611","한라",1,"rarz1176@daum.net","배송컨택");
INSERT INTO Delivery VALUES(2,"555983261782","청주",1,"1101@naver.com","청수배송컨택");
INSERT INTO Delivery VALUES(1,"551240698701","문산",0,"1101@naver.com","배송컨택1");

UPDATE Delivery
		SET dv_addr = "서울"
		WHERE dv_useremail = "1101@naver.com";
	
select dv_prnum  prnum, dv_num num, dv_useremail useremail from Delivery where dv_num = "1234567890";
		

	SELECT pf_prnum prnum,
         pf_selid selid,
         pf_title title,
         pf_content content,
         pf_viewcnt viewcnt,
         pf_itemprice itemprice,
         pf_price price, 
         pf_category category, 
         pf_filepath filepath, 
         pf_regdate regdate,
         pf_startdate startdate, 
         pf_enddate enddate,
         pf_newctn newctn
      FROM project_funding
      WHERE pf_selid = "test5657"
	order by pf_prnum desc;
