2021-0504-01

SELECT
    A.DEPARTMENT_ID 부서코드,
    A.DEPARTMENT_NAME 부서명,
    B.EMP_NAME 관리사원명
FROM
    HR.DEPARTMENTS A, HR.EMPLOYEES B
WHERE
    A.MANAGER_ID = B.EMPLOYEE_ID AND
    EXISTS (SELECT 1
              FROM HR.JOB_HISTORY C
             WHERE C.DEPARTMENT_ID = A.DEPARTMENT_ID)
;

SELECT DISTINCT A.DEPARTMENT_ID 부서코드,
       (SELECT DEPARTMENT_NAME
          FROM HR.DEPARTMENTS B
         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID) 부서명,
       (SELECT EMP_NAME
          FROM HR.DEPARTMENTS C, EMPLOYEES D
         WHERE C.DEPARTMENT_ID = D.DEPARTMENT_ID
           AND A.EMPLOYEE_ID = d.employee_id) 관리사원명
FROM   HR.JOB_HISTORY A
ORDER BY 1;


근무지역이 'Americas'인 사원들의 평균 근속년수보다 많은 근속년수를 유지하는 사원정보
Alias는 사원번호, 사원명, 부서명, 부서위치, 근속년수를 조회
REGIONS - COUNTRIES - LOCATIONS - DEPARTMENT - EMPLOYEES



SELECT F.EMPLOYEE_ID AS 사원번호,
       F.EMP_NAME AS 사원명,
       G.DEPARTMENT_NAME AS 부서명,
       H.STREET_ADDRESS||' '||H.CITY||' '||STATE_PROVINCE||' '||
       I.COUNTRY_NAME AS 부서위치,
       EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM F.HIRE_DATE) AS 근속년수
  FROM HR.EMPLOYEES F,HR.DEPARTMENTS G,HR.LOCATIONS H,HR.COUNTRIES I, 
       (SELECT E.REGION_ID AS RID,
               E.REGION_NAME AS RNAME,
               ROUND(AVG(EXTRACT(YEAR FROM SYSDATE)-
               EXTRACT(YEAR FROM HIRE_DATE))) AS CSY       
          FROM HR.EMPLOYEES A,HR.DEPARTMENTS B,HR.LOCATIONS D,
               HR.COUNTRIES C,HR.REGIONS E
         WHERE E.REGION_ID=C.REGION_ID
           AND C.COUNTRY_ID=D.COUNTRY_ID
           AND D.LOCATION_ID=B.LOCATION_ID
           AND B.DEPARTMENT_ID=A.DEPARTMENT_ID
         GROUP BY E.REGION_ID,E.REGION_NAME) TBLD
 WHERE TBLD.RNAME='Americas'
   AND (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM F.HIRE_DATE))>TBLD.CSY
   AND TBLD.RID=I.REGION_ID
   AND I.COUNTRY_ID=H.COUNTRY_ID
   AND H.LOCATION_ID=G.LOCATION_ID
   AND G.DEPARTMENT_ID=F.DEPARTMENT_ID
   order by 1
    

근무지역이 'Americas'인 사원들의 평균 근속년수보다 많은 근속년수를 유지하는 사원들의 급여를 12% 인상하시오.


 SELECT    A.EMPLOYEE_ID 사원번호,
           A.EMP_NAME 사원명,
           A.SALARY 급여, 
           A.SALARY + ROUND(A.SALARY*0.12) 인상급여
    FROM HR.EMPLOYEES A
        WHERE EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM A.HIRE_DATE)
                > (SELECT AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE))
                FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS D, HR.COUNTRIES C, HR.REGIONS E
                WHERE E.REGION_NAME = 'Americas'
                      AND E.REGION_ID = C.REGION_ID
                      AND C.COUNTRY_ID = D.COUNTRY_ID
                      AND D.LOCATION_ID = B.LOCATION_ID
                      AND B.DEPARTMENT_ID = A.DEPARTMENT_ID)
                AND A.DEPARTMENT_ID IN(
                    SELECT B.DEPARTMENT_ID
                        FROM HR.DEPARTMENTS B,HR.LOCATIONS D,HR.COUNTRIES C,HR.REGIONS E
                        WHERE E.REGION_NAME = 'Americas'
                            AND E.REGION_ID = C.REGION_ID
                            AND C.COUNTRY_ID = D.COUNTRY_ID
                            AND D.LOCATION_ID = B.LOCATION_ID)
                            
                            ORDER BY 1;
                            
