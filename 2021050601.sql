2021-05-06-01

1) ���̺�� : EXP_GOODS_ASIA
2) �÷�
----------------------------------------
�÷���     ������ Ÿ��      �������
----------------------------------------
COUNTRY     VARCHAR(20)
SEQ         NUMBER
GOODS       VARCHAR2(100)
----------------------------------------
3)������
-----------------------------------------
COUNTRY     SEQ     GOODS
----------------------------------------
���ѹα�       1       �������ܼ�����
���ѹα�       2       �ڵ���
���ѹα�       3       ��������ȸ��
���ѹα�       4       ����
���ѹα�       5       LCD
���ѹα�       6       �ڵ�����ǰ
���ѹα�       7       �޴���ȭ
���ѹα�       8       ȯ��źȭ����
���ѹα�       9       �����۽ű� ���÷��� ��ǰ
���ѹα�       10      ö �Ǵ� ���ձݰ�

INSERT INTO EXP_GOODS_ASIA
VALUES ('���ѹα�',1,'�������� ������');
INSERT INTO EXP_GOODS_ASIA
VALUES ('���ѹα�',2,'�ڵ���');
INSERT INTO EXP_GOODS_ASIA
VALUES ('���ѹα�',3,'��������ȸ��');
INSERT INTO EXP_GOODS_ASIA
VALUES ('���ѹα�',4,'����');
INSERT INTO EXP_GOODS_ASIA
VALUES ('���ѹα�',5,'LCD');
INSERT INTO EXP_GOODS_ASIA
VALUES ('���ѹα�',6,'�ڵ�����ǰ');
INSERT INTO EXP_GOODS_ASIA
VALUES ('���ѹα�',7,'�޴���ȭ');
INSERT INTO EXP_GOODS_ASIA
VALUES ('���ѹα�',8,'ȯ��źȭ����');
INSERT INTO EXP_GOODS_ASIA
VALUES ('���ѹα�',9,'�����۽ű� ���÷��� ��ǰ');
INSERT INTO EXP_GOODS_ASIA
VALUES ('���ѹα�',10,'ö �Ǵ� ���ձݰ�');
-------------------------------------------
�Ϻ�         1       �ڵ���
�Ϻ�          2       ��������ȸ��
�Ϻ�          3       ����
�Ϻ�          4       �ݵ�ü ������
�Ϻ�          5       ȭ����
�Ϻ�          6       �������� ������
�Ϻ�          7       �������ܼ�����
�Ϻ�          8       �Ǽ����
�Ϻ�          9       ���̿���,Ʈ��������
�Ϻ�          10      ����

INSERT INTO EXP_GOODS_ASIA
VALUES ('�Ϻ�',1,'�ڵ���');
INSERT INTO EXP_GOODS_ASIA
VALUES ('�Ϻ�',2,'�ڵ�����ǰ');
INSERT INTO EXP_GOODS_ASIA
VALUES ('�Ϻ�',3,'��������ȸ��');
INSERT INTO EXP_GOODS_ASIA
VALUES ('�Ϻ�',4,'����');
INSERT INTO EXP_GOODS_ASIA
VALUES ('�Ϻ�',5,'�ݵ�ü ������');
INSERT INTO EXP_GOODS_ASIA
VALUES ('�Ϻ�',6,'ȭ����');
INSERT INTO EXP_GOODS_ASIA
VALUES ('�Ϻ�',7,'�������� ������');
INSERT INTO EXP_GOODS_ASIA
VALUES ('�Ϻ�',8,'�Ǽ����');
INSERT INTO EXP_GOODS_ASIA
VALUES ('�Ϻ�',9,'���̿���,Ʈ��������');
INSERT INTO EXP_GOODS_ASIA
VALUES ('�Ϻ�',10,'����');

CREATE TABLE EXP_GOODS_AISA(
        COUNTRY     VARCHAR(20),
        SEQ         NUMBER,
        GOODS       VARCHAR2(100));
        
ALTER TABLE EXP_GOODS_AISA
RENAME TO EXP_GOODS_ASIA;

COMMIT;

SELECT  GOODS
FROM    EXP_GOODS_ASIA
WHERE   COUNTRY = '���ѹα�'
UNION ALL
SELECT  GOODS 
FROM    EXP_GOODS_ASIA 
WHERE   COUNTRY = '�Ϻ�';

SELECT  MEM_ID ȸ����ȣ,
        MEM_NAME ȸ����,
        MEM_ADD1||' '||MEM_ADD2 ȸ���ּ�
FROM    MEMBER
WHERE   SUBSTR(MEM_REGNO2,1,1) IN ('2','4')
INTERSECT
SELECT  MEM_ID ȸ����ȣ,
        MEM_NAME ȸ����,
        MEM_ADD1||' '||MEM_ADD2 ȸ���ּ�
