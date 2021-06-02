2021-05-1101)

declare
    cursor aaa
    is
    select employee_id, commission_pct
      from hr.employees
     where commission_pct is not null;
    --익명 커서는 출력되고 바로 닫힌다.
begin

end;


ACCEPT P_CITY PROMPT '광역시도 입력(두글자) :'
DECLARE
    V_MEM_ID MEMBER.MEM_ID%TYPE;
    -- V_MEM_ID의 데이터 타입은 MEMBER.MEM_ID의 데이터 타입
    V_NAME MEMBER.MEM_NAME%TYPE;
    V_ADDR VARCHAR2(100);
    V_JOB MEMBER.MEM_JOB%TYPE;
    V_CITY VARCHAR2(20):='&P_CITY'||'%';
    --& : P_CITY안에 있는 내용
    CURSOR CUR_MEM01
    IS
      SELECT MEM_ID,MEM_NAME,MEM_ADD1||' '||MEM_ADD2,MEM_JOB
        FROM MEMBER
       WHERE MEM_ADD1 LIKE V_CITY;
BEGIN
    OPEN CUR_MEM01;
    --커서는 OPEN해야지 사용가능
    --커서의 행 1개를 읽는 것을 FETCH
    --커서를 닫는 것을 CLOSE
    LOOP
    --반복횟수를 모를 때 조건반복을 실행
       FETCH CUR_MEM01 INTO V_MEM_ID,V_NAME,V_ADDR,V_JOB;
       --INTO는 할당
       EXIT WHEN CUR_MEM01%NOTFOUND;
       DBMS_OUTPUT.PUT_LINE('회원번호 : '||V_MEM_ID);
       DBMS_OUTPUT.PUT_LINE('회원이름 : '||V_NAME);
       DBMS_OUTPUT.PUT_LINE('주소 : '||V_ADDR);
       DBMS_OUTPUT.PUT_LINE('직업 : '||V_JOB);
       DBMS_OUTPUT.PUT_LINE('--------------------------------------');
       DBMS_OUTPUT.PUT_LINE('회원 수 : '||CUR_MEM01%ROWCOUNT);
       --DBMS_OUTPUT.PUT.LINE : 출력 명령어
END LOOP;
    EXCEPTION WHEN OTHERS THEN
    --OTHERS : 예외발생시 예외처리문 실행
        DBMS_OUTPUT.PUT_LINE('자료가 없습니다.'||SQLERRM);
        --SQLERRM : SQL에러 메세지 
    CLOSE CUR_MEM01;
END;
-- 결과집합이 여러개이기 때문에 커서를 사용해야한다.

DECLARE
    V_BONUS NUMBER;
    V_TAX   NUMBER;
    V_NAME  HR.EMPLOYEES.EMP_NAME%TYPE;
    V_DEPT_NAME HR.DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    V_PCT   HR.EMPLOYEES.COMMISSION_PCT%TYPE;
    V_SAL   HR.EMPLOYEES.SALARY%TYPE;
    CURSOR CUR_EMP01
    IS
      SELECT EMPLOYEE_ID,COMMISSION_PCT
        FROM HR.EMPLOYEES
       WHERE COMMISSION_PCT IS NOT NULL;
BEGIN
    FOR REC1 IN CUR_EMP01 
    --FOR : CURSOR OPEN, FETCH, CLOSE를 한번에 적용
    LOOP
     SELECT A.EMP_NAME,B.DEPARTMENT_NAME,REC1.COMMISSION_PCT,A.SALARY
       INTO V_NAME,V_DEPT_NAME,V_PCT,V_SAL
       FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
      WHERE EMPLOYEE_ID =REC1.EMPLOYEE_ID
        AND A.DEPARTMENT_ID = b.department_id;
    
    V_BONUS:=V_SAL*REC1.COMMISSION_PCT*0.5;
    V_TAX:=V_BONUS*0.1;
    
    DBMS_OUTPUT.PUT_LINE('사원명 : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : '||V_DEPT_NAME);
    DBMS_OUTPUT.PUT_LINE('영업실적코드 : '||REC1.COMMISSION_PCT);
    DBMS_OUTPUT.PUT_LINE('보너스 : '||V_BONUS);
    DBMS_OUTPUT.PUT_LINE('세금 : '||V_TAX);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');    
    END LOOP;
END;

DECLARE
    V_SCORE NUMBER:=82;
    V_RES   VARCHAR2(100);
BEGIN
    CASE WHEN TRUNC(V_SCORE/10) = 10 OR TRUNC(V_SCORE/10) = 9 
                                   THEN V_RES:='A학점입니다.';
         WHEN TRUNC(V_SCORE/10)=8  THEN V_RES:='B학점입니다.';
         WHEN TRUNC(V_SCORE/10)=7  THEN V_RES:='C학점입니다.';
         WHEN TRUNC(V_SCORE/10)=6  THEN V_RES:='D학점입니다.';
         ELSE V_RES:='F학점입니다.';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('점수 '||V_SCORE||'는 '||V_RES);
END;






























