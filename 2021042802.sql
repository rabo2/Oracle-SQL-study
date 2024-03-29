2021 - 0428 - 02
SELECT
    COUNT(*) AS "buyprod의 행의 수"
FROM
    buyprod; --148개 행

SELECT
    COUNT(*) AS "cart의 행의 수"
FROM
    cart; -- 207개 행

SELECT
    COUNT(*)
FROM
    BUYPROD,
    MEMBER,
    CART,
    PROD; -- 2267064개 행
    

SELECT  A.EMPLOYEE_ID AS 사원번호, 
        A.EMP_NAME AS 사원명, 
        B.DEPARTMENT_ID AS 부서코드, 
        B.DEPARTMENT_NAME AS 부서명
FROM    HR.EMPLOYEES A, HR.DEPARTMENTS B
WHERE   A.DEPARTMENT_ID<=80 AND -- 일반조건
        A.DEPARTMENT_ID = B.DEPARTMENT_ID
        --Join 조건
ORDER BY 1
;

SELECT  A.EMPLOYEE_ID AS 사원번호, 
        A.EMP_NAME AS 사원명, 
        B.DEPARTMENT_ID AS 부서코드, 
        B.DEPARTMENT_NAME AS 부서명
FROM    HR.EMPLOYEES A INNER JOIN 
        HR.DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID) --Join조건
        AND A.DEPARTMENT_ID<=80 -- EMPLOYEES와 DEPARTMENTS에 적용되는 일반조건
ORDER BY 1
;

SELECT  
    B.BUYER_ID AS 거래처코드, 
    B.BUYER_NAME AS 거래처명, 
    SUM(A.BUY_QTY) AS 매입수량, 
    SUM(A.BUY_COST*A.BUY_QTY) AS 매입금액
  FROM  
    BUYPROD A, BUYER B, PROD C
 WHERE  
    A.BUY_PROD =  C.PROD_ID  -- 조인조건
    AND B.BUYER_ID = C.PROD_BUYER  -- 조인조건
    AND A.BUY_DATE BETWEEN '20050101' AND '20050131' -- 일반조건
GROUP BY 
    B.BUYER_ID,B.BUYER_NAME
ORDER BY 1
;




SELECT  
    B.BUYER_ID AS 거래처코드, 
    B.BUYER_NAME AS 거래처명, 
    SUM(A.BUY_QTY) AS 매입수량, 
    SUM(A.BUY_COST*A.BUY_QTY) AS 매입금액
FROM  
    BUYPROD A 
INNER JOIN PROD C ON(A.BUY_PROD =  C.PROD_ID)
           AND A.BUY_DATE BETWEEN '20050101' AND '20050131'
    INNER JOIN BUYER B ON(B.BUYER_ID = C.PROD_BUYER)
GROUP BY
    B.BUYER_ID, B.BUYER_NAME
ORDER BY 1
;


SELECT  
    B.BUYER_ID AS 거래처코드, 
    B.BUYER_NAME AS 거래처명, 
    NVL(SUM(A.BUY_QTY),0) AS 매입수량, 
    NVL(SUM(A.BUY_COST*A.BUY_QTY),0) AS 매입금액
FROM  
    BUYPROD A 
    LEFT OUTER JOIN PROD C ON(A.BUY_PROD =  C.PROD_ID)
           AND A.BUY_DATE BETWEEN '20050101' AND '20050131'
    RIGHT OUTER JOIN BUYER B ON(B.BUYER_ID = C.PROD_BUYER)
GROUP BY
    B.BUYER_ID, B.BUYER_NAME
ORDER BY 1
;


SELECT  
    B.BUYER_ID AS 거래처코드, 
    B.BUYER_NAME AS 거래처명, 
    NVL(SUM(A.BUY_QTY),0) AS 매입수량, 
    NVL(SUM(A.BUY_COST*A.BUY_QTY),0) AS 매입금액
FROM  
    BUYPROD A 
    LEFT OUTER JOIN PROD C ON(A.BUY_PROD =  C.PROD_ID)
    RIGHT OUTER JOIN BUYER B ON(B.BUYER_ID = C.PROD_BUYER)
WHERE
    A.BUY_DATE BETWEEN '20050101' AND '20050131'
GROUP BY
    B.BUYER_ID, B.BUYER_NAME
ORDER BY 1
;