2021-0512-01)

DECLARE
    V_SUM NUMBER:=0;  --저축금액
    V_DAYS NUMBER:=0; --저축기간
    V_AMT NUMBER:=0;  --저축할 액수
BEGIN
    V_AMT:=100;
    V_DAYS:=1;
    LOOP
        V_SUM:=V_SUM+V_AMT;
        EXIT WHEN V_SUM >= 1000000;
        V_DAYS:=V_DAYS+1;
        V_AMT:=V_AMT*2;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('저축한 일수 :'||V_DAYS);
    DBMS_OUTPUT.PUT_LINE('저축금액 :'||V_SUM);
END;

select  A.CART_MEMBER 고객번호, 
        SUM(A.CART_QTY*B.PROD_PRICE) 구매금액합계
from    CART A, PROD B
where   A.CART_PROD = B.PROD_ID
  AND   CART_NO LIKE '200505%'
GROUP BY A.CART_MEMBER
HAVING SUM(A.CART_QTY*B.PROD_PRICE) >= 5000000;


DECLARE
    V_MEM_ID MEMBER.MEM_ID%TYPE;
    V_AMT    NUMBER:=0;
    V_NAME   MEMBER.MEM_NAME%TYPE;
    CURSOR CUR_CART02
    IS
    select  A.CART_MEMBER, 
            SUM(A.CART_QTY*B.PROD_PRICE)
      from  CART A, PROD B
     where  A.CART_PROD = B.PROD_ID
      AND   CART_NO LIKE '200505%'
    GROUP BY A.CART_MEMBER
    HAVING SUM(A.CART_QTY*B.PROD_PRICE) >= 5000000;
BEGIN
    OPEN CUR_CART02;
    FETCH CUR_CART02 INTO V_MEM_ID,V_AMT;
    WHILE  EXIT WHEN CUR_CART02%NOTFOUND LOOP
      UPDATE MEMBER
         SET MEM_MILEAGE=MEM_MILEAGE + ROUND(V_AMT*0.001)
       WHERE MEM_ID = V_MEM_ID;
   
    SELECT MEM_NAME INTO V_NAME
      FROM MEMBER
     WHERE MEM_ID = V_MEM_ID;
     
     DBMS_OUTPUT.PUT_LINE(V_MEM_ID||'  '||V_NAME||'  '||
                         TO_CHAR(V_AMT,'99,999,999'));
     FETCH CUR_CART02 INTO V_MEM_ID,V_AMT;
    END LOOP;
    CLOSE CUR_CART02;
END;



DECLARE
    VC_NUM NUMBER:=0;
    VP_NUM NUMBER:=1;
    VPP_NUM NUMBER:=1;
    V_RES VARCHAR2(100);
BEGIN
    V_RES:=TO_CHAR(VPP_NUM)||','||TO_CHAR(VP_NUM);
    WHILE VC_NUM <= 50 LOOP
        VC_NUM:=VP_NUM+VPP_NUM;
        IF VC_NUM >=50 THEN EXIT;
        ELSE
         VP_NUM:=VPP_NUM;
         VPP_NUM:=VC_NUM;
         V_RES:=V_RES||','||TO_CHAR(VC_NUM);
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(V_RES);
END;

DECLARE
    V_RES NUMBER:=0;
BEGIN
    FOR I IN 1..9 LOOP
      V_RES:=3*I;
      DBMS_OUTPUT.PUT_LINE(3||'*'||I||'='||V_RES);
    END LOOP;
END;




SELECT  EMP_NAME
  FROM  HR.employees
 WHERE  department_id = 80;
 
ACCEPT P_DCODE PROMT '부서코드(10~110) :'
DECLARE
    V_CNT NUMBER:=0;
    CURSOR CUR_EMP02(P_DID departments.department_id%TYPE)
    IS
      SELECT  EMP_NAME
        FROM  HR.employees
       WHERE  department_id = P_DID;
BEGIN
    FOR REC_EMP IN CUR_EMP02(TO_NUMBER('&P_DCODE'))
    LOOP
     DBMS_OUTPUT.PUT_LINE('사원명 :'||REC_EMP.EMP_NAME);
     V_CNT:=CUR_EMP02%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('사원수 : '||V_CNT);
END;



ACCEPT P_DCODE PROMT '부서코드(10~110) :'
DECLARE
    V_CNT NUMBER:=0;
BEGIN
    FOR REC_EMP IN (SELECT  EMP_NAME
                      FROM  HR.employees
                     WHERE  department_id = TO_NUMBER('&P_DCODE'))
     LOOP
         DBMS_OUTPUT.PUT_LINE('사원명 :'||REC_EMP.EMP_NAME);
         V_CNT:=V_CNT+1;
    END LOOP;
        DBMS_OUTPUT.PUT_LINE('=======================');
        DBMS_OUTPUT.PUT_LINE('사원수 : '||V_CNT||'명');
END;

















