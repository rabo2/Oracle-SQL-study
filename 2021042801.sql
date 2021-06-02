2021-0428-01
--GROUPBY 연령 시간대 성별 는 모든 컬럼이 기준이 되는 결과를 도출하고
--ROLLUP



SELECT  PROD_LGU AS 구분코드, 
        PROD_BUYER AS 거래처코드, 
        COUNT(*) AS "상품의 수"
 FROM   PROD
GROUP BY PROD_LGU, PROD_BUYER
ORDER BY 1
;

SELECT  PROD_LGU AS 구분코드, 
        PROD_BUYER AS 거래처코드, 
        COUNT(*) AS "상품의 수"
 FROM   PROD
GROUP BY ROLLUP(PROD_LGU, PROD_BUYER)
ORDER BY 1
;

SELECT  PROD_LGU AS 구분코드, 
        PROD_BUYER AS 거래처코드, 
        COUNT(*) AS "상품의 수"
 FROM   PROD
GROUP BY CUBE(PROD_LGU, PROD_BUYER)
ORDER BY 1
;