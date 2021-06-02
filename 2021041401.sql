2021-0414-01)
1. INSERT 
 - ���̺� �ڷḦ ������ ��� ���
 
 (�������)
 INSERT INTO ���̺��(�÷���1..)
    VALUES(��1, ��2..);
    - '(�÷���1,....)'�� �����Ǹ� ��� �÷��� ���ǵ� ������� VALUES ���� ���� �����ؾ��Ѵ�.
    - '(�÷���1,....)'�� ����Ǹ� �� �÷��� ����� ���� VALUES ���� ���
    - �÷��� ������� �� NOT NULL �� ������ �÷��� ������ �� ����(=NOT NULL �� column�ݵ�� VALUES���� �ۼ��ؾ��Ѵ�.)
    
    
 EX)
 -------------------------------------------------------------------------
 �����ȣ   �����              �ּ�            ��ȭ��ȣ        ����      �μ�
 -------------------------------------------------------------------------
 S100      ȫ�ϵ�      ������ �߱� �߾ӷ� 76  042-222-8202     ���      ���ߺ�  
 S201      ������      û�ֽ� ��籸 ���Ǹ�                     ����     ������
 S300      �̼���      ����� ���ϱ� ������   010-2345-6789     ����     ���ߺ� 
 --------------------------------------------------------------------------
 
 INSERT INTO EMP
    VALUES ('S100','ȫ�ϵ�','������ �߱� �߾ӷ� 76', '042-222-8202', '���', '���ߺ�');
    
SELECT * FROM EMP;

 INSERT INTO EMP (EMP_ID, EMP_NAME, ADDR, POSTION_NAME, DEARTMNT_NAME)
    VALUES ('S201','������','û�ֽ� ��籸 ���Ǹ�', '����', '������'); 
    
 INSERT INTO EMP (EMP_ID, EMP_NAME, ADDR, TEL_NO, POSTION_NAME, DEARTMNT_NAME)
    VALUES ('S300','�̼���','����� ���ϱ� ������','010-2345-6789','����','���ߺ�');
 SELECT * FROM EMP;

����1] �����ڷḦ ��������(WORKPLACE)���̺� �����Ͻÿ�

SELECT * FROM WORKPLACE;
------------------------------------------------------------------------------------------------------------
�������ȣ   �����ڸ�      �ּ�               ����ݾ�       �����ο�        ��������        ����ϰ���     ���
------------------------------------------------------------------------------------------------------------
W100       �б�����    ������ ����� ����   1,200,000,000    1000        2021.04.14      2021/12/20    ������
W101       ����Ʈ����  ������ ������         300,000,000     400         2021.02.10      2022/01/17    ������
W200       ���ΰ���     ������ ��ô��       
-------------------------------------------------------------------------------------------------------------
INSERT INTO WORKPLACE (WP_ID, WP_NAME, ADDR, WP_AMT, MAN_AMT, STAT_DATE,COMPLETE_DATA,REMARKS)
VALUES ('W100', '�б�����', '������ ����� ����', '1200000000', '1000','2021/04/14','2021/12/20','������');
INSERT INTO WORKPLACE (WP_ID, WP_NAME, ADDR, WP_AMT, MAN_AMT, STAT_DATE,COMPLETE_DATA,REMARKS)
VALUES ('W101', '����Ʈ����', '������ ������', '300000000', '400','2021.02.10','2022/01/17','������');
INSERT INTO WORKPLACE (WP_ID, WP_NAME, ADDR)
VALUES ('W200', '���ΰ���', '������ ��ô��');



SELECT * FROM WORKPLACE;


**ALTER ���
 -���̺��� ����(���̺��� �̸�, �÷��� ��, �÷��� ������ Ÿ��, �÷��� ũ�⳪ �������(�⺻Ű ����,����,����) ��)�ϴ� ���

(1) ���̺� �̸� ����
ALTER TABLE �����̺��
    RENAME TO �����̺��;
��) EMP���̺��� EMPT���̺��
ALTER TABLE EMP RENAME TO EMPT;

(2) ���̺��� �÷� �߰�
ALTER TABLE ���̺�� 
ADD (�÷��� ������Ÿ�� (ũ��) NOT NULL ��������);
��) ������̺�(EMPT)�� �������(MANAGER_ID) �����ȣ �÷��� �߰��Ͻÿ�
ALTER TABLE EMPT ADD(MANAGER_ID CHAR(4));

(3) ���̺��� ������� �߰�
ALTER TABLE ���̺��
ADD(CONSTRAINT �⺻Ű ������ PRIMARY KEY (�÷���));

(4) ���̺��� �÷��� ����
ALTER TABLE ���̺��
RENAME COLUMN ���÷��� TO ���÷���;
��) ������̺�(EMPT)���� ADDR�÷����� EMP_ADDR�� �����Ͽ���
ALTER TABLE EMPT RENAME COLUMN ADDR TO EMP_ADDR;

(5) ���̺��� ������ Ÿ�� �� ũ�� ����
ALTER TABLE ���̺��
MODIFY (�÷��� ������Ÿ��(ũ��) NOT NULL);
 ��) ALTER TABLE EMPT MODIFY (TEL_NO CHAR(20));

(6) ���̺��� �÷� ����
ALTER TABLE ���̺��
    SET UNUSED | DROP COLUMN �÷���;
    'SET UNUSED' : ������� �������� �����Ѵ�. �Ŀ�, ��������. �ǵ��� �� ����.
    'DROP COLUMN' : �ش� �÷� ����
    
ALTER TABLE EMPT
DROP COLUMN MANAGER_ID;

(7) ���̺��� ������� ����
ALTER TABLE ���̺��
DROP ����������(INDEX, CONSTRAINT ��) �����;



2. DELETE ��
    -���̺� ���� ����� �ڷ� ����
    -ROLLBACK �� ���
    (�������)
    DELETE ���̺�� [WHERE ����];
    
    '[HWERE ����]'�� ���� �Ǹ� ���̺� �ִ� �ڷ� ����
    BUT ROLLBACK ����
SELECT*FROM EMP;


DELETE EMP
 WHERE EMP_ID= 'S100';

ROLLBACK;


��뿹) WROK TABLE�� �����ڷḦ �Է��Ͻÿ�
-----------------------------------
�����ȣ    ������ȣ   ��������    
-----------------------------------
S100        W100        ����
S100        W101        �Ѵ� ��
S201        W200        15�� ��
-----------------------------------

INSERT INTO WORK
VALUES ('S100', 'W100', SYSDATE);
INSERT INTO WORK 
VALUES ('S100', 'W200', SYSDATE+30);
INSERT INTO WORK
VALUES('S300','W100',SYSDATE-30);

SELECT * FROM WORK;

DROP TABLE WORK;
DROP TABLE EMPT;
DROP TABLE WORKPLACE;
SELECT * FROM 
ROLLBACK;






    

