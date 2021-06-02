20210 - 0419 - 01)데이터 검색

SELECT  MEM_ID AS 회원번호,
        MEM_NAME AS 회원명, 
        MEM_MEMORIALDAY AS 기념일, 
        MEM_MEMORIAL AS 기념종류, 
        MEM_MILEAGE AS 보유마일지,
        MEM_MILEAGE+50 AS "변경마일리지"
    FROM MEMBER
WHERE EXTRACT(MONTH FROM SYSDATE)= EXTRACT(MONTH FROM  MEM_MEMORIALDAY);
--EXTRACT (=데이터를 추출하는 함수)

SELECT  EMPLOYEE_ID AS 사원번호, 
        FIRST_NAME||' '|| LAST_NAME AS 사원명,
        SALARY AS  급여, 
        NVL(SALARY * COMMISSION_PCT * 0.5,0) AS 보너스, 
        SALARY + NVL(SALARY * COMMISSION_PCT * 0.5,0) AS 지급액
    FROM EMPLOYEES;


SELECT A.BUY_PROD AS 상품코드,
        B.PROD_NAME AS 상품명,
        SUM(A.BUY_QTY) AS 매입수량,
        SUM(A.BUY_QTY*B.PROD_COST) AS 매입금액
FROM BUYPROD A, PROD B
WHERE A.BUY_PROD = B.PROD_ID
    AND BUY_DATE BETWEEN '20050101' AND LAST_DAY('20050201')
    GROUP BY A.BUY_PROD, B.PROD_NAME
    ORDER BY 1;
    

SELECT  EMPLOYEE_ID AS 사원번호, 
        FIRST_NAME ||' '||LAST_NAME AS 사원명, 
        DEPARTMENT_ID AS 부서번호, 
        SALARY AS 급여
FROM EMPLOYEES 
WHERE SALARY >= 10000
ORDER BY SALARY DESC;



SELECT  PROD_ID AS 상품코드, 
        PROD_NAME AS 상품명, 
        PROD_LGU AS 분류코드, 
        PROD_COST AS 판매가격
   FROM PROD
 WHERE  PROD_LGU IN ('P101','P102');
 
SELECT  PROD_ID AS 상품코드, 
        PROD_NAME AS 상품명, 
        PROD_LGU AS 분류코드, 
        PROD_COST AS 판매가격
   FROM PROD
 WHERE  PROD_LGU ='P101' OR PROD_LGU = 'P102';
 
 
SELECT  PROD_ID AS 상품코드, 
        PROD_NAME AS 상품명, 
        PROD_LGU AS 분류코드, 
        PROD_COST AS 판매가격
   FROM PROD
 WHERE  PROD_LGU =ANY ('P101', 'P102');
 
 
SELECT  PROD_ID AS 상품코드, 
        PROD_NAME AS 상품명, 
        PROD_LGU AS 분류코드, 
        PROD_COST AS 판매가격
   FROM PROD
 WHERE  PROD_LGU BETWEEN 'P101' AND 'P102';
 
 
SELECT  MEM_ID AS 회원번호, 
        MEM_NAME AS 회원명, 
        MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호, 
        MEM_MILEAGE AS 마일리지, 
        MEM_JOB AS 직업
 FROM   MEMBER
 WHERE  (SUBSTR(MEM_REGNO2,1,1) = '2' OR SUBSTR(MEM_REGNO2,1,1) = '4')
   AND  MEM_MILEAGE >= 3000
   ;

SELECT  EMPLOYEE_ID AS 사원번호,
        FIRST_NAME||' '||LAST_NAME AS 사원명, 
        DEPARTMENT_ID AS 부서코드,
        HIRE_DATE AS 입사일 
   FROM EMPLOYEES
  WHERE DEPARTMENT_ID IN (10,70,100)
ORDER BY 3;

SELECT  EMPLOYEE_ID AS 사원번호,
        FIRST_NAME||' '||LAST_NAME AS 사원명, 
        DEPARTMENT_ID AS 부서코드,
        HIRE_DATE AS 입사일 
   FROM EMPLOYEES
  WHERE DEPARTMENT_ID = 10
    OR  DEPARTMENT_ID = 20
    OR  DEPARTMENT_ID = 30
    OR  DEPARTMENT_ID = 40
    OR  DEPARTMENT_ID = 50
ORDER BY 3;


SELECT  EMPLOYEE_ID AS 사원번호,
        FIRST_NAME||' '||LAST_NAME AS 사원명, 
        DEPARTMENT_ID AS 부서코드,
        HIRE_DATE AS 입사일 
   FROM EMPLOYEES
  WHERE DEPARTMENT_ID BETWEEN 10 AND 50
