2021-0415-02)
SELECT ��
- ���̺� ����� �ڷḦ ��ȸ�ϴ� ��ɾ�
�������)
SELECT *|[[DISTINCT]�÷���1 [AS ["]��Ī["},]
                    �÷���2 [AS ["]��Ī["},]
                             :
                    �÷���N [AS ["]��Ī["],]]
    FROM ���̺��
    [WHERE ����]
    [GROUP BY �÷��� [,�÷���,...]]
    [HAVING ����]
    [ORDER BY �÷���|�÷��ε��� [ASC|DESC]][,�÷���|�÷��ε��� [ASC|DESC]]
    
    - SELECT (COLUMN �� ���õ� ����) FROM ���̺� �� WHERE(ROW �� ���õ� ����)
    -'*' (=ALL) ��� �÷��� ��ȸ�� 
    - ������� : FROM �� -> WHERE�� -> SELECT��
    - �÷���Ī�� Ư������(���� ��)�� ����� ���� ""�� ��� �����
    - DISTINCT(=�ߺ� �� ������)
    - ��Ī�� COLUMN�� �� �ٸ� �̸��� �ο�/��Ī�� Ư�����ڰ� ���� ��� �ݵ�� ""�� �������
    - ��, ���Ǿ�(KEY)�� �Ȱ��� �ܾ ����ϸ� �ȵ�
    - ���̺� ���� �ʿ� ���� ���, ��¥ ����� SELECT�� ����Ҷ��� FROM �ڿ� 
      Dummy ���̺��� DUAL�� ����Ѵ�.
    - SUM, AVG, COUNT, MIN, MAX(�����Լ�)�� ��쿡�� FROM�� �ƴ� HAVING �� �����
    - GROUP BY : Ư���������� ���� �� ���
    - ORDER BY : ũ�� �� ���� ASC(=��������) DESC(=��������) ������ DEFAULT�� ASC
    - ORACLE�� 1���� ����. 
    
 EX) �з����̺� (LPROD)�� ��� �ڷ� ��ȸ
SELECT * 
    FROM LPROD;
    
ȸ�����̺��� ����ȸ���� ��ȸȸ�� ȸ����ȣ, �̸�, ����, �ּҸ� ��ȸ�Ͻÿ�
SELECT  MEM_ID AS ȸ����ȣ,
        MEM_NAME AS �̸�, 
        EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS ����,--EXTRACT ���� 
        MEM_ADD1||' '||MEM_ADD2 AS �ּ� ----||' '|| 2���� COLUMN�� ����
    FROM MEMBER
    WHERE SUBSTR(MEM_REGNO2,1,1)='2' OR SUBSTR(MEM_REGNO2,1,1)='4' ;
    
ȸ�����̺��� 50�� �̻� ȸ���� ��ȸȸ�� ȸ����ȣ, �̸�, ����, �ּҸ� ��ȸ�Ͻÿ�
SELECT  MEM_ID AS ȸ����ȣ,
        MEM_NAME AS �̸�, 
        EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS ����, 
        MEM_ADD1||' '||MEM_ADD2 AS �ּ�
    FROM MEMBER
    WHERE EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) >=50
    ; -------AS ��Ī�� FROM �̳� WHERE ������ ���� �Ҽ� ����
      --���� ������ FROM -> WHERE -> SELECT ���̱� �����̱� ������ ��Ī ��뿡 �����Ѵ�.
      

