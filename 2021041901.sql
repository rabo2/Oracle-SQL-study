20210 - 0419 - 01)������ �˻�

SELECT  MEM_ID AS ȸ����ȣ,
        MEM_NAME AS ȸ����, 
        MEM_MEMORIALDAY AS �����, 
        MEM_MEMORIAL AS �������, 
        MEM_MILEAGE AS ����������,
        MEM_MILEAGE+50 AS "���渶�ϸ���"
    FROM MEMBER
WHERE EXTRACT(MONTH FROM SYSDATE)= EXTRACT(MONTH FROM  MEM_MEMORIALDAY);
--EXTRACT (=�����͸� �����ϴ� �Լ�)

SELECT  EMPLOYEE_ID AS �����ȣ, 
        FIRST_NAME||' '|| LAST_NAME AS �����,
        SALARY AS  �޿�, 
        NVL(SALARY * COMMISSION_PCT * 0.5,0) AS ���ʽ�, 
        SALARY + NVL(SALARY * COMMISSION_PCT * 0.5,0) AS ���޾�
    FROM EMPLOYEES;


SELECT A.BUY_PROD AS ��ǰ�ڵ�,
        B.PROD_NAME AS ��ǰ��,
        SUM(A.BUY_QTY) AS ���Լ���,
        SUM(A.BUY_QTY*B.PROD_COST) AS ���Աݾ�
FROM BUYPROD A, PROD B
WHERE A.BUY_PROD = B.PROD_ID
    AND BUY_DATE BETWEEN '20050101' AND LAST_DAY('20050201')
    GROUP BY A.BUY_PROD, B.PROD_NAME
    ORDER BY 1;
    

SELECT  EMPLOYEE_ID AS �����ȣ, 
        FIRST_NAME ||' '||LAST_NAME AS �����, 
        DEPARTMENT_ID AS �μ���ȣ, 
        SALARY AS �޿�
FROM EMPLOYEES 
WHERE SALARY >= 10000
ORDER BY SALARY DESC;



SELECT  PROD_ID AS ��ǰ�ڵ�, 
        PROD_NAME AS ��ǰ��, 
        PROD_LGU AS �з��ڵ�, 
        PROD_COST AS �ǸŰ���
   FROM PROD
 WHERE  PROD_LGU IN ('P101','P102');
 
SELECT  PROD_ID AS ��ǰ�ڵ�, 
        PROD_NAME AS ��ǰ��, 
        PROD_LGU AS �з��ڵ�, 
        PROD_COST AS �ǸŰ���
   FROM PROD
 WHERE  PROD_LGU ='P101' OR PROD_LGU = 'P102';
 
 
SELECT  PROD_ID AS ��ǰ�ڵ�, 
        PROD_NAME AS ��ǰ��, 
        PROD_LGU AS �з��ڵ�, 
        PROD_COST AS �ǸŰ���
   FROM PROD
 WHERE  PROD_LGU =ANY ('P101', 'P102');
 
 
SELECT  PROD_ID AS ��ǰ�ڵ�, 
        PROD_NAME AS ��ǰ��, 
        PROD_LGU AS �з��ڵ�, 
        PROD_COST AS �ǸŰ���
   FROM PROD
 WHERE  PROD_LGU BETWEEN 'P101' AND 'P102';
 
 
SELECT  MEM_ID AS ȸ����ȣ, 
        MEM_NAME AS ȸ����, 
        MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ, 
        MEM_MILEAGE AS ���ϸ���, 
        MEM_JOB AS ����
 FROM   MEMBER
 WHERE  (SUBSTR(MEM_REGNO2,1,1) = '2' OR SUBSTR(MEM_REGNO2,1,1) = '4')
   AND  MEM_MILEAGE >= 3000
   ;

SELECT  EMPLOYEE_ID AS �����ȣ,
        FIRST_NAME||' '||LAST_NAME AS �����, 
        DEPARTMENT_ID AS �μ��ڵ�,
        HIRE_DATE AS �Ի��� 
   FROM EMPLOYEES
  WHERE DEPARTMENT_ID IN (10,70,100)
ORDER BY 3;

SELECT  EMPLOYEE_ID AS �����ȣ,
        FIRST_NAME||' '||LAST_NAME AS �����, 
        DEPARTMENT_ID AS �μ��ڵ�,
        HIRE_DATE AS �Ի��� 
   FROM EMPLOYEES
  WHERE DEPARTMENT_ID = 10
    OR  DEPARTMENT_ID = 20
    OR  DEPARTMENT_ID = 30
    OR  DEPARTMENT_ID = 40
    OR  DEPARTMENT_ID = 50
ORDER BY 3;


SELECT  EMPLOYEE_ID AS �����ȣ,
        FIRST_NAME||' '||LAST_NAME AS �����, 
        DEPARTMENT_ID AS �μ��ڵ�,
        HIRE_DATE AS �Ի��� 
   FROM EMPLOYEES
  WHERE DEPARTMENT_ID BETWEEN 10 AND 50
