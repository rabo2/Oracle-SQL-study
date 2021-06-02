2021-0416-01) 
2. ���� �ڷ���(������ Ÿ��)
 - NUMBER �� ������
 (�������)
 �÷��� NUMBER[(P|*[,S])];
   1) P > S �ΰ��
 - [(P|*[,S])]�� ������ ��� 2^17���� ����� �Է°� ��� ����
 - [,S]�� �����ϴ� ��� S �� 0���� �Էµ�
 - * : �ý����� ����ϴ� ������ ������ ǥ��
  . P : ��ü�ڸ� ��(1 ~ 38)
  . S : �Ҽ��� ������ �ڸ� �� (-84 ~ 127)
  . S�� ����̸� �Ҽ��� ���� S+1��°���� �ݿø��Ͽ� S��° ���� ����
  . S�� ����̸� �Ҽ��� ���� S+1��°���� �ݿø��Ͽ� S��° ���� ����
  . S�� �����̸� �����κ��� ���� S��°���� �ݿø��Ͽ� ���� ---DB������ �̿��ϴ� ��찡 ����.
  
    -----------------------------------------------------------
     ������        ������Ÿ��       ����Ǵ� ����
     ----------------------------------------------------------
     123.56789      NUMBER          123.5678
      ""           NUMBER(7,3)      0123.568
      ""           NUMBER(3,2)      ����
      ""           NUMBER(*,3)      123.568
      ""           NUMBER(4)        0124
     12345.78      NUMBER(5,-2)     12300 
    -----------------------------------------------------------


    2) P<=S �ΰ��
    . S�� �Ҽ��� ������ ǥ��[����]�� ��ȿ ������ �ڸ���. S+1�� �ڸ��� ���� �ݿø� ��
    . P�� �Ҽ��� ���Ͽ��� ��ȿ���� �ڸ���
    . S-P ��ŭ�� '0'�� �Ҽ������Ͽ� �����ؾ���
    
    ------------------------------------------------------------
    ������         ����             ���Ǵ� ��   
    ------------------------------------------------------------
    1.2345      NUMBER(5,6)         ����
    3.23        NUMBER(3,5)         ����
    0.0123      NUMBER(3,4)         0.0123
    0.01234     NUMBER(4,5)         0.01234
    0.001234    NUMBER(3,5)         0.00123
    ------------------------------------------------------------


3. ���� ������ Ÿ��
 - DATE, TIMESTAMP Ÿ���� ����
    1)DATE
    . �⺻ ������ Ÿ��
    . ��,��,��,��,��,�� ����
    . '+'�� '-'������ ����('*','/'�� �Ұ���)
    . ������ ũ�⸦ �������� ����
    . ��,��,�� �� ������ ������ ǥ�� ������δ� ��µ��� ����
    (�������)
    �÷��� DATE;
    
    ��뿹)
    CREATE TABLE TEMP05 (
    COL1 DATE,
    COL2 DATE,
    COL3 DATE)
    
    -SYSDATE : ���� ��¥, �ð��� ��Ÿ���� �Լ�
    INSERT INTO TEMP05 
    VALUES (SYSDATE,SYSDATE-10,SYSDATE+10);
    
    **�ú��� ���
    SELECT TO_CHAR(COL1, 'YYYY-MM-DD AM HH24:MI:SS') FROM TEMP05;
    
    2)TIMESTAMP
    . �ð��� ����(TIME ZONE)�� 10����� 1�� ������ ������ �ð� ���� 
    . TIMESTAMP, TIMESTAMP WITH TIME ZONE, TIMESTAMP WITH LOCAL TIME ZONE ����
    . TIMESTAMP : �ð��� ������ ������ ���� ����
    . TIMESTAMP WITH TIME ZONE, TIMESTAMP WITH LOCAL TIME ZONE : �ð��� ������ ������ ����
    . ������ ũ�⸦ ������ ����
    (�������)
    �÷���   TIMESTAMP | --�ð��� ������ ���� (client�� �ð��� ��Ÿ��)
            TIMESTAMP WITH TIME ZONE | --�ð��� ���� ����
            TIMESTAMP WITH LOCAL TIME ZONE | --������ ��ġ�� �ð��� ���� (=TIMESTMAP�� ����)
            
    CREATE TABLE TEMP06(
    COL1  TIMESTAMP,
    COL2  TIMESTAMP WITH TIME ZONE,
    COL3  TIMESTAMP WITH LOCAL TIME ZONE);
    
    INSERT INTO TEMP06
    VALUES (SYSDATE, SYSDATE, SYSDATE);
    SELECT * FROM TEMP06;
    
4.��Ÿ�ڷ���
 - �����ڷḦ ó���ϱ� �����ڷ���
 - RAW,BLOB,BFILE,LONG RAW ���� ������ 
 1)RAW
 . �ε��� ó���� ������ 2���ڷ�(�����Ը�: 2000BYTE)
 . DB���� �ؼ� �� ��ȯ �۾��� �������� ����
 . 16������ 2������ ���尡��
 . ����, ���� �� ������ ����
 (�������)
 �÷��� RAW(ũ��)
 (��뿹��)
 CREATE TABLE TEMP07(
 COL1 RAW(100),
 COL2 RAW(200));
 
 INSERT INTO TEMP07
 VALUES('1100111',HEXTORAW('EF'));
 
  2)BFILE
  . 2���ڷ� ����
  . ����� �ڷ�� DB�ܺο� ���� ����
  . DB ������ ��� ����(DIRECTORY ��ü)�� ����
  . 4GB���� ó�� ����
  
  **���丮 ��ü ����
    CREATE DIRECTORY ���丮��Ī AS ��θ�;
    - '���丮��Ī'�� 30 BYTE ���� ���
    - '��θ�' : �����ڷᰡ �ִ� ��θ�
    
    CREATE DIRECTORY  TEST_DIR AS 'D:\A_TeachingMaterial\2.Oracle';
    CREATE TABLE TEMP08(
    COL1 BFILE);
    INSERT INTO TEMP08 
    VALUES(BFILENAME('TEST_DIR','WINTER1.jpg'));
  SELECT * FROM TEMP08;
  
  
  3)BLOB
   . 2���ڷ� ����
  . ����� �ڷ�� DB���ο� ���� ����
  . 4GB���� ó�� ����
  (�������)
  �÷��� BLOB
  
  (��뿹)
  CREATE TABLE TEMP09(
  COL1 BLOB);
  **���� INSERT���� ���Ͽ� ���� �Ұ���
    �͸��� ���
    
    DECLARE
    L_DIR VARCHAR2(20) := 'TEST_DIR';
    L_FILE  VARCHAR2(30) := 'WINTER1.jpg';
    L_BFILE BFILE;
    L_BLOB BLOB;
    
    BEGIN
    INSERT INTO TEMP09 (COL1)
    VALUES (EMPTY_BLOB())
    RETURN COL1 INTO L_BLOB;
    
    L_BFILE := BFILENAME(L_DIR,L_FILE);
    DBMS_LOB.FILEOPEN(L_BFILE, DBMS_LOB.FILE_READONLY);
    DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
    DBMS_LOB.FILECLOSE(L_BFILE);
    
    COMMIT;
    
    END;
    
    SELECT (BUYER_ID, BUYER_NAME, PROD_ID) FROM BUYER
    LEFT JOIN PROD
    ON BUYER_LGU = PROD_LGU;
  
  