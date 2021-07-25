--1
DECLARE 
  SUB SUBJECT%ROWTYPE;
  BEGIN
  SELECT * INTO SUB FROM SUBJECT WHERE SUBJECT='SUBD';
  DBMS_OUTPUT.PUT_LINE(SUB.SUBJECT||'   '||SUB.SUBJECT_NAME);
  EXCEPTION
  WHEN OTHERS
  THEN
  DBMS_OUTPUT.PUT_LINE(SQLERRM);
  END;
  
  
  select * from subject;
--2,3,4
DECLARE
SUB SUBJECT%ROWTYPE;
B1 BOOLEAN;
B2 BOOLEAN;
B3 BOOLEAN;
N INT;
BEGIN
SELECT * INTO SUB FROM SUBJECT WHERE SUBJECT='SUBD';
DBMS_OUTPUT.PUT_LINE(SUB.SUBJECT);
B1:=SQL%FOUND;
IF B1 THEN DBMS_OUTPUT.PUT_LINE('B1:=TRUE'); END IF;
B2:=SQL%ISOPEN; 
IF B2 THEN DBMS_OUTPUT.PUT_LINE('B2:=TRUE'); END IF;
B3:=SQL%NOTFOUND; 
IF B3 THEN DBMS_OUTPUT.PUT_LINE('B3:=TRUE');END IF;
N:=SQL%ROWCOUNT; 
DBMS_OUTPUT.PUT_LINE('N='||N);
EXCEPTION
WHEN TOO_MANY_ROWS THEN
DBMS_OUTPUT.PUT_LINE('TOO MANY ROWS');
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
--5
--SELECT * FROM SUBJECT;
DECLARE
SUB2 SUBJECT%ROWTYPE;
BEGIN
COMMIT;
UPDATE SUBJECT SET
SUBJECT_NAME='Database management systems2'
WHERE SUBJECT='SUBD';
ROLLBACK;
SELECT * INTO SUB2 FROM SUBJECT WHERE SUBJECT='SUBD';
DBMS_OUTPUT.PUT_LINE(SUB2.SUBJECT_NAME);
END;
--6
DECLARE
SUB TEACHER%ROWTYPE;
BEGIN
UPDATE TEACHER SET
GENDER='H'
WHERE TEACHER='CVV';
SELECT * INTO SUB FROM TEACHER WHERE TEACHER='CVV';
DBMS_OUTPUT.PUT_LINE(SUB.TEACHER);
EXCEPTION
WHEN OTHERS
THEN
DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
select * from teacher;
--7 INSERT
DECLARE
SUB TEACHER%ROWTYPE;
BEGIN
COMMIT;
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT )
values  ('JNE',     'Jilyak Nadegda Eleksandrovna',  'ISiT');
ROLLBACK;
SELECT * INTO SUB FROM TEACHER WHERE TEACHER='JNE';
DBMS_OUTPUT.PUT_LINE(SUB.TEACHER);
END;
--DELETE FROM TEACHER WHERE TEACHER='?????';
SELECT * FROM TEACHER

--8 INSERT
DECLARE
SUB TEACHER%ROWTYPE;
BEGIN
INSERT INTO TEACHER 
VALUES('JNA','Jilyak Nadegda Aleksandrovna','K','ISiT');
EXCEPTION
WHEN OTHERS
THEN
DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
--9 DELETE
DECLARE
SUB TEACHER%ROWTYPE;
BEGIN
COMMIT;
DELETE FROM TEACHER WHERE  TEACHER='JNA';
DBMS_OUTPUT.PUT_LINE('DELETE 1 ROWS');
ROLLBACK;
END;
--10 DELETE
DECLARE
SUB AUDITORIUM_TYPE%ROWTYPE;
BEGIN
DELETE FROM AUDITORIUM_TYPE WHERE  AUDITORIUM_TYPE='LK';
EXCEPTION
WHEN OTHERS
THEN
DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

