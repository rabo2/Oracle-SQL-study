2021 - 04 - 30 - 01

2005년 거래처별 매출현황을 조회하시오.
Alias 는 거래처코드, 거래처명, 매출수량, 금액

SELECT
    B.PROD_BUYER AS 거래처코드, 
    A.BUYER_NAME AS 거래처명, 
    SUM(C.CART_QTY) AS 매출수량, 
    SUM(C.CART_QTY*B.PROD_PRICE) AS 금액
from
    BUYER A, PROD B, CART C
WHERE
    C.CART_NO LIKE '2005%' AND
    A.BUYER_ID = B.PROD_BUYER AND
    C.CART_PROD = B.PROD_ID 
GROUP BY
   B.PROD_BUYER,  A.BUYER_NAME
ORDER BY 1
;

(IN 연사자)
SELECT
    A.DEPARTMENT_ID 부서코드,
    A.DEPARTMENT_NAME 부서명
FROM
    HR.DEPARTMENTS A
WHERE 
    A.DEPARTMENT_ID IN (SELECT   DISTINCT DEPARTMENT_ID
                        FROM    HR.EMPLOYEES
                        WHERE   SALARY >= 10000);
(EXISTS 연산자)               
SELECT
    A.DEPARTMENT_ID 부서코드,
    A.DEPARTMENT_NAME 부서명
FROM
    HR.DEPARTMENTS A
WHERE 
    EXISTS(SELECT   1
            FROM    HR.EMPLOYEES B
            WHERE   B.SALARY >= 10000
             AND    A.DEPARTMENT_ID =  B.DEPARTMENT_ID)
;

UPDATE
    HR.Departments
SET
    MANAGER_ID = ''
WHERE
    DEPARTMENT_ID = 60;
COMMIT;
 
(IN 연산자) 
SELECT
    A.EMPLOYEE_ID AS 사원번호, 
    A.EMP_NAME AS 사원명, 
    A.DEPARTMENT_ID AS 부서코드, 
    B.DEPARTMENT_NAME AS 부서명
FROM
    HR.EMPLOYEES A, HR.Departments B
WHERE
    A.DEPARTMENT_ID = B.Department_Id AND
    A.Department_Id NOT IN (SELECT DEPARTMENT_ID
                            FROM HR.DEPARTMENTS
                            WHERE MANAGER_ID IS NULL);
                            
                            

(IN 연산자 사용)
 SELECT A.DEPARTMENT_NAME 부서명, 
        A.DEPARTMENT_ID 부서코드
   FROM DEPARTMENTS A
  WHERE A.DEPARTMENT_ID IN (SELECT B.DEPARTMENT_ID
                              FROM EMPLOYEES B
                             WHERE B.DEPARTMENT_ID = A.DEPARTMENT_ID
                               AND B.SALARY > (SELECT AVG(SALARY)
                                                 FROM EMPLOYEES
                                                WHERE DEPARTMENT_ID=A.DEPARTMENT_ID));
                    
                                                
                            

                            
