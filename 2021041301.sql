2021-0413-01)SQL��ɾ�
�˻� : SELECT
 . DDL(DATA DEFINITION LANGUAGE) : CREATE, ALTER, DROP
 . DCL(DATA CONTROL LANGUAGE) : GRANT, REVOKE, SAVEPOINT, COMMIT, ROLLBACK
 . DML(DATA MAINPULATION LANGUAGE) : DELETE, INSERT, UPDATE

1. CREATE
 - ��ü(���̺�, �����, ��, �ε��� ��)�������ϴ� ���
 - ���̺� ������ CREATE TABLE ��ɻ��
 (CREATE TABLE ��� �������)
 CREATE TABLE ���̺��(
    �÷���1 ������Ÿ��[(ũ��)] [NOT NULL] [default expr] [,]
    �÷���2 ������Ÿ��[(ũ��)] [NOT NULL] [default expr] [,]
   .
   .
    �÷���n (=�÷��� �������)������Ÿ��[(ũ��)] [NOT NULL] [default expr] [,]
   CONSTRAINT  �⺻Ű������ PRIMARY KEY (�÷���1[,�÷���2,...])[,]
   CONSTRAINT  �ܷ�Ű������1 FOREIGN KEY (�÷���1[,�÷���2,...])
    REFERENCES �������̺��(�����÷���1[,�����÷���2..])[,]
   CONSTRAINT  �ܷ�Ű������2 FOREIGN KEY (�÷���1[,�÷���2,...])[,]
    REFERENCES �������̺��(�����÷���1[,�����÷���2..]);
    
   '���̺��','�÷���','�⺻Ű������','�ܷ�Ű������'�� ����� ���� �ܾ �̿��Ͽ�
   �ο���(ù ���ڴ� �ݵ�� �������̰� �� ���Ĵ� ���� ���� ȥ���Ͽ� ����Ѵ�. Ư��
   ���ڴ� '_' '$' ���� ����� �� ����) (�ظ��ϸ� '$'�� ������� �ʴ´�.)
   '�⺻Ű������' '�ܷ�Ű������'�� WORKSPACE ���� ������ �̸� �̾�� �Ѵ�.
   (�ߺ��� �� ����)
   
   -�⺻Ű������ : pk_���̺��
   -�ܷ�Ű������ : fk_���̺��_�������̺��
   
 (��뿹��)
 CREATE TABLE EMP(
    EMP_ID CHAR(4) NOT NULL,
    EMP_NAME VARCHAR2(20) NOT NULL,
    ADDR VARCHAR2(50) NOT NULL,
    TEL_NO VARCHAR2(15),
    POSTION_NAME VARCHAR2(20) NOT NULL,
    DEARTMNT_NAME VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_EMP PRIMARY KEY (EMP_ID));
    SELECT *FROM EMP;
(��������̺�) : WORKPLACE
    --------------------------------------------------------
    �÷���       ������ Ÿ��       NOT NULL        PK       DEFAULT
    --------------------------------------------------------
    WP_ID       CHAR(4)             N.N          PK
    WP_NAME     VARCHAR2(30)        N.N     
    ADDR        VARCHAR2(50)        N.N
    TEL_NO      VARCHAR2(15)      
    WP_AMOUNT   NUMBER(11)                                  0           
    MAN_AMOUNT  NUMBER(4)                                   0
    STAT_DATE   DATE                                        SYSDATE
    COMPLETE_DATA DATE
    REMARKS      VARCHAR2(100)
    ---------------------------------------------------------
    CREATE TABLE WORKPLACE (
    WP_ID CHAR(4),
    WP_NAME VARCHAR2(30) NOT NULL,
    ADDR VARCHAR2(50) NOT NULL,
    TEL_NO VARCHAR2(15), 
    WP_AMT NUMBER(11) DEFAULT 0,
    MAN_AMT NUMBER(4) DEFAULT 0,                      
    STAT_DATE DATE  DEFAULT SYSDATE,
    COMPLETE_DATA DATE,
    REMARKS VARCHAR2(100),
    CONSTRAINT PK_WORKPLACE PRIMARY KEY (WP_ID));
    
    -----------------------------------------------------------
 
    (��뿹��) �ٹ����̺� :  
    -----------------------------------------------------------
    �÷���       ������ Ÿ��       NOT NULL        PK       
    -----------------------------------------------------------
    EMP_ID       CHAR(4)           N.N          PK&FK
    WP_ID        CHAR(4)           N.N         PK&FK
    INPUT_DATE   DATE        
    ------------------------------------------------------------   
    CREATE TABLE WORK(
    EMP_ID CHAR(4),
    WP_ID  CHAR(4),
    INPUT_DATE DATE,
    CONSTRAINT PK_WORK PRIMARY KEY (EMP_ID,WP_ID),
    CONSTRAINT FK_WORK_EMP FOREIGN KEY (EMP_ID)
        REFERENCES EMP(EMP_ID),
    CONSTRAINT FK_WORK_WORKPLACE FOREIGN KEY (WP_ID)
        REFERENCES WORKPLACE(WP_ID));
        
    --------------------------------------------------------------
2. DROP TABLE : ���̺� ����
    DROP TABLE ���̺��;
    
    (��뿹��)
    DROP TABLE EMP;
    