--11 yavnyy cursor LOOP
--12 yavnyy cursor WHILE
DECLARE
CURSOR CURS_SUB
IS SELECT SUBJECT,SUBJECT_NAME,PULPIT FROM SUBJECT;
CC_SUB SUBJECT%ROWTYPE;
BEGIN
OPEN CURS_SUB;
FETCH CURS_SUB INTO CC_SUB;
WHILE CURS_SUB%FOUND
LOOP
DBMS_OUTPUT.PUT_LINE(CC_SUB.SUBJECT||'    '||CC_SUB.SUBJECT_NAME);
FETCH CURS_SUB INTO CC_SUB;
END LOOP;
CLOSE CURS_SUB;
END;

--13 INNER JOIN
DECLARE
CURSOR CURS_JOIN
IS SELECT TEACHER.PULPIT,TEACHER.TEACHER_NAME FROM  TEACHER JOIN PULPIT ON TEACHER.PULPIT=PULPIT.PULPIT;
CC_JOIN_P  TEACHER%ROWTYPE;
BEGIN
FOR CC_JOIN_P IN CURS_JOIN
LOOP
DBMS_OUTPUT.PUT_LINE(CC_JOIN_P.PULPIT||CC_JOIN_P.TEACHER_NAME);
END LOOP;
END;
--14 ?????? ? ???????????
--SELECT * FROM AUDITORIUM
DECLARE 
CURSOR CURS_AU (CAP AUDITORIUM.AUDITORIUM%TYPE)
IS SELECT AUDITORIUM,AUDITORIUM_CAPACITY
FROM AUDITORIUM
WHERE AUDITORIUM_CAPACITY <=CAP;
AUD AUDITORIUM.AUDITORIUM%TYPE;
CAPA AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
BEGIN
OPEN CURS_AU(50);--------------
FETCH CURS_AU INTO AUD,CAPA;
WHILE (CURS_AU%FOUND)
LOOP
DBMS_OUTPUT.PUT_LINE(AUD||CAPA);
FETCH CURS_AU INTO AUD,CAPA;
END LOOP;
END;
--15 ????????? ??????????
VARIABLE X REFCURSOR;
DECLARE
TYPE SUBJECT1 IS REF CURSOR RETURN SUBJECT%ROWTYPE;
XCURS SUBJECT1;
SUB_SUB SUBJECT%ROWTYPE;
BEGIN
OPEN XCURS FOR SELECT * FROM SUBJECT;
:X:=XCURS;
END;
/
PRINT X;
--16----------------------------------------
DECLARE
CURSOR CURS_AUT
IS SELECT AUDITORIUM_TYPE,
CURSOR(
SELECT AUDITORIUM
FROM AUDITORIUM AUM
WHERE AUT.AUDITORIUM_TYPE=AUM.AUDITORIUM_TYPE
)
FROM AUDITORIUM_TYPE AUT;
CURS_AUM SYS_REFCURSOR;
AUT AUDITORIUM_TYPE.AUDITORIUM_TYPE%TYPE;
TXT VARCHAR2(1000);
AUM AUDITORIUM.AUDITORIUM%TYPE;
BEGIN
OPEN CURS_AUT;
FETCH CURS_AUT INTO AUT,CURS_AUM;
WHILE(CURS_AUT%FOUND)
LOOP
TXT:=RTRIM(AUT)||':';
LOOP
FETCH CURS_AUM INTO AUM;
EXIT WHEN CURS_AUM%NOTFOUND;
TXT:=TXT||','||RTRIM(AUM);
END LOOP;
DBMS_OUTPUT.PUT_LINE(TXT);
FETCH CURS_AUT INTO AUT,CURS_AUM;
END LOOP;
CLOSE CURS_AUT;
END;
--17 UPDATE CURRENT OF-----------------------------
DECLARE
CURSOR CURS_AUDITORIUM(CAPACITY AUDITORIUM.AUDITORIUM%TYPE)
IS SELECT AUDITORIUM, AUDITORIUM_CAPACITY
FROM AUDITORIUM
WHERE AUDITORIUM_CAPACITY>= CAPACITY FOR UPDATE;
AUM AUDITORIUM.AUDITORIUM%TYPE;
CTY AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
BEGIN
OPEN CURS_AUDITORIUM(50);
FETCH CURS_AUDITORIUM INTO AUM,CTY;
WHILE (CURS_AUDITORIUM%FOUND)
LOOP
IF CTY>=90
THEN
CTY:=CTY*1.1;
UPDATE AUDITORIUM
SET AUDITORIUM_CAPACITY=CTY
WHERE CURRENT OF CURS_AUDITORIUM;
END IF;
DBMS_OUTPUT.PUT_LINE('  '||AUM||'   '||CTY);
FETCH CURS_AUDITORIUM INTO AUM,CTY;
END LOOP;
CLOSE CURS_AUDITORIUM;
END;
--18 DELECTE CURRENT OF-------------------------------
DECLARE
CURSOR CURS_AUDITORIUM(CAPACITY AUDITORIUM.AUDITORIUM%TYPE)
IS SELECT AUDITORIUM, AUDITORIUM_CAPACITY
FROM AUDITORIUM
WHERE AUDITORIUM_CAPACITY>= CAPACITY FOR UPDATE;
AUM AUDITORIUM.AUDITORIUM%TYPE;
CTY AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
BEGIN
OPEN CURS_AUDITORIUM(50);
FETCH CURS_AUDITORIUM INTO AUM,CTY;
WHILE (CURS_AUDITORIUM%FOUND)
LOOP
IF CTY<=20
THEN
DELETE AUDITORIUM
WHERE CURRENT OF CURS_AUDITORIUM;
END IF;
FETCH CURS_AUDITORIUM INTO AUM,CTY;
END LOOP;
CLOSE CURS_AUDITORIUM;
FOR PP IN CURS_AUDITORIUM(50)
LOOP
DBMS_OUTPUT.PUT_LINE(PP.AUDITORIUM||PP.AUDITORIUM_CAPACITY);
END LOOP;
END;
--------------------------------------
DECLARE
CURSOR CURS_AUDITORIUM(CAPACITY AUDITORIUM.AUDITORIUM%TYPE)
IS SELECT AUDITORIUM, AUDITORIUM_CAPACITY,ROWID
FROM AUDITORIUM
WHERE AUDITORIUM_CAPACITY>= CAPACITY FOR UPDATE;
BEGIN
FOR YYY IN CURS_AUDITORIUM(80)
LOOP
DBMS_OUTPUT.PUT_LINE(YYY.AUDITORIUM||YYY.AUDITORIUM_CAPACITY||YYY.ROWID);
END LOOP;
END;
select rowid,AUDITORIUM from AUDITORIUM;
--20-----------------------------------------------
DECLARE
COU INT:=0;--V ROLI SCETCIKA
CURSOR CURS_TEACHER 
IS SELECT TEACHER,TEACHER_NAME FROM TEACHER;
C_TEACH TEACHER.TEACHER%TYPE;
C_TEACH_NAM TEACHER.TEACHER_NAME%TYPE;
BEGIN
OPEN CURS_TEACHER;
LOOP
FETCH CURS_TEACHER INTO C_TEACH,C_TEACH_NAM;
EXIT WHEN CURS_TEACHER%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(C_TEACH||'   '||C_TEACH_NAM);
COU:=COU+1;
IF COU=3 THEN DBMS_OUTPUT.PUT_LINE('--------------'); COU:=0; END IF;
END LOOP;
CLOSE CURS_TEACHER;
END;

----SELECT * FROM TEACHER;
--INSERT INTO TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT)
--VALUES ('sDSD', 'SDSDSDSDSD', '?', 'SDSDSD');
