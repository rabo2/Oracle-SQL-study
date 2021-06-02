2021 - 04 - 30 - 01

2005�� �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�.
Alias �� �ŷ�ó�ڵ�, �ŷ�ó��, �������, �ݾ�

SELECT
    B.PROD_BUYER AS �ŷ�ó�ڵ�, 
    A.BUYER_NAME AS �ŷ�ó��, 
    SUM(C.CART_QTY) AS �������, 
    SUM(C.CART_QTY*B.PROD_PRICE) AS �ݾ�
from
    BUYER A, PROD B, CART C
WHERE
    C.CART_NO LIKE '2005%' AND
    A.BUYER_ID = B.PROD_BUYER AND
    C.CART_PROD = B.PROD_ID 
GROUP BY
   B.PROD_BUYER,  A.BUYER_NAME
ORDER BY 1
;

(IN ������)
SELECT
    A.DEPARTMENT_ID �μ��ڵ�,
    A.DEPARTMENT_NAME �μ���
FROM
    HR.DEPARTMENTS A
WHERE 
    A.DEPARTMENT_ID IN (SELECT   DISTINCT DEPARTMENT_ID
                        FROM    HR.EMPLOYEES
                        WHERE   SALARY >= 10000);
(EXISTS ������)               
SELECT
    A.DEPARTMENT_ID �μ��ڵ�,
    A.DEPARTMENT_NAME �μ���
FROM
    HR.DEPARTMENTS A
WHERE 
    EXISTS(SELECT   1
            FROM    HR.EMPLOYEES B
            WHERE   B.SALARY >= 10000
             AND    A.DEPARTMENT_ID =  B.DEPARTMENT_ID)
;

UPDATE
    HR.Departments
SET
    MANAGER_ID = ''
WHERE
    DEPARTMENT_ID = 60;
COMMIT;
 
(IN ������) 
SELECT
    A.EMPLOYEE_ID AS �����ȣ, 
    A.EMP_NAME AS �����, 
    A.DEPARTMENT_ID AS �μ��ڵ�, 
    B.DEPARTMENT_NAME AS �μ���
FROM
    HR.EMPLOYEES A, HR.Departments B
WHERE
    A.DEPARTMENT_ID = B.Department_Id AND
    A.Department_Id NOT IN (SELECT DEPARTMENT_ID
                            FROM HR.DEPARTMENTS
                            WHERE MANAGER_ID IS NULL);
                            
                            

(IN ������ ���)
 SELECT A.DEPARTMENT_NAME �μ���, 
        A.DEPARTMENT_ID �μ��ڵ�
   FROM DEPARTMENTS A
  WHERE A.DEPARTMENT_ID IN (SELECT B.DEPARTMENT_ID
                              FROM EMPLOYEES B
                             WHERE B.DEPARTMENT_ID = A.DEPARTMENT_ID
                               AND B.SALARY > (SELECT AVG(SALARY)
                                                 FROM EMPLOYEES
                                                WHERE DEPARTMENT_ID=A.DEPARTMENT_ID));
                    
                                                
                            

                            