ORDER BY 3;


SELECT  EMPLOYEE_ID AS 사원번호,
        FIRST_NAME||' '||LAST_NAME AS 사원명, 
        DEPARTMENT_ID AS 부서코드,
        HIRE_DATE AS 입사일 
   FROM EMPLOYEES
  WHERE DEPARTMENT_ID = 10
    OR  DEPARTMENT_ID = 70
    OR  DEPARTMENT_ID = 100
ORDER BY 3;

SELECT  JOB_ID AS 직무코드,
        JOB_TITLE AS 직무명,
        MIN_SALARY AS 최소급여,
        MAX_SALARY AS 최대급여
 FROM   HR.JOBS
 WHERE  MIN_SALARY >=ANY(4000)
 ORDER BY 3 DESC;

SELECT  MEM_ID AS 회원번호, 
        MEM_NAME AS 회원명, 
        MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
        MEM_MILEAGE AS 마일리지
  FROM  MEMBER
-- WHERE  SUBSTR(MEM_REGNO2,1,1) = ALL('2', '4');
  WHERE SUBSTR(MEM_REGNO2,1,1) =ANY('2', '4');
 
 
 
 
 1) 사워테이블에서 2007년 입사한 사원을 조회하시오.

 Alias는 사원번호, 사원명, 부서명, 입사일, 급여

** JOIN에 사용된 컬럼의 개수 -1개 만큼 조건이 있어야한다.

** DEPARTMENT_ID는 EMPLOYEES TABLE에 없기 때문에 동의명 TABLE 을 만들어서 자료를 추출해야 한다.
 

CREATE SYNONYM DEPARTMENTS FOR HR.DEPARTMENTS;

SELECT  A.EMPLOYEE_ID AS 사원번호, 
        A.FIRST_NAME||' '||LAST_NAME AS 사원명, 
        B.DEPARTMENT_NAME AS 부서명,
        A.HIRE_DATE AS 입사일,
        A.SALARY AS 급여
  FROM  EMPLOYEES A, DEPARTMENTS B
 WHERE  A.DEPARTMENT_ID = B.DEPARTMENT_iD
  -- AND  (A.HIRE_DATE>='20070101'  AND A.HIRE_DATE <= '20071231')
    AND A.HIRE_DATE BETWEEN '20070101' AND '20071213' 
ORDER BY hire_date asc
 ;



2) 회원테이블에서 회원들의 연령대를 구하여 비고란에 연령대를 출력하시오?

Alias는 회원번호, 회원명, 비고, 마일리지

단, 연령대는 10대, 20대, ...등으로 출력하고 나이는 주민번호를 이용한다.

SELECT  MEM_ID      AS 회원번호, 
        MEM_NAME    AS 회원명, 
        TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM TO_DATE(
            CASE WHEN   SUBSTR(MEM_REGNO2,1,1)='1' OR 
                        SUBSTR(MEM_REGNO2,1,1)='2' THEN 
                        1900+TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))
                 ELSE   2000+TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) END,'YYYY')),-1)
                        ||'대'
                    AS 비고,
        MEM_MILEAGE AS 마일리지
FROM    MEMBER
;

3) 장바구니테이블에서 2005년 6월 날짜별 판매현황을 조회하시오?

Alias는 날짜, 판매수량합계, 판매금액합계

SELECT  SUBSTR(CART_NO,1,8) AS 날짜, 
        SUM(CART_QTY) AS "판매수량 합계", 
        SUM(CART_QTY*PROD_PRICE) AS "판매금액 합계"
  FROM  CART, PROD
 WHERE  CART_PROD=PROD_ID
   AND  SUBSTR(CART_NO,1,6)='200506'
 GROUP BY SUBSTR(CART_NO,1,8)
 ORDER BY 1
;


SELECT  MEM_NAME AS 회원명, 
        MEM_ADD1||' '||MEM_ADD2 AS 주소, 
        MEM_JOB AS 직업, 
        MEM_MILEAGE AS 마일리지
 FROM   MEMBER
 WHERE  MEM_ADD1 LIKE '대전%'
;



SELECT  BUY_DATE AS 날짜, 
        BUY_PROD AS 제품코드, 
        BUY_QTY AS 수량
 FROM   BUYPROD
 WHERE  BUY_DATE BETWEEN '20050101' AND LAST_DAY('20050201')
     -- BUY_DATE LIKE '2005/02%'
;


SELECT  PROD_ID AS 상품코드, 
        PROD_NAME AS 상품명, 
        PROD_COST AS 매입단가, 
        PROD_MILEAGE AS 마일리지
 FROM   PROD
 WHERE  PROD_NAME LIKE '%삼성%'
;















        