UPDATE EMPLOYEES T
       SET T.SALARY =  T.SALARY+(T.SALARY*0.12)
       WHERE T.EMPLOYEE_ID IN (SELECT F.EMPLOYEE_ID
                                FROM HR.EMPLOYEES F,HR.DEPARTMENTS G,HR.LOCATIONS H,HR.COUNTRIES I, 
                                    (SELECT E.REGION_ID AS RID,
                                            E.REGION_NAME AS RNAME,
                                            AVG(EXTRACT(YEAR FROM SYSDATE)-
                                            EXTRACT(YEAR FROM HIRE_DATE)) AS CSY       
                                       FROM HR.EMPLOYEES A,HR.DEPARTMENTS B,HR.LOCATIONS D,
                                            HR.COUNTRIES C,HR.REGIONS E
                                      WHERE E.REGION_ID=C.REGION_ID
                                        AND C.COUNTRY_ID=D.COUNTRY_ID
                                        AND D.LOCATION_ID=B.LOCATION_ID
                                        AND B.DEPARTMENT_ID=A.DEPARTMENT_ID
                                     GROUP BY E.REGION_ID,E.REGION_NAME) TBLD
                                 WHERE TBLD.RNAME='Americas'
                                   AND (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM F.HIRE_DATE))>TBLD.CSY
                                   AND TBLD.RID=I.REGION_ID
                                   AND I.COUNTRY_ID=H.COUNTRY_ID
                                   AND H.LOCATION_ID=G.LOCATION_ID
                                   AND G.DEPARTMENT_ID=F.DEPARTMENT_ID);
                                   
                                   
2005년 1-6월 모든 거래처별 매입금액합계와 매입수량합계를 조회하시오
메인쿼리
SELECT D.BUYER_NAME AS 거래처명, 
       NVL(E.SAMT,0) AS 매입수량합계, 
       NVL(E.CAMT,0) AS 매입금액합계 
  FROM BUYER D, (SELECT A.BUYER_ID BID, 
                        SUM(BUY_QTY) SAMT, 
                        SUM(BUY_QTY*BUY_COST) CAMT
                   FROM BUYER A, PROD B, BUYPROD C
                  WHERE A.BUYER_ID = B.PROD_BUYER
                    AND C.BUY_PROD = B.PROD_ID
                    AND C.BUY_DATE BETWEEN '20050101' AND '20050630'
                 GROUP BY A.BUYER_ID ) E
 WHERE D.BUYER_ID = E.BID(+);


서브쿼리 2005년 1-6월 거래처별 매입금액합계와 매입수량합계
SELECT A.BUYER_ID, 
       SUM(BUY_QTY), 
       SUM(BUY_QTY*BUY_COST)
  FROM BUYER A, PROD B, BUYPROD C
 WHERE A.BUYER_ID = B.PROD_BUYER
   AND C.BUY_PROD = B.PROD_ID
   AND C.BUY_DATE BETWEEN '20050101' AND '20050630'
GROUP BY A.BUYER_ID

2005년 4월 모든 거래처별 매입금액합계와 매출금액합계를 서브쿼리를 이용하여 조회하시오
Alias는 거래처코드, 거래처명, 매입금액합계, 매출금액합계

          
SELECT A.BUYER_ID AS 거래처코드,
       A.BUYER_NAME AS 거래처명,
       NVL(B.BSUM,0) AS 매입금액합계,
       NVL(C.CSUM,0) AS 매출금액합계
  FROM BUYER A,
       (SELECT PROD_BUYER BBUYER,
               SUM(BUY_QTY*BUY_COST) BSUM
          FROM PROD, BUYPROD
         WHERE PROD_ID = BUY_PROD
           AND BUY_DATE BETWEEN '20050401' AND '20050430'
         GROUP BY PROD_BUYER) B,
      (SELECT PROD_BUYER CBUYER,
              SUM(CART_QTY*PROD_PRICE) CSUM
         FROM CART,PROD
        WHERE CART_PROD = PROD_ID
          AND CART_NO LIKE '200504%'
       GROUP BY PROD_BUYER) C
 WHERE A.BUYER_ID = B.BBUYER(+) 
   AND A.BUYER_ID = C.CBUYER(+)
ORDER BY 1

SELECT A.BUYER_ID AS 거래처코드,
       A.BUYER_NAME AS 거래처명,
       NVL(B.BSUM,0) AS 매입금액합계,
       NVL(C.CSUM,0) AS 매출금액합계
  FROM BUYER A 
       LEFT JOIN
       (SELECT PROD_BUYER BPROD,
               SUM(BUY_QTY*BUY_COST) BSUM
          FROM PROD, BUYPROD
         WHERE PROD_ID = BUY_PROD
           AND BUY_DATE BETWEEN '20050401' AND '20050430'
         GROUP BY PROD_BUYER) B ON A.BUYER_ID = B.BPROD 
       LEFT JOIN
      (SELECT PROD_BUYER CBUYER,
              SUM(CART_QTY*PROD_PRICE) CSUM
         FROM CART,PROD
        WHERE CART_PROD = PROD_ID
          AND CART_NO LIKE '200504%'
       GROUP BY PROD_BUYER) C ON A.BUYER_ID = C.CBUYER