2. ������ Ÿ��
 - ���ڿ�, ����, ��¥, ��Ÿ(2���ڷ� <�׸�, ������>)�� ����
 1)���ڿ� �ڷ�
    - �������� ���ڿ��� �������� ���ڿ��� ���� 
    - CHAR, VARCHAR, VARCHAR2(����Ŭ���� ����), LONG, 
      CLOB(LARGE OBJECT), (NATIONAL=)NVARCHAR2, NCLOB ���� ����
    (1)CHAR
        . �������� ���ڿ� �ڷ� ����
        . �ִ� 2000BYTE ���� ���尡��
        . ���ʺ��� ����ǰ� ���� �������� ����ó��
        (�������)
        �÷��� CHAR(ũ��[BYTE|CHAR]);
        . 'ũ��'�� Ȯ���Ǵ� ������
        . BYTE|CHAR : �⺻���� BYTE�̰� 'ũ��'�� BYTE ���� �Ǵ� CHAR ���� ����
            DEFAULT �� BYTE
            ��, CHAR �� �����ǵ� 2000BYTE�� �ʰ� �� �� ����
        . �ѱ� �� ���ڴ� 3 BYTE
        EX) COL1 CHAR(2000 CHAR) => �ѱ� ����� ����? 666��
        . �ڷᰡ DATA �ʰ��� ERROR, �����ϸ� ���ʺ��� ä��������
        . �⺻Ű�� ��κ� ���� ���̸� ������ ������ �⺻Ű DATA TYPE�� ����ϱ� ����
        
    
    ��뿹)
CREATE TABLE TEMP01(
COL1 CHAR(10),
COL2 CHAR(10 CHAR),
COL3 CHAR(10 BYTE));
   
INSERT INTO TEMP01
VALUES ('BOYHOOD','�����ĵ�','������');
SELECT *FROM TEMP01;

SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3)
FROM TEMP01;

    (2)VARCHAR2
        . �������� ���ڿ� ���� -���ڿ��� ���̸�ŭ�� ����ϰ� ���� ������ �ý��ۿ� ��ȯ
        . 4000BYTE ���� ���尡��/ �ѱ��� 1333���ڱ���
        (�������)
        �÷��� VARCHAR2(ũ�� [BYTE|CHAR])
        
��뿹)
CREATE TABLE TEMP02(
 COL1 VARCHAR2(200),
 COL2 VARCHAR2(200 CHAR),
 COL3 VARCHAR2(200 BYTE));
 
 INSERT INTO TEMP02 
 VALUES ('ILPOSTINO','������Ƽ��','ABCDEFGHIJK');
        
SELECT *FROM TEMP02;
SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3)
FROM TEMP02;

��뿹) HR������ ������̺��� FIRST_NAME �÷�DMF CHAR(50)DMFH �����Ͻÿ�

ALTER TABLE HR.EMPLOYEES
    MODIFY (FIRST_NAME CHAR(50));

 (3)LONG
 - �������� ���ڿ� ����
 - 2gb���� ���尡��
 - �� ���̺� �� �÷��� ��밡��
 - CLOB Ÿ������ ��ü
 (�������)
 �÷��� LONG;
 . SELECT ���� SELECT��, UPDATE���� SET��, INSERT���� VALUES������ ��밡��
 . ���̻� ��� ���� ���񽺰� �������� ����

CREATE TABLE TEMP03(
    COL1 VARCHAR2(4000),
    COL2 LONG;
    
    
 (4) CLOB
  - Character Large Objects
  - ��뷮 �������� ���ڿ� �ڷ� ����(4GB = 2^30 BYTE)
  - �� ���̺� �������� clob���𰡴�
  - �Ϻ� ����� lob api ������ �޾ƾ� ��
  - �뷮�� ũ�⶧���� �Ϻ� ��ɾ�(�Լ�)���� ����� �Ұ����Ͽ� Ư���Լ����� ����ؿ��Ѵ�.
  (�������)
  �÷��� clob;
  
  CREATE TABLE TEMP04(
    COL1 CLOB,
    COL2 CLOB,
    COL3 VARCHAR2(4000));
    INSERT INTO TEMP04
    VALUES ('������ �߱� ���ﵿ 500 ���κ���','���ѹα��� ���ְ�ȭ���̴�','SFDJIQJLLF');
  SELECT LENGTH(COL1),LENGTH(COL2) FROM TEMP04;
  
  SELECT SUBSTR(COL1, 2,4) FROM TEMP04; --COL 1 ���� 2��°���� 4���ڸ� �д´�.
  SELECT DBMS_LOB.SUBSTR(COL1,2,4) FROM TEMP04; --COL 1���� 4��°���� 2���ڸ� �д´�.
  
  (5)NCLOB, NVARCHAR2
  - �ڷḦ ����ǥ���ڵ�(UTF-8, UTF-16)�� ����Ͽ� ����
  - ������ ����� ����
  (�������)
  