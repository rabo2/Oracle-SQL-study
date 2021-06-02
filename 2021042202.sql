2021-0422-02]

SELECT  EMPLOYEE_ID,
        CAST(JOB_ID AS CHAR(30)) AS �����ڵ�, -- VARCHAR2(10) => CHAR(30)
        CAST(SALARY AS VARCHAR(10)) AS �޿�, -- NUMBER(8,2) => VARCHAR2(10)
                                            -- ���ڴ� ��������, ���ڴ� ������ ����
        SALARY*0.1 AS ���ʽ�
  FROM  HR.EMPLOYEES
 WHERE  SALARY >= 10000 -- CAST�� �� �ڸ������� CASTING�Ǳ� ������  '10000'�� �ƴ�
                        -- 10000�� ����.
;


---------------------------------------------------------------------------------------
�����������ڿ�          ����                  ��뿹
---------------------------------------------------------------------------------------
YYYY,YYY,YY,Y       �⵵              TO_CHAR(SYSDATE,'YYYY')
MONTH, MON          ��                TO_CHAR(SYSDATE,'MONTH')-> 2��
MM,RM               ��                TO_CHAR(SYSDATE,'MM')   -> 02
D,DD,DDD            ��                TO_CHAR(SYSDATE,'D')    -> ��������(1-7)
                                      TO_CHAR(SYSDATE,'DD')   -> ��������(1-30|31|28|29)
                                      TO_CHAR(SYSDATE,'DDD')  -> ���� ����(1-365)
DAY                 �������� ���Ϸ�     TO_CHAR(SYSDATE,'DAY')  -> �ݿ���
DL                  �������� ���ϱ���   TO_CHAR(SYSDATE,'DL')   -> 2021�� 4�� 23�� �ݿ���
AM,PM, A.M, P.M     ����/����          TO_CHAR(SYSDATE,'AM')   -> ����
CC                  ����              
BC, AD              ����
HH,HH12,HH24        �ð�--�Ϸ縦 12,24 �ð� �������� ǥ��
MI                  ��
SS,SSSSS            �� --SSSSS�� 00�ú��� ���� �ð������� ��
"������������ڿ�"      -- ""�� �÷��� ������ ������ ���� ��,


SELECT
    TO_CHAR(TO_DATE('20001231'),'BC YYYY-MM-DD AM HH24:MI:SS') 
FROM
    DUAL;
    
SELECT
    TO_CHAR(SYSDATE,'dl AM HH24:MI:SSSSS') 
FROM
    DUAL;
    
SELECT
    TO_CHAR(SYSDATE,'BC YYYY "SUS" RM "��" DD"��" AM HH24:MI:SS')
FROM
    DUAL;
    
    
--------------------------------------------------------------------------------------
�����������ڿ�         ����                        ��뿹
--------------------------------------------------------------------------------------
9, 0            9�� ��ȿ�� 0�� ��������, 0��      TO_CHAR(123,'99999')  -> BB123(B�� ����)
                ��ȿ�� 0�� '0'���� ���          TO_CHAR(123,'00000')  -> 00123
.(�Ҽ���)                                       TO_CHAR(123,'999.99') -> 123.00
,(COMMA)                                       TO_CHAR(123456,'9,999,999') -> BB123,4
PR              ������ '< >'�ȿ� ǥ��            TO_CHAR(-123,'999PR') -> <123>
S               ��ȣ(���:+, ����:-) ǥ��
$,L             ȭ���ȣ ǥ��                    TO_CHAR(123,'L999.99') ->(ȭ���ȣ)123.00
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
    TO_NUMBER('-12345','99999PR') -- ,�� ���� �����ڸ� ����� �� ���� ������ �Ұ���
FROM                              -- ���ڰ� ���� ������������ ���ڿ��� ����Ҽ� ����
    DUAL;                         -- ���ڷ� �����Ǿ��� �� �־�� �Ѵ�.
    


SELECT
    TO_NUMBER('110','99999')/7,
    TO_NUMBER('-12345')*100
FROM
    DUAL;
    
1). 2005�� 6�� 13�Ͽ� ������ ��ٱ�����ȣ �� ���� ū�� +1
SELECT 
   MAX(TO_NUMBER(SUBSTR(CART_NO,9)))+1
FROM
    CART
WHERE
    SUBSTR(CART_NO,1,8) = '20050613';
    
2). 1���� ���� ��(����)�� 5�ڸ� ���ڿ��� ��ȯ�Ͽ� ��¥�����ڿ��� ����
SELECT 
    '20050613'||TRIM(TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO,9)))+1,'00000'))
FROM
    CART
WHERE
    SUBSTR(CART_NO,1,8) = '20050613';
    
SELECT 
    TO_DATE('210706', 'YYYYMMDD'), -- ���ڿ��� �������� ���ڿ��� ��ġ ���� ����
    TO_DATE('20210229','YYYYMMDD'), -- ��¥�� ������ �ʰ�
    TO_DATE('210706')               -- ������ ���� �����ϳ� �����ϸ� NLS ��¥ ���� 
                                    --�� �����Ѵ�. �⺻������ ���
    TO_DATE(20210601,'YYYY/MM/DD')  -- ��ȯ�Ϸ��� �������� Ÿ���� ���ڿ��� �ƴ� �������̴�.
FROM
    DUAL;

SELECT
    DISTINCT TO_DATE(SUBSTR(CART_NO,1,8),'YYYY-MM-DD') -- �����ڰ� '-'�� ���ϱ�� ������
FROM                                                   -- �⺻������ ��µǾ�����.
    CART
WHERE
    CART_NO LIKE '200504%'
    ORDER BY 1;