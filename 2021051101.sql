2021-05-1101)

declare
    cursor aaa
    is
    select employee_id, commission_pct
      from hr.employees
     where commission_pct is not null;
    --�͸� Ŀ���� ��µǰ� �ٷ� ������.
begin

end;


ACCEPT P_CITY PROMPT '�����õ� �Է�(�α���) :'
DECLARE
    V_MEM_ID MEMBER.MEM_ID%TYPE;
    -- V_MEM_ID�� ������ Ÿ���� MEMBER.MEM_ID�� ������ Ÿ��
    V_NAME MEMBER.MEM_NAME%TYPE;
    V_ADDR VARCHAR2(100);
    V_JOB MEMBER.MEM_JOB%TYPE;
    V_CITY VARCHAR2(20):='&P_CITY'||'%';
    --& : P_CITY�ȿ� �ִ� ����
    CURSOR CUR_MEM01
    IS
      SELECT MEM_ID,MEM_NAME,MEM_ADD1||' '||MEM_ADD2,MEM_JOB
        FROM MEMBER
       WHERE MEM_ADD1 LIKE V_CITY;
BEGIN
    OPEN CUR_MEM01;
    --Ŀ���� OPEN�ؾ��� ��밡��
    --Ŀ���� �� 1���� �д� ���� FETCH
    --Ŀ���� �ݴ� ���� CLOSE
    LOOP
    --�ݺ�Ƚ���� �� �� ���ǹݺ��� ����
       FETCH CUR_MEM01 INTO V_MEM_ID,V_NAME,V_ADDR,V_JOB;
       --INTO�� �Ҵ�
       EXIT WHEN CUR_MEM01%NOTFOUND;
       DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||V_MEM_ID);
       DBMS_OUTPUT.PUT_LINE('ȸ���̸� : '||V_NAME);
       DBMS_OUTPUT.PUT_LINE('�ּ� : '||V_ADDR);
       DBMS_OUTPUT.PUT_LINE('���� : '||V_JOB);
       DBMS_OUTPUT.PUT_LINE('--------------------------------------');
       DBMS_OUTPUT.PUT_LINE('ȸ�� �� : '||CUR_MEM01%ROWCOUNT);
       --DBMS_OUTPUT.PUT.LINE : ��� ��ɾ�
END LOOP;
    EXCEPTION WHEN OTHERS THEN
    --OTHERS : ���ܹ߻��� ����ó���� ����
        DBMS_OUTPUT.PUT_LINE('�ڷᰡ �����ϴ�.'||SQLERRM);
        --SQLERRM : SQL���� �޼��� 
    CLOSE CUR_MEM01;
END;
-- ��������� �������̱� ������ Ŀ���� ����ؾ��Ѵ�.

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
    --FOR : CURSOR OPEN, FETCH, CLOSE�� �ѹ��� ����
    LOOP
     SELECT A.EMP_NAME,B.DEPARTMENT_NAME,REC1.COMMISSION_PCT,A.SALARY
       INTO V_NAME,V_DEPT_NAME,V_PCT,V_SAL
       FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
      WHERE EMPLOYEE_ID =REC1.EMPLOYEE_ID
        AND A.DEPARTMENT_ID = b.department_id;
    
    V_BONUS:=V_SAL*REC1.COMMISSION_PCT*0.5;
    V_TAX:=V_BONUS*0.1;
    
    DBMS_OUTPUT.PUT_LINE('����� : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : '||V_DEPT_NAME);
    DBMS_OUTPUT.PUT_LINE('���������ڵ� : '||REC1.COMMISSION_PCT);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : '||V_BONUS);
    DBMS_OUTPUT.PUT_LINE('���� : '||V_TAX);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');    
    END LOOP;
END;

DECLARE
    V_SCORE NUMBER:=82;
    V_RES   VARCHAR2(100);
BEGIN
    CASE WHEN TRUNC(V_SCORE/10) = 10 OR TRUNC(V_SCORE/10) = 9 
                                   THEN V_RES:='A�����Դϴ�.';
         WHEN TRUNC(V_SCORE/10)=8  THEN V_RES:='B�����Դϴ�.';
         WHEN TRUNC(V_SCORE/10)=7  THEN V_RES:='C�����Դϴ�.';
         WHEN TRUNC(V_SCORE/10)=6  THEN V_RES:='D�����Դϴ�.';
         ELSE V_RES:='F�����Դϴ�.';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('���� '||V_SCORE||'�� '||V_RES);
END;






























