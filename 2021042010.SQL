2021 - 0420 - 01)
�Լ�
- ��ȯ���� ����
- ��ȯ���� �����ϸ� SELECT, WHERE ���� ��밡�� ���ν��� - ���� ���ν��� -
SELECT
    mem_id AS ȸ����ȣ,
    mem_name AS ȸ����,
    mem_regno1
    || '-'
    || mem_regno2 AS �ֹι�ȣ,
    mem_add1
    || ' '
    || mem_add2 AS �ּ�
FROM
    member
WHERE
    mem_add1 LIKE '�泲%';

SELECT
    mem_id AS ȸ����ȣ,
    mem_name AS ȸ����,
    concat(concat(mem_regno1,'-'),mem_regno2) AS �ֹι�ȣ,
    concat(concat(mem_add1,' '),mem_add2) AS �ּ�
FROM
    member
WHERE
    mem_add1 LIKE '�泲%';

 
SELECT  PROD_ID AS ��ǰ�ڵ�, 
        PROD_NAME AS ��ǰ��, 
        PROD_LGU AS �з��ڵ�, 
        PROD_COST AS ���԰���
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
        '�ʱ⵵��'
  FROM  LPROD
 WHERE  LPROD_GU LIKE 'P4%'
  ;


SELECT  SUBSTR('�����ͺ��̽� ����� OracleSQL',2,5),
        SUBSTR('�����ͺ��̽� ����� OracleSQL',2,30),
        SUBSTR('�����ͺ��̽� ����� OracleSQL',2),
        SUBSTR('�����ͺ��̽� ����� OracleSQL',-10,5)
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

SELECT  MEM_NAME AS �̸�, 
        MEM_ADD1||' '||MEM_ADD2 AS �ּ�, 
        MEM_MILEAGE AS ���ϸ���
  FROM  MEMBER
 WHERE  MEM_ADD1 LIKE '����%'
-- WHERE SUBSTR(MEM_ADD1,1,2) = '����'
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



