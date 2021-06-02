2021-05-06-01

1) 테이블명 : EXP_GOODS_ASIA
2) 컬럼
----------------------------------------
컬럼명     데이터 타입      제약사항
----------------------------------------
COUNTRY     VARCHAR(20)
SEQ         NUMBER
GOODS       VARCHAR2(100)
----------------------------------------
3)데이터
-----------------------------------------
COUNTRY     SEQ     GOODS
----------------------------------------
대한민국       1       원유제외석유류
대한민국       2       자동차
대한민국       3       전자집적회로
대한민국       4       선박
대한민국       5       LCD
대한민국       6       자동차부품
대한민국       7       휴대전화
대한민국       8       환식탄화수소
대한민국       9       무선송신기 디스플레이 부품
대한민국       10      철 또는 비합금강

INSERT INTO EXP_GOODS_ASIA
VALUES ('대한민국',1,'원유제외 석유류');
INSERT INTO EXP_GOODS_ASIA
VALUES ('대한민국',2,'자동차');
INSERT INTO EXP_GOODS_ASIA
VALUES ('대한민국',3,'전자집적회로');
INSERT INTO EXP_GOODS_ASIA
VALUES ('대한민국',4,'선박');
INSERT INTO EXP_GOODS_ASIA
VALUES ('대한민국',5,'LCD');
INSERT INTO EXP_GOODS_ASIA
VALUES ('대한민국',6,'자동차부품');
INSERT INTO EXP_GOODS_ASIA
VALUES ('대한민국',7,'휴대전화');
INSERT INTO EXP_GOODS_ASIA
VALUES ('대한민국',8,'환식탄화수소');
INSERT INTO EXP_GOODS_ASIA
VALUES ('대한민국',9,'무선송신기 디스플레이 부품');
INSERT INTO EXP_GOODS_ASIA
VALUES ('대한민국',10,'철 또는 비합금강');
-------------------------------------------
일본         1       자동차
일본          2       전자집적회로
일본          3       선박
일본          4       반도체 웨이퍼
일본          5       화물차
일본          6       원유제외 석유류
일본          7       원유제외석유류
일본          8       건설기계
일본          9       다이오드,트렌지스터
일본          10      기계류

INSERT INTO EXP_GOODS_ASIA
VALUES ('일본',1,'자동차');
INSERT INTO EXP_GOODS_ASIA
VALUES ('일본',2,'자동차부품');
INSERT INTO EXP_GOODS_ASIA
VALUES ('일본',3,'전자집적회로');
INSERT INTO EXP_GOODS_ASIA
VALUES ('일본',4,'선박');
INSERT INTO EXP_GOODS_ASIA
VALUES ('일본',5,'반도체 웨이퍼');
INSERT INTO EXP_GOODS_ASIA
VALUES ('일본',6,'화물차');
INSERT INTO EXP_GOODS_ASIA
VALUES ('일본',7,'원유제외 석유류');
INSERT INTO EXP_GOODS_ASIA
VALUES ('일본',8,'건설기계');
INSERT INTO EXP_GOODS_ASIA
VALUES ('일본',9,'다이오드,트렌지스터');
INSERT INTO EXP_GOODS_ASIA
VALUES ('일본',10,'기계류');

CREATE TABLE EXP_GOODS_AISA(
        COUNTRY     VARCHAR(20),
        SEQ         NUMBER,
        GOODS       VARCHAR2(100));
        
ALTER TABLE EXP_GOODS_AISA
RENAME TO EXP_GOODS_ASIA;

COMMIT;

SELECT  GOODS
FROM    EXP_GOODS_ASIA
WHERE   COUNTRY = '대한민국'
UNION ALL
SELECT  GOODS 
FROM    EXP_GOODS_ASIA 
WHERE   COUNTRY = '일본';

SELECT  MEM_ID 회원번호,
        MEM_NAME 회원명,
        MEM_ADD1||' '||MEM_ADD2 회원주소
FROM    MEMBER
WHERE   SUBSTR(MEM_REGNO2,1,1) IN ('2','4')
INTERSECT
SELECT  MEM_ID 회원번호,
        MEM_NAME 회원명,
        MEM_ADD1||' '||MEM_ADD2 회원주소
FROM    MEMBER
WHERE   MEM_MILEAGE>4000
ORDER BY 1;