FROM    MEMBER
WHERE   MEM_MILEAGE>4000
ORDER BY 1;


SELECT  GOODS
FROM    EXP_GOODS_ASIA
WHERE   COUNTRY = '���ѹα�'
INTERSECT
SELECT  GOODS
FROM    EXP_GOODS_ASIA
WHERE   COUNTRY = '�Ϻ�';

SELECT  PROD_ID ��ǰ�ڵ�, 
        PROD_NAME ��ǰ��, 
        PROD_COST �ܰ�
FROM    CART, PROD
WHERE   CART_PROD = PROD_ID AND
        CART_NO LIKE '200504%'
INTERSECT
SELECT  PROD_ID ��ǰ�ڵ�, 
        PROD_NAME ��ǰ��, 
        PROD_COST �ܰ�
FROM    CART, PROD
WHERE   CART_PROD = PROD_ID AND
        CART_NO LIKE '200506%'
        
        
2005�� 5�� ���Ե� ��ǰ �� ������ �߻��� ��ǰ�� ��ȸ�Ͻÿ�
Alias �� ��ǰ�ڵ�, ��ǰ��, ����ó��

SELECT  a.PROD_ID ��ǰ�ڵ�, 
        a.PROD_NAME ��ǰ��, 
        b.BUYER_NAME ����ó��
FROM    PROD a, BUYER b, BUYPROD c 
WHERE   BUY_PROD = PROD_ID AND
        PROD_BUYER = BUYER_ID AND
        BUY_DATE BETWEEN '20050501' AND '20050531'
INTERSECT
SELECT  a.PROD_ID ��ǰ�ڵ�, 
        a.PROD_NAME ��ǰ��, 
        c.BUYER_NAME ����ó��
FROM    PROD a, CART b, BUYER c
WHERE   PROD_BUYER = BUYER_ID AND
        CART_PROD = PROD_ID AND
        CART_NO LIKE '200505%'
ORDER BY 1;

SELECT  goods
FROM    exp_goods_asia
WHERE   COUNTRY = '���ѹα�'
MINUS
SELECT  goods
FROM    exp_goods_asia
WHERE   COUNTRY = '�Ϻ�';



                                               
    

(SELECT  A.BUY_PROD ��ǰ�ڵ�, 
        B.PROD_NAME ��ǰ��, 
        A.BUY_COST ���Դܰ�
FROM    BUYPROD A, PROD B
WHERE   B.PROD_ID = A.BUY_PROD
        AND A.BUY_DATE BETWEEN '20050501' AND '20050531'
MINUS
SELECT  A.BUY_PROD ��ǰ�ڵ�, 
        B.PROD_NAME ��ǰ��, 
        A.BUY_COST ���Դܰ�
FROM    BUYPROD A, PROD B
WHERE   B.PROD_ID = A.BUY_PROD
        AND A.BUY_DATE BETWEEN '20050601' AND '20050630')
        
MINUS        
(SELECT
    a.buy_prod ��ǰ�ڵ�,
    B.prod_name ��ǰ��,
    A.buy_cost ���Դܰ�
FROM
    buyprod A,
    prod B
WHERE
    B.prod_id = A.buy_prod
    and buy_date between '20050501' and '20050531'
    AND BUY_PROD NOT IN (SELECT BUY_PROD
                         FROM   buyprod
                         WHERE  buy_date between '20050601' and '20050630')) ;


2005�� 5�� ���ں� ��ǰ�� ����/������Ȳ�� ��ȸ�Ͻÿ�
Alias�� ����, ��ǰ��, ����, ����
'����'���� ���� �Ǵ� ������ ����ϸ�, ���տ����ڸ� ����Ͻÿ�

SELECT  TO_DATE(SUBSTR(A.CART_NO,1,8)) ����, 
        B.PROD_NAME ��ǰ��, 
        A.CART_QTY ����, 
        '����' ����
FROM    CART A,PROD B
WHERE   A.CART_PROD = B.PROD_ID
        AND A.CART_NO LIKE '200505%'
UNION  ALL
SELECT  A.BUY_DATE ����, 
        B.PROD_NAME ��ǰ��, 
        A.BUY_QTY ����, 
        '����' ����
FROM    BUYPROD A, PROD B
WHERE   A.BUY_PROD = B.PROD_ID
        AND BUY_DATE BETWEEN '20050501' AND '20050531'
ORDER BY 1;


SELECT
    A.EMPLOYEE_ID AS �����ȣ, 
    A.EMP_NAME AS �����, 
    A.DEPARTMENT_ID AS �μ��ڵ�, 
    A.SALARY AS �޿�,
    B.RAS AS �μ���ձ޿�
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
