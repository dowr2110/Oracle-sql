CREATE DATABASE LINK DBLINKK 
   CONNECT TO C##ADD
   IDENTIFIED BY "12345"
   USING '(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))(CONNECT_DATA = (SERVICE_NAME = orcl)))';

GRANT CREATE DATABASE LINK TO C##ADD;

select * from teacherr@DBLINKK;

select * from teacherr;

insert into teacherr@DBLINKK(TEACHER, TEACHER_NAME,PULPIT)
VALUES('DDD','DOWR DOWRAN DOWRANGELDI','ISiT');

UPDATE teacherr@DBLINKK SET PULPIT='POIT' WHERE TEACHER='DDD';

DELETE FROM teacherr@DBLINKK WHERE TEACHER='DDD';


BEGIN
GET_TEACHERS@DBLINKK('ISiT');
END;


DECLARE
X NUMBER;
BEGIN
X:=GET_NUM_TEACHERS@DBLINKK ('ISiT');
DBMS_OUTPUT.PUT_LINE('COUNT='||X);
END;

CREATE PUBLIC DATABASE LINK PUBLIC_DBLINKK 
   CONNECT TO C##ADD
   IDENTIFIED BY "12345"
   USING '(DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))(CONNECT_DATA = (SERVICE_NAME = orcl)))';
   
   
select * from teacherr@PUBLIC_DBLINKK;

SELECT * FROM DBA_DB_LINKS;


--public shtoby drugiye polzovateli mogli polucit dostup db


