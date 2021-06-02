2021-0422-02]

SELECT  EMPLOYEE_ID,
        CAST(JOB_ID AS CHAR(30)) AS 직무코드, -- VARCHAR2(10) => CHAR(30)
        CAST(SALARY AS VARCHAR(10)) AS 급여, -- NUMBER(8,2) => VARCHAR2(10)
                                            -- 숫자는 왼쪽정렬, 문자는 오른쪽 정렬
        SALARY*0.1 AS 보너스
  FROM  HR.EMPLOYEES
 WHERE  SALARY >= 10000 -- CAST를 쓴 자리에서만 CASTING되기 때문에  '10000'이 아닌
                        -- 10000을 쓴다.
;


---------------------------------------------------------------------------------------
형식지정문자열          설명                  사용예
---------------------------------------------------------------------------------------
YYYY,YYY,YY,Y       년도              TO_CHAR(SYSDATE,'YYYY')
MONTH, MON          월                TO_CHAR(SYSDATE,'MONTH')-> 2월
MM,RM               월                TO_CHAR(SYSDATE,'MM')   -> 02
D,DD,DDD            일                TO_CHAR(SYSDATE,'D')    -> 주중일자(1-7)
                                      TO_CHAR(SYSDATE,'DD')   -> 월중일자(1-30|31|28|29)
                                      TO_CHAR(SYSDATE,'DDD')  -> 년중 일자(1-365)
DAY                 주중일을 요일로     TO_CHAR(SYSDATE,'DAY')  -> 금요일
DL                  현재일을 요일까지   TO_CHAR(SYSDATE,'DL')   -> 2021년 4월 23일 금요일
AM,PM, A.M, P.M     오전/오후          TO_CHAR(SYSDATE,'AM')   -> 오후
CC                  세기              
BC, AD              서기
HH,HH12,HH24        시간--하루를 12,24 시간 기준으로 표기
MI                  분
SS,SSSSS            초 --SSSSS는 00시부터 현재 시간까지의 초
"사용자지정문자열"      -- ""은 컬럼의 지정명에 공백을 넣을 때,


SELECT
    TO_CHAR(TO_DATE('20001231'),'BC YYYY-MM-DD AM HH24:MI:SS') 
FROM
    DUAL;
    
SELECT
    TO_CHAR(SYSDATE,'dl AM HH24:MI:SSSSS') 
FROM
    DUAL;
    
SELECT
    TO_CHAR(SYSDATE,'BC YYYY "SUS" RM "월" DD"일" AM HH24:MI:SS')
FROM
    DUAL;
    
    
--------------------------------------------------------------------------------------
형식지정문자열         설명                        사용예
--------------------------------------------------------------------------------------
9, 0            9는 무효의 0을 공백으로, 0은      TO_CHAR(123,'99999')  -> BB123(B는 공백)
                무효의 0을 '0'으로 출력          TO_CHAR(123,'00000')  -> 00123
.(소숫점)                                       TO_CHAR(123,'999.99') -> 123.00
,(COMMA)                                       TO_CHAR(123456,'9,999,999') -> BB123,4
PR              음수를 '< >'안에 표현            TO_CHAR(-123,'999PR') -> <123>
S               부호(양수:+, 음수:-) 표시
$,L             화폐기호 표시                    TO_CHAR(123,'L999.99') ->(화폐기호)123.00
---------------------------------------------------------------------------------------


SELECT
    TO_CHAR(PROD_PRICE,'L9,999,999')
FROM
    PROD
WHERE
    PROD_ID LIKE 'P101%'
;

SELECT
    TO_CHAR(PROD_COST - PROD_PRICE,'L9,999,999.00PR'),
    TO_CHAR(PROD_COST - PROD_PRICE,'L0,000,000.00PR'),
    TO_CHAR(PROD_PROPERSTOCK)
FROM
    PROD
WHERE
    PROD_ID LIKE 'P101%'
;

COMMIT;

SELECT
    TO_NUMBER('-12345','99999PR') -- ,가 들어가면 연산자를 사용할 수 없기 때문에 불가능
FROM                              -- 문자가 들어가는 숫자형식지정 문자열은 사용할수 없음
    DUAL;                         -- 숫자로 변형되어질 수 있어야 한다.
    


SELECT
    TO_NUMBER('110','99999')/7,
    TO_NUMBER('-12345')*100
FROM
    DUAL;
    
1). 2005년 6월 13일에 생성된 장바구니전호 중 가장 큰값 +1
SELECT 
   MAX(TO_NUMBER(SUBSTR(CART_NO,9)))+1
FROM
    CART
WHERE
    SUBSTR(CART_NO,1,8) = '20050613';
    
2). 1에서 구한 값(숫자)을 5자리 문자열로 변환하여 날짜형문자열과 결합
SELECT 
    '20050613'||TRIM(TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO,9)))+1,'00000'))
FROM
    CART
WHERE
    SUBSTR(CART_NO,1,8) = '20050613';
    
SELECT 
    TO_DATE('210706', 'YYYYMMDD'), -- 문자열이 형식지정 문자열과 일치 하지 않음
    TO_DATE('20210229','YYYYMMDD'), -- 날짜가 범위를 초과
    TO_DATE('210706')               -- 형식은 생략 가능하나 생략하면 NLS 날짜 형식 
                                    --을 참고한다. 기본형식을 벗어남
    TO_DATE(20210601,'YYYY/MM/DD')  -- 변환하려는 데이터의 타입이 문자열이 아닌 숫자형이다.
FROM
    DUAL;

SELECT
    DISTINCT TO_DATE(SUBSTR(CART_NO,1,8),'YYYY-MM-DD') -- 구분자가 '-'로 변하기는 하지만
FROM                                                   -- 기본형으로 출력되어진다.
    CART
WHERE
    CART_NO LIKE '200504%'
    ORDER BY 1;