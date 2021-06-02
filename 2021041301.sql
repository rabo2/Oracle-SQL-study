2021-0413-01)SQL명령어
검색 : SELECT
 . DDL(DATA DEFINITION LANGUAGE) : CREATE, ALTER, DROP
 . DCL(DATA CONTROL LANGUAGE) : GRANT, REVOKE, SAVEPOINT, COMMIT, ROLLBACK
 . DML(DATA MAINPULATION LANGUAGE) : DELETE, INSERT, UPDATE

1. CREATE
 - 객체(테이블, 사용자, 뷰, 인덱스 등)을생성하는 명령
 - 테이블 생성시 CREATE TABLE 명령사용
 (CREATE TABLE 명령 사용형식)
 CREATE TABLE 테이블명(
    컬럼명1 데이터타입[(크기)] [NOT NULL] [default expr] [,]
    컬럼명2 데이터타입[(크기)] [NOT NULL] [default expr] [,]
   .
   .
    컬럼명n (=컬럼의 제약사항)데이터타입[(크기)] [NOT NULL] [default expr] [,]
   CONSTRAINT  기본키설정명 PRIMARY KEY (컬럼명1[,컬럼명2,...])[,]
   CONSTRAINT  외래키설정명1 FOREIGN KEY (컬럼명1[,컬럼명2,...])
    REFERENCES 참조테이블명(참조컬럼명1[,참조컬럼명2..])[,]
   CONSTRAINT  외래키설정명2 FOREIGN KEY (컬럼명1[,컬럼명2,...])[,]
    REFERENCES 참조테이블명(참조컬럼명1[,참조컬럼명2..]);
    
   '테이블명','컬럼명','기본키설정명','외래키설정명'는 사용자 정의 단어를 이용하여
   부여함(첫 글자는 반드시 영문자이고 그 이후는 숫자 영문 혼합하여 사용한다. 특수
   문자는 '_' '$' 등을 사용할 수 있음) (왠만하면 '$'는 사용하지 않는다.)
   '기본키설정명' '외래키설정명'은 WORKSPACE 에서 유일한 이름 이어야 한다.
   (중복할 수 없음)
   
   -기본키설정명 : pk_테이블명
   -외래키설정명 : fk_테이블명_참조테이블명
   
 (사용예시)
 CREATE TABLE EMP(
    EMP_ID CHAR(4) NOT NULL,
    EMP_NAME VARCHAR2(20) NOT NULL,
    ADDR VARCHAR2(50) NOT NULL,
    TEL_NO VARCHAR2(15),
    POSTION_NAME VARCHAR2(20) NOT NULL,
    DEARTMNT_NAME VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_EMP PRIMARY KEY (EMP_ID));
    SELECT *FROM EMP;
(사업장테이블) : WORKPLACE
    --------------------------------------------------------
    컬럼명       데이터 타입       NOT NULL        PK       DEFAULT
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
 
    (사용예시) 근무테이블 :  
    -----------------------------------------------------------
    컬럼명       데이터 타입       NOT NULL        PK       
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
2. DROP TABLE : 테이블 삭제
    DROP TABLE 테이블명;
    
    (사용예시)
    DROP TABLE EMP;
    