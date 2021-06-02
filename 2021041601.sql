2021-0416-01) 
2. 숫자 자료형(데이터 타입)
 - NUMBER 로 제공됨
 (사용형식)
 컬럼명 NUMBER[(P|*[,S])];
   1) P > S 인경우
 - [(P|*[,S])]를 생략할 경우 2^17까지 사용자 입력값 대로 저장
 - [,S]를 생략하는 경우 S 가 0으로 입력됨
 - * : 시스템이 허락하는 범위의 정수를 표기
  . P : 전체자리 수(1 ~ 38)
  . S : 소숫점 이하의 자리 수 (-84 ~ 127)
  . S가 양수이면 소숫점 이하 S+1번째에서 반올림하여 S번째 까지 저장
  . S가 양수이면 소숫점 이하 S+1번째에서 반올림하여 S번째 까지 저장
  . S가 음수이면 정수부분의 이하 S번째에서 반올림하여 저장 ---DB에서는 이용하는 경우가 적다.
  
    -----------------------------------------------------------
     데이터        데이터타입       저장되는 형태
     ----------------------------------------------------------
     123.56789      NUMBER          123.5678
      ""           NUMBER(7,3)      0123.568
      ""           NUMBER(3,2)      오류
      ""           NUMBER(*,3)      123.568
      ""           NUMBER(4)        0124
     12345.78      NUMBER(5,-2)     12300 
    -----------------------------------------------------------


    2) P<=S 인경우
    . S는 소숫점 이하의 표현[저장]할 유효 숫자의 자리수. S+1의 자리의 값은 반올림 됨
    . P는 소숫점 이하에서 유효숫자 자리수
    . S-P 만큼의 '0'이 소수점이하에 존재해야함
    
    ------------------------------------------------------------
    데이터         선언             기억되는 값   
    ------------------------------------------------------------
    1.2345      NUMBER(5,6)         오류
    3.23        NUMBER(3,5)         오류
    0.0123      NUMBER(3,4)         0.0123
    0.01234     NUMBER(4,5)         0.01234
    0.001234    NUMBER(3,5)         0.00123
    ------------------------------------------------------------


3. 날자 데이터 타입
 - DATE, TIMESTAMP 타입이 제공
    1)DATE
    . 기본 데이터 타입
    . 년,월,일,시,분,초 저장
    . '+'와 '-'연산이 가능('*','/'는 불가능)
    . 데이터 크기를 지정하지 않음
    . 시,분,초 는 저장은 되지만 표준 출력으로는 출력되지 않음
    (사용형식)
    컬럼명 DATE;
    
    사용예)
    CREATE TABLE TEMP05 (
    COL1 DATE,
    COL2 DATE,
    COL3 DATE)
    
    -SYSDATE : 현재 날짜, 시각을 나타내는 함수
    INSERT INTO TEMP05 
    VALUES (SYSDATE,SYSDATE-10,SYSDATE+10);
    
    **시분초 출력
    SELECT TO_CHAR(COL1, 'YYYY-MM-DD AM HH24:MI:SS') FROM TEMP05;
    
    2)TIMESTAMP
    . 시간대 정보(TIME ZONE)와 10억분의 1초 단위의 정교한 시각 제공 
    . TIMESTAMP, TIMESTAMP WITH TIME ZONE, TIMESTAMP WITH LOCAL TIME ZONE 제공
    . TIMESTAMP : 시간대 정보를 가지고 있지 않음
    . TIMESTAMP WITH TIME ZONE, TIMESTAMP WITH LOCAL TIME ZONE : 시간대 정보를 가지고 있음
    . 데이터 크기를 가지지 않음
    (사용형식)
    컬럼명   TIMESTAMP | --시간대 정보가 없음 (client의 시간을 나타냄)
            TIMESTAMP WITH TIME ZONE | --시간대 정보 포함
            TIMESTAMP WITH LOCAL TIME ZONE | --서버가 위치한 시간대 정보 (=TIMESTMAP와 동일)
            
    CREATE TABLE TEMP06(
    COL1  TIMESTAMP,
    COL2  TIMESTAMP WITH TIME ZONE,
    COL3  TIMESTAMP WITH LOCAL TIME ZONE);
    
    INSERT INTO TEMP06
    VALUES (SYSDATE, SYSDATE, SYSDATE);
    SELECT * FROM TEMP06;
    
4.기타자료형
 - 이진자료를 처리하기 위한자료형
 - RAW,BLOB,BFILE,LONG RAW 등이 지원됨 
 1)RAW
 . 인덱스 처리가 가능한 2진자료(작은규모: 2000BYTE)
 . DB에서 해석 및 변환 작업을 수행하지 않음
 . 16진수와 2지수만 저장가능
 . 사진, 음성 등 데이터 저장
 (사용형식)
 컬럼명 RAW(크기)
 (사용예시)
 CREATE TABLE TEMP07(
 COL1 RAW(100),
 COL2 RAW(200));
 
 INSERT INTO TEMP07
 VALUES('1100111',HEXTORAW('EF'));
 
  2)BFILE
  . 2진자료 저장
  . 대상의 자료는 DB외부에 따로 저장
  . DB 내에는 경로 정보(DIRECTORY 객체)만 보관
  . 4GB까지 처리 가능
  
  **디렉토리 객체 생성
    CREATE DIRECTORY 디렉토리별칭 AS 경로명;
    - '디렉토리별칭'은 30 BYTE 까지 허용
    - '경로명' : 원본자료가 있는 경로명
    
    CREATE DIRECTORY  TEST_DIR AS 'D:\A_TeachingMaterial\2.Oracle';
    CREATE TABLE TEMP08(
    COL1 BFILE);
    INSERT INTO TEMP08 
    VALUES(BFILENAME('TEST_DIR','WINTER1.jpg'));
  SELECT * FROM TEMP08;
  
  
  3)BLOB
   . 2진자료 저장
  . 대상의 자료는 DB내부에 따로 저장
  . 4GB까지 처리 가능
  (사용형식)
  컬럼명 BLOB
  
  (사용예)
  CREATE TABLE TEMP09(
  COL1 BLOB);
  **직접 INSERT문에 의하여 삽입 불가능
    익명블록 사용
    
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
  
  