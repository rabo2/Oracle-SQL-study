2021 - 0420 - 01)
함수
- 반환값이 존재
- 반환값이 존재하면 SELECT, WHERE 절에 사용가능 프로시져 - 저장 프로시져 -
SELECT
    mem_id AS 회원번호,
    mem_name AS 회원명,
    mem_regno1
    || '-'
    || mem_regno2 AS 주민번호,
    mem_add1
    || ' '
    || mem_add2 AS 주소
FROM
    member
WHERE
    mem_add1 LIKE '충남%';

SELECT
    mem_id AS 회원번호,
    mem_name AS 회원명,
    concat(concat(mem_regno1,'-'),mem_regno2) AS 주민번호,
    concat(concat(mem_add1,' '),mem_add2) AS 주소
FROM
    member
WHERE
    mem_add1 LIKE '충남%';

 
SELECT  PROD_ID AS 상품코드, 
        PROD_NAME AS 상품명, 
        PROD_LGU AS 분류코드, 
        PROD_COST AS 매입가격
 FROM   prod
 WHERE  LOWER(PROD_LGU) = 'p201'
 ;
 
 SELECT MEM_NAME,
        MEM_ADD1||' '||MEM_ADD2
 FROM   MEMBER
 WHERE  UPPER(MEM_ID) = 'D001'
 ;
 
 
SELECT FIRST_NAME,
        LAST_NAME
 FROM   HR.EMPLOYEES
 ;
 
 
 UPDATE HR.EMPLOYEES
 SET    FIRST_NAME=LOWER(FIRST_NAME)  
 ;
 SELECT*FROM HR.EMPLOYEES;
 COMMIT;
 
 
ALTER TABLE HR.EMPLOYEES
 MODIFY (FIRST_NAME VARCHAR2(50));



UPDATE HR.EMPLOYEES
   SET FIRST_NAME=FIRST_NAME;
 
COMMIT;

SELECT FIRST_NAME
 FROM   HR.EMPLOYEES
;
 

SELECT FIRST_NAME FROM HR.EMPLOYEES;

SELECT RTRIM(FIRST_NAME,LOWER(LAST_NAME)) FROM HR.EMPLOYEES;

UPDATE HR.EMPLOYEES
   SET FIRST_NAME=RTRIM(FIRST_NAME,LOWER(LAST_NAME));
 
SELECT FIRST_NAME FROM EMPLOYEES;
 
UPDATE  HR.EMPLOYEES 
  SET   FIRST_NAME = INITCAP(FIRST_NAME)
  ;
 
 commit;
 
ALTER TABLE HR.EMPLOYEES
    RENAME COLUMN FIRST_NAME TO EMP_NAME;
 
ALTER TABLE HR.EMPLOYEES
 DROP COLUMN LAST_NAME;
 
ALTER TABLE MEMBER
MODIFY (MEM_PASS CHAR(20));

ALTER TABLE MEMBER
MODIFY (MEM_PASS VARCHAR2(20));

UPDATE  MEMBER
   SET  MEM_PASS=RTRIM(MEM_PASS)
;
COMMIT;

SELECT LENGTH(MEM_PASS) FROM MEMBER;

INSERT INTO LPROD
 SELECT  MAX(LPROD_ID)+1,
        'P'||TRIM(TO_CHAR(MAX(SUBSTR(LPROD_GU,2))+1)),
        '필기도구'
  FROM  LPROD
 WHERE  LPROD_GU LIKE 'P4%'
  ;


SELECT  SUBSTR('데이터베이스 설계와 OracleSQL',2,5),
        SUBSTR('데이터베이스 설계와 OracleSQL',2,30),
        SUBSTR('데이터베이스 설계와 OracleSQL',2),
        SUBSTR('데이터베이스 설계와 OracleSQL',-10,5)
  FROM  DUAL;
  
  
  
SELECT  MEM_HP
   FROM  MEMBER
;

UPDATE   MEMBER
   SET  MEM_HP=REPLACE(MEM_HP,'016','010');
UPDATE   MEMBER
   SET  MEM_HP=REPLACE(MEM_HP,'011','010');
UPDATE   MEMBER
   SET  MEM_HP=REPLACE(MEM_HP,'019','010');
UPDATE   MEMBER
   SET  MEM_HP=REPLACE(MEM_HP,'017','010');
UPDATE   MEMBER
   SET  MEM_HP=REPLACE(MEM_HP,'018','010');

COMMIT;

SELECT  MEM_NAME AS 이름, 
        MEM_ADD1||' '||MEM_ADD2 AS 주소, 
        MEM_MILEAGE AS 마일리지
  FROM  MEMBER
 WHERE  MEM_ADD1 LIKE '대전%'
-- WHERE SUBSTR(MEM_ADD1,1,2) = '대전'
ORDER BY 3
 ;


SELECT  MEM_ADD1,
        REPLACE(MEM_ADD1,' ')
  FROM  MEMBER
;


SELECT  INSTR('Hello Heidi','e',1,2),
        INSTR('Hello Heidi','e',3),
        INSTR('Hello Heidi','e'),
        INSTR('Hello Heidi','e',9,2),
        INSTR('Hello Heidi','e',-3,2)
  FROM  DUAL
;




