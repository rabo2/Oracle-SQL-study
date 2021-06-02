2021-0503-01



SELECT COUNT(*)
FROM   PROD
WHERE  PROD_PRICE > (SELECT AVG(PROD_PRICE)
                      FROM  PROD);

SELECT  COUNT(*)
FROM    PROD A,(SELECT  AVG(PROD_PRICE) AS APRICE
                  FROM  PROD) B
WHERE A.PROD_PRICE > B.APRICE;


SELECT
    PROD_ID ��ǰ�ڵ�,
    PROD_NAME ��ǰ��,
    PROD_LGU �з��ڵ�,
    PROD_COST ���԰���
FROM
    PROD
WHERE 
    PROD_LGU =SOME (SELECT DISTINCT PROD_LGU
                     FROM  PROD
                    WHERE  PROD_LGU LIKE 'P3%')
;

SELECT
    PROD_ID ��ǰ�ڵ�,
    PROD_NAME ��ǰ��,
    PROD_LGU �з��ڵ�,
    PROD_COST ���԰���
FROM
    PROD
WHERE 
    EXISTS (SELECT 1
              FROM LPROD
             WHERE LPROD_GU LIKE 'P3%'
                   AND PROD_LGU = LPROD_GU)
;


������̺��� �����ȣ, �����ڵ尡 �����������̺�(JOB_HISTORY)��
�����ȣ, �����ڵ�� ������ ��������� ����Ͻÿ�.
Alias�� �����ȣ, �����, �μ���, �Ի���

SELECT
    A.EMPLOYEE_ID �����ȣ, 
    A.EMP_NAME �����, 
    B.DEPARTMENT_NAME �μ���, 
    A.HIRE_DATE �Ի���
FROM
    HR.EMPLOYEES A, HR.DEPARTMENTS B
WHERE
    (A.EMPLOYEE_ID, A.JOB_ID) IN (SELECT EMPLOYEE_ID, JOB_ID
                                    FROM HR.JOB_HISTORY)
    AND A.DEPARTMENT_ID = B.DEPARTMENT_ID    
    
    
SELECT
    A.EMPLOYEE_ID �����ȣ, 
    A.EMP_NAME �����, 
    B.DEPARTMENT_NAME �μ���, 
    A.HIRE_DATE �Ի���
FROM
    HR.EMPLOYEES A, HR.DEPARTMENTS B
WHERE
    (A.EMPLOYEE_ID, A.JOB_ID) EXISTS (SELECT EMPLOYEE_ID, JOB_ID
                                        FROM HR.JOB_HISTORY C
                                       WHERE A.EMPLOYEE_ID = C.EMPLOYEE_ID)
    AND A.DEPARTMENT_ID = B.DEPARTMENT_ID  
    
    
    
    
**���������̺� �Ʒ� ���Ǵ�� �����Ͻÿ�

1) ���̺�� : REMAIN
----------------------------------------------------
�÷���         ������Ÿ��         N.N       PK/FK
----------------------------------------------------
REMAIN_YEAR     CHAR(4)         N.N         PK
PROD_ID         VARCHAR2(10)    N.N         PK&FK
REMAIN_J_00     NUMBER(5)       DEFAULT 0
REMAIN_I        NUMBER(5)       
REMAIN_O        NUMBER(5)       
REMAIN_J_99     NUMBER(5)  
REMAIN_DATE     DATE
------------------------------------------------------

CREATE TABLE REMAIN(
    REMAIN_YEAR CHAR(4),
    PROD_ID     VARCHAR2(10),
    REMAIN_J_00 NUMBER(5) DEFAULT 0,
    REMAIN_I    NUMBER(5),
    REMAIN_O    NUMBER(5),
    REMAIN_J_99 NUMBER(5),
    REMAIN_DATE DATE,
CONSTRAINT PK_REMAIN PRIMARY KEY (REMAIN_YEAR, PROD_ID),
CONSTRAINT FK_REMAIN_PROD FOREIGN KEY(PROD_ID)
REFERENCES PROD(PROD_ID));

INSERT INTO remain (remain_year,PROD_ID,remain_j_00,remain_I,
                    remain_O,REMAIN_J_99,remain_DATE) 
    SELECT 
        '2005',
        PROD_ID,
        PROD_PROPERSTOCK,
        0,
        0,
        PROD_PROPERSTOCK,
        TO_DATE('20050103')
    FROM    
        PROD
;