ORDER BY 3;


SELECT  EMPLOYEE_ID AS �����ȣ,
        FIRST_NAME||' '||LAST_NAME AS �����, 
        DEPARTMENT_ID AS �μ��ڵ�,
        HIRE_DATE AS �Ի��� 
   FROM EMPLOYEES
  WHERE DEPARTMENT_ID = 10
    OR  DEPARTMENT_ID = 70
    OR  DEPARTMENT_ID = 100
ORDER BY 3;

SELECT  JOB_ID AS �����ڵ�,
        JOB_TITLE AS ������,
        MIN_SALARY AS �ּұ޿�,
        MAX_SALARY AS �ִ�޿�
 FROM   HR.JOBS
 WHERE  MIN_SALARY >=ANY(4000)
 ORDER BY 3 DESC;

SELECT  MEM_ID AS ȸ����ȣ, 
        MEM_NAME AS ȸ����, 
        MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
        MEM_MILEAGE AS ���ϸ���
  FROM  MEMBER
-- WHERE  SUBSTR(MEM_REGNO2,1,1) = ALL('2', '4');
  WHERE SUBSTR(MEM_REGNO2,1,1) =ANY('2', '4');
 
 
 
 
 1) ������̺��� 2007�� �Ի��� ����� ��ȸ�Ͻÿ�.

 Alias�� �����ȣ, �����, �μ���, �Ի���, �޿�

** JOIN�� ���� �÷��� ���� -1�� ��ŭ ������ �־���Ѵ�.

** DEPARTMENT_ID�� EMPLOYEES TABLE�� ���� ������ ���Ǹ� TABLE �� ���� �ڷḦ �����ؾ� �Ѵ�.
 

CREATE SYNONYM DEPARTMENTS FOR HR.DEPARTMENTS;

SELECT  A.EMPLOYEE_ID AS �����ȣ, 
        A.FIRST_NAME||' '||LAST_NAME AS �����, 
        B.DEPARTMENT_NAME AS �μ���,
        A.HIRE_DATE AS �Ի���,
        A.SALARY AS �޿�
  FROM  EMPLOYEES A, DEPARTMENTS B
 WHERE  A.DEPARTMENT_ID = B.DEPARTMENT_iD
  -- AND  (A.HIRE_DATE>='20070101'  AND A.HIRE_DATE <= '20071231')
    AND A.HIRE_DATE BETWEEN '20070101' AND '20071213' 
ORDER BY hire_date asc
 ;



2) ȸ�����̺��� ȸ������ ���ɴ븦 ���Ͽ� ������ ���ɴ븦 ����Ͻÿ�?

Alias�� ȸ����ȣ, ȸ����, ���, ���ϸ���

��, ���ɴ�� 10��, 20��, ...������ ����ϰ� ���̴� �ֹι�ȣ�� �̿��Ѵ�.

SELECT  MEM_ID      AS ȸ����ȣ, 
        MEM_NAME    AS ȸ����, 
        TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM TO_DATE(
            CASE WHEN   SUBSTR(MEM_REGNO2,1,1)='1' OR 
                        SUBSTR(MEM_REGNO2,1,1)='2' THEN 
                        1900+TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))
                 ELSE   2000+TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) END,'YYYY')),-1)
                        ||'��'
                    AS ���,
        MEM_MILEAGE AS ���ϸ���
FROM    MEMBER
;

3) ��ٱ������̺��� 2005�� 6�� ��¥�� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�?

Alias�� ��¥, �Ǹż����հ�, �Ǹűݾ��հ�

SELECT  SUBSTR(CART_NO,1,8) AS ��¥, 
        SUM(CART_QTY) AS "�Ǹż��� �հ�", 
        SUM(CART_QTY*PROD_PRICE) AS "�Ǹűݾ� �հ�"
  FROM  CART, PROD
 WHERE  CART_PROD=PROD_ID
   AND  SUBSTR(CART_NO,1,6)='200506'
 GROUP BY SUBSTR(CART_NO,1,8)
 ORDER BY 1
;


SELECT  MEM_NAME AS ȸ����, 
        MEM_ADD1||' '||MEM_ADD2 AS �ּ�, 
        MEM_JOB AS ����, 
        MEM_MILEAGE AS ���ϸ���
 FROM   MEMBER
 WHERE  MEM_ADD1 LIKE '����%'
;



SELECT  BUY_DATE AS ��¥, 
        BUY_PROD AS ��ǰ�ڵ�, 
        BUY_QTY AS ����
 FROM   BUYPROD
 WHERE  BUY_DATE BETWEEN '20050101' AND LAST_DAY('20050201')
     -- BUY_DATE LIKE '2005/02%'
;


SELECT  PROD_ID AS ��ǰ�ڵ�, 
        PROD_NAME AS ��ǰ��, 
        PROD_COST AS ���Դܰ�, 
        PROD_MILEAGE AS ���ϸ���
 FROM   PROD
 WHERE  PROD_NAME LIKE '%�Ｚ%'
;















        



