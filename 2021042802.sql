2021 - 0428 - 02
SELECT
    COUNT(*) AS "buyprod�� ���� ��"
FROM
    buyprod; --148�� ��

SELECT
    COUNT(*) AS "cart�� ���� ��"
FROM
    cart; -- 207�� ��

SELECT
    COUNT(*)
FROM
    BUYPROD,
    MEMBER,
    CART,
    PROD; -- 2267064�� ��
    

SELECT  A.EMPLOYEE_ID AS �����ȣ, 
        A.EMP_NAME AS �����, 
        B.DEPARTMENT_ID AS �μ��ڵ�, 
        B.DEPARTMENT_NAME AS �μ���
FROM    HR.EMPLOYEES A, HR.DEPARTMENTS B
WHERE   A.DEPARTMENT_ID<=80 AND -- �Ϲ�����
        A.DEPARTMENT_ID = B.DEPARTMENT_ID
        --Join ����
ORDER BY 1
;

SELECT  A.EMPLOYEE_ID AS �����ȣ, 
        A.EMP_NAME AS �����, 
        B.DEPARTMENT_ID AS �μ��ڵ�, 
        B.DEPARTMENT_NAME AS �μ���
FROM    HR.EMPLOYEES A INNER JOIN 
        HR.DEPARTMENTS B ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID) --Join����
        AND A.DEPARTMENT_ID<=80 -- EMPLOYEES�� DEPARTMENTS�� ����Ǵ� �Ϲ�����
ORDER BY 1
;

SELECT  
    B.BUYER_ID AS �ŷ�ó�ڵ�, 
    B.BUYER_NAME AS �ŷ�ó��, 
    SUM(A.BUY_QTY) AS ���Լ���, 
    SUM(A.BUY_COST*A.BUY_QTY) AS ���Աݾ�
  FROM  
    BUYPROD A, BUYER B, PROD C
 WHERE  
    A.BUY_PROD =  C.PROD_ID  -- ��������
    AND B.BUYER_ID = C.PROD_BUYER  -- ��������
    AND A.BUY_DATE BETWEEN '20050101' AND '20050131' -- �Ϲ�����
GROUP BY 
    B.BUYER_ID,B.BUYER_NAME
ORDER BY 1
;




SELECT  
    B.BUYER_ID AS �ŷ�ó�ڵ�, 
    B.BUYER_NAME AS �ŷ�ó��, 
    SUM(A.BUY_QTY) AS ���Լ���, 
    SUM(A.BUY_COST*A.BUY_QTY) AS ���Աݾ�
FROM  
    BUYPROD A 
INNER JOIN PROD C ON(A.BUY_PROD =  C.PROD_ID)
           AND A.BUY_DATE BETWEEN '20050101' AND '20050131'
    INNER JOIN BUYER B ON(B.BUYER_ID = C.PROD_BUYER)
GROUP BY
    B.BUYER_ID, B.BUYER_NAME
ORDER BY 1
;


SELECT  
    B.BUYER_ID AS �ŷ�ó�ڵ�, 
    B.BUYER_NAME AS �ŷ�ó��, 
    NVL(SUM(A.BUY_QTY),0) AS ���Լ���, 
    NVL(SUM(A.BUY_COST*A.BUY_QTY),0) AS ���Աݾ�
FROM  
    BUYPROD A 
    LEFT OUTER JOIN PROD C ON(A.BUY_PROD =  C.PROD_ID)
           AND A.BUY_DATE BETWEEN '20050101' AND '20050131'
    RIGHT OUTER JOIN BUYER B ON(B.BUYER_ID = C.PROD_BUYER)
GROUP BY
    B.BUYER_ID, B.BUYER_NAME
ORDER BY 1
;


SELECT  
    B.BUYER_ID AS �ŷ�ó�ڵ�, 
    B.BUYER_NAME AS �ŷ�ó��, 
    NVL(SUM(A.BUY_QTY),0) AS ���Լ���, 
    NVL(SUM(A.BUY_COST*A.BUY_QTY),0) AS ���Աݾ�
FROM  
    BUYPROD A 
    LEFT OUTER JOIN PROD C ON(A.BUY_PROD =  C.PROD_ID)
    RIGHT OUTER JOIN BUYER B ON(B.BUYER_ID = C.PROD_BUYER)
WHERE
    A.BUY_DATE BETWEEN '20050101' AND '20050131'
GROUP BY
    B.BUYER_ID, B.BUYER_NAME
ORDER BY 1
;