SELECT  GOODS
FROM    EXP_GOODS_ASIA
WHERE   COUNTRY = '대한민국'
INTERSECT
SELECT  GOODS
FROM    EXP_GOODS_ASIA
WHERE   COUNTRY = '일본';

SELECT  PROD_ID 상품코드, 
        PROD_NAME 상품명, 
        PROD_COST 단가
FROM    CART, PROD
WHERE   CART_PROD = PROD_ID AND
        CART_NO LIKE '200504%'
INTERSECT
SELECT  PROD_ID 상품코드, 
        PROD_NAME 상품명, 
        PROD_COST 단가
FROM    CART, PROD
WHERE   CART_PROD = PROD_ID AND
        CART_NO LIKE '200506%'
        
        
2005년 5월 매입된 상품 중 매출이 발생된 상품을 조회하시오
Alias 는 상품코드, 상품명, 매입처명

SELECT  a.PROD_ID 상품코드, 
        a.PROD_NAME 상품명, 
        b.BUYER_NAME 매입처명
FROM    PROD a, BUYER b, BUYPROD c 
WHERE   BUY_PROD = PROD_ID AND
        PROD_BUYER = BUYER_ID AND
        BUY_DATE BETWEEN '20050501' AND '20050531'
INTERSECT
SELECT  a.PROD_ID 상품코드, 
        a.PROD_NAME 상품명, 
        c.BUYER_NAME 매입처명
FROM    PROD a, CART b, BUYER c
WHERE   PROD_BUYER = BUYER_ID AND
        CART_PROD = PROD_ID AND
        CART_NO LIKE '200505%'
ORDER BY 1;

SELECT  goods
FROM    exp_goods_asia
WHERE   COUNTRY = '대한민국'
MINUS
SELECT  goods
FROM    exp_goods_asia
WHERE   COUNTRY = '일본';



                                               
    

(SELECT  A.BUY_PROD 상품코드, 
        B.PROD_NAME 상품명, 
        A.BUY_COST 매입단가
FROM    BUYPROD A, PROD B
WHERE   B.PROD_ID = A.BUY_PROD
        AND A.BUY_DATE BETWEEN '20050501' AND '20050531'
MINUS
SELECT  A.BUY_PROD 상품코드, 
        B.PROD_NAME 상품명, 
        A.BUY_COST 매입단가
FROM    BUYPROD A, PROD B
WHERE   B.PROD_ID = A.BUY_PROD
        AND A.BUY_DATE BETWEEN '20050601' AND '20050630')
        
MINUS        
(SELECT
    a.buy_prod 상품코드,
    B.prod_name 상품명,
    A.buy_cost 매입단가
FROM
    buyprod A,
    prod B
WHERE
    B.prod_id = A.buy_prod
    and buy_date between '20050501' and '20050531'
    AND BUY_PROD NOT IN (SELECT BUY_PROD
                         FROM   buyprod
                         WHERE  buy_date between '20050601' and '20050630')) ;


2005년 5월 일자별 상품의 매입/매출현황을 조회하시오
Alias는 일자, 상품명, 수량, 구분
'구분'에는 매입 또는 매출을 출력하며, 집합연산자를 사용하시오

SELECT  TO_DATE(SUBSTR(A.CART_NO,1,8)) 일자, 
        B.PROD_NAME 상품명, 
        A.CART_QTY 수량, 
        '매출' 구분
FROM    CART A,PROD B
WHERE   A.CART_PROD = B.PROD_ID
        AND A.CART_NO LIKE '200505%'
UNION  ALL
SELECT  A.BUY_DATE 일자, 
        B.PROD_NAME 상품명, 
        A.BUY_QTY 수량, 
        '매입' 구분
FROM    BUYPROD A, PROD B
WHERE   A.BUY_PROD = B.PROD_ID
        AND BUY_DATE BETWEEN '20050501' AND '20050531'
ORDER BY 1;


SELECT
    A.EMPLOYEE_ID AS 사원번호, 
    A.EMP_NAME AS 사원명, 
    A.DEPARTMENT_ID AS 부서코드, 
    A.SALARY AS 급여,
    B.RAS AS 부서평균급여
FROM
    HR.EMPLOYEES A,
    (SELECT
        DEPARTMENT_ID AS DID,
        ROUND(AVG(SALARY)) AS RAS
    FROM
        HR.EMPLOYEES
    GROUP BY DEPARTMENT_ID) B
WHERE
    A.DEPARTMENT_ID = B.DID AND
    A.SALARY > B.RAS
ORDER BY 1
;
