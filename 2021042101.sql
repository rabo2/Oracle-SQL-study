2021-0421-01

SELECT  ABS(-10.77), ABS(29), ABS(0) FROM DUAL;
SELECT  SIGN(-2000), SIGN(0.0006) FROM DUAL;
SELECT  POWER(2,10), POWER(10,7) FROM DUAL;
SELECT  SQRT(16), SQRT(9.9) FROM DUAL;


SELECT CEIL(10.2), CEIL(-10.2) FROM DUAL;
SELECT FLOOR(10.2), FLOOR(-10.2) FROM DUAL;


SELECT  EMPLOYEE_ID AS �����ȣ, 
        EMP_NAME AS �����, 
        SALARY - ROUND(SALARY/13,1) AS ����, 
        ROUND((SALARY - ROUND(SALARY/13,1))/12,1) AS �����޾�
  FROM  HR.EMPLOYEES
;
 
 
SELECT  EMPLOYEE_ID AS �����ȣ, 
        EMP_NAME AS �����, 
        SALARY AS �޿�, 
        TRUNC((SALARY*0.03),-1) AS ���ټ�, 
        ROUND((SALARY-(SALARY*0.03)),-1) AS ���޾�
  FROM  EMPLOYEES
;

MOD(10,3) = 10 -3*FLOOR(10/3)
          = 10 -3*FLOOR(3.333..)
          = 10 -3*3 => 1
          
REMAINDER(10,3) = 10 -3*ROUND(10/3)
                = 10 -3*ROUND(0.333...)
                = 10 -3*3 => 1
                
MOD(18,7) = 18 -7*FLOOR(18/7)
          = 18 -7*FLOOR(2.57..)
          = 18 -7*2  => 4
          
REMAINDER(18,7) = 18-7*ROUND(18/7)
                = 18 -7*ROUND(18/7)
                = 18 -7*3 => -3
                
                
ACCEPT P_YEAR PROMPT '�⵵ �Է�(4�ڸ�) : ' --ACCEPT : ����� �Է°� 
DECLARE                                     --P_(parameter , �Ű�����
  V_YEAR NUMBER(4) :='&P_YEAR'; -- ':==' �ʱ�ȭ(==) ,&(����)
  V_RES VARCHAR2(50);
BEGIN --BEGIN ���Ŀ� ������ ����
  IF(MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR --
    (MOD(V_YEAR,400)=0) THEN  -- THEN..END IF;(= {} ����κ�)
                              -- & �ݺ�����  THEN...END LOOP;
     V_RES:=V_YEAR||'�� �����Դϴ�.';
ELSE 
     V_RES:=V_YEAR||'�� ����Դϴ�.';
END IF;

-- ���� -> DBMS ���
DBMS_OUTPUT.PUT_LINE(V_RES);
END;


SELECT  MEM_ID AS ȸ����ȣ, 
        MEM_NAME AS ȸ����, 
        MEM_MILEAGE AS ���ϸ���, 
  --    5-WIDTH_BUCKET(MEM_MILEAGE,1000,9000,4)||'���'
        WIDTH_BUCKET(MEM_MILEAGE,9000,500,4)||'���'        
        AS ���
  FROM  MEMBER
;


SELECT  GREATEST('ȫ�浿','������','ȫ���'), 
        --���ĺ� Ȥ�� �ѱ��� ������ �ڿ� ���� ���� ū ������ ���
        LEAST(70,5,24) FROM DUAL;
 
 
SELECT  EMPLOYEE_ID AS �����ȣ, 
        EMP_NAME AS �����, 
        SALARY AS �޿�, 
        GREATEST(SALARY, 2500) AS �����޿� -- SALARY �� 2500�� ���ؼ� ���� ��ȯ
  FROM  HR.EMPLOYEES
ORDER BY 3
 ;
 