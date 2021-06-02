2021-0503-01



SELECT COUNT(*)
FROM   PROD
WHERE  PROD_PRICE > (SELECT AVG(PROD_PRICE)
                      FROM  PROD);

SELECT  COUNT(*)
FROM    PROD A,(SELECT  AVG(PROD_PRICE) AS APRICE
                  FROM  PROD) B
WHERE A.PROD_PRICE > B.APRICE;


SELECT
    PROD_ID 상품코드,
    PROD_NAME 상품명,
    PROD_LGU 분류코드,
    PROD_COST 매입가격
FROM
    PROD
WHERE 
    PROD_LGU =SOME (SELECT DISTINCT PROD_LGU
                     FROM  PROD
                    WHERE  PROD_LGU LIKE 'P3%')
;

SELECT
    PROD_ID 상품코드,
    PROD_NAME 상품명,
    PROD_LGU 분류코드,
    PROD_COST 매입가격
FROM
    PROD
WHERE 
    EXISTS (SELECT 1
              FROM LPROD
             WHERE LPROD_GU LIKE 'P3%'
                   AND PROD_LGU = LPROD_GU)
;


사원테이블의 사원번호, 직무코드가 직무변동테이블(JOB_HISTORY)의
사원번호, 직무코드와 동일한 사원정보를 출력하시오.
Alias는 사원번호, 사원명, 부서명, 입사일

SELECT
    A.EMPLOYEE_ID 사원번호, 
    A.EMP_NAME 사원명, 
    B.DEPARTMENT_NAME 부서명, 
    A.HIRE_DATE 입사일
FROM
    HR.EMPLOYEES A, HR.DEPARTMENTS B
WHERE
    (A.EMPLOYEE_ID, A.JOB_ID) IN (SELECT EMPLOYEE_ID, JOB_ID
                                    FROM HR.JOB_HISTORY)
    AND A.DEPARTMENT_ID = B.DEPARTMENT_ID    
    
    
SELECT
    A.EMPLOYEE_ID 사원번호, 
    A.EMP_NAME 사원명, 
    B.DEPARTMENT_NAME 부서명, 
    A.HIRE_DATE 입사일
FROM
    HR.EMPLOYEES A, HR.DEPARTMENTS B
WHERE
    (A.EMPLOYEE_ID, A.JOB_ID) EXISTS (SELECT EMPLOYEE_ID, JOB_ID
                                        FROM HR.JOB_HISTORY C
                                       WHERE A.EMPLOYEE_ID = C.EMPLOYEE_ID)
    AND A.DEPARTMENT_ID = B.DEPARTMENT_ID  
    
    
    
    
**재고수불테이블 아래 조건대로 생성하시오

1) 테이블명 : REMAIN
----------------------------------------------------
컬러명         데이터타입         N.N       PK/FK
----------------------------------------------------
REMAIN_YEAR     CHAR(4)         N.N         PK
PROD_ID         VARCHAR2(10)    N.N         PK&FK
REMAIN_J_00     NUMBER(5)       DEFAULT 0
REMAIN_I        NUMBER(5)       
REMAIN_O        NUMBER(5)       
REMAIN_J_99     NUMBER(5)  
REMAIN_DATE     DATE
------------------------------------------------------

CREATE TABLE REMAIN(
    REMAIN_YEAR CHAR(4),
    PROD_ID     VARCHAR2(10),
    REMAIN_J_00 NUMBER(5) DEFAULT 0,
    REMAIN_I    NUMBER(5),
    REMAIN_O    NUMBER(5),
    REMAIN_J_99 NUMBER(5),
    REMAIN_DATE DATE,
CONSTRAINT PK_REMAIN PRIMARY KEY (REMAIN_YEAR, PROD_ID),
CONSTRAINT FK_REMAIN_PROD FOREIGN KEY(PROD_ID)
REFERENCES PROD(PROD_ID));

INSERT INTO remain (remain_year,PROD_ID,remain_j_00,remain_I,
                    remain_O,REMAIN_J_99,remain_DATE) 
    SELECT 
        '2005',
        PROD_ID,
        PROD_PROPERSTOCK,
        0,
        0,
        PROD_PROPERSTOCK,
        TO_DATE('20050103')
    FROM    
        PROD
;
