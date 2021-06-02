2021-0415-02)
SELECT 문
- 테이블에 저장된 자료를 조회하는 명령어
사용형식)
SELECT *|[[DISTINCT]컬럼명1 [AS ["]별칭["},]
                    컬럼명2 [AS ["]별칭["},]
                             :
                    컬럼명N [AS ["]별칭["],]]
    FROM 테이블명
    [WHERE 조건]
    [GROUP BY 컬럼명 [,컬럼명,...]]
    [HAVING 조건]
    [ORDER BY 컬럼명|컬럼인덱스 [ASC|DESC]][,컬럼명|컬럼인덱스 [ASC|DESC]]
    
    - SELECT (COLUMN 에 관련된 내용) FROM 테이블 명 WHERE(ROW 에 관련된 내용)
    -'*' (=ALL) 모든 컬럼을 조회함 
    - 실행순서 : FROM 절 -> WHERE절 -> SELECT절
    - 컬럼별칭에 특수문자(공백 등)을 사용할 때는 ""로 묶어서 사용함
    - DISTINCT(=중복 행 제외함)
    - 별칭은 COLUMN에 또 다른 이름을 부여/별칭에 특수문자가 들어가능 경우 반드시 ""로 묶어야함
    - 단, 예악어(KEY)와 똑같은 단어를 사용하면 안됨
    - 테이블 명이 필요 없는 계산, 날짜 기능의 SELECT을 사용할때는 FROM 뒤에 
      Dummy 테이블인 DUAL을 사용한다.
    - SUM, AVG, COUNT, MIN, MAX(집계함수)의 경우에는 FROM이 아닌 HAVING 을 사용함
    - GROUP BY : 특정조건으로 묶을 때 사용
    - ORDER BY : 크기 순 정렬 ASC(=오름차순) DESC(=내림차순) 생략시 DEFAULT는 ASC
    - ORACLE은 1부터 센다. 
    
 EX) 분류테이블 (LPROD)의 모든 자료 조회
SELECT * 
    FROM LPROD;
    
회원테이블에서 여성회원을 조회회서 회원번호, 이름, 나이, 주소를 조회하시오
SELECT  MEM_ID AS 회원번호,
        MEM_NAME AS 이름, 
        EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS 나이,--EXTRACT 추출 
        MEM_ADD1||' '||MEM_ADD2 AS 주소 ----||' '|| 2개의 COLUMN을 결합
    FROM MEMBER
    WHERE SUBSTR(MEM_REGNO2,1,1)='2' OR SUBSTR(MEM_REGNO2,1,1)='4' ;
    
회원테이블에서 50세 이상 회원을 조회회서 회원번호, 이름, 나이, 주소를 조회하시오
SELECT  MEM_ID AS 회원번호,
        MEM_NAME AS 이름, 
        EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS 나이, 
        MEM_ADD1||' '||MEM_ADD2 AS 주소
    FROM MEMBER
    WHERE EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) >=50
    ; -------AS 별칭은 FROM 이나 WHERE 절에서 정의 할수 없음
      --실행 순서가 FROM -> WHERE -> SELECT 절이기 때문이기 때문에 별칭 사용에 주의한다.
      

2. 데이터 타입
 - 문자열, 숫자, 날짜, 기타(2진자료 <그림, 동영상>)로 구분
 1)문자열 자료
    - 고정길이 문자열과 가변길이 문자열로 구분 
    - CHAR, VARCHAR, VARCHAR2(오라클에만 존재), LONG, 
      CLOB(LARGE OBJECT), (NATIONAL=)NVARCHAR2, NCLOB 등이 제공
    (1)CHAR
        . 고정길이 문자열 자료 저장
        . 최대 2000BYTE 까지 저장가능
        . 왼쪽부터 저장되고 남은 기억공간은 공백처리
        (사용형식)
        컬럼명 CHAR(크기[BYTE|CHAR]);
        . '크기'는 확보되는 기억공간
        . BYTE|CHAR : 기본값은 BYTE이고 '크기'가 BYTE 인지 또는 CHAR 인지 결정
            DEFAULT 는 BYTE
            단, CHAR 로 설정되도 2000BYTE는 초과 할 수 없다
        . 한글 한 글자는 3 BYTE
        EX) COL1 CHAR(2000 CHAR) => 한글 몇글자 저장? 666개
        . 자료가 DATA 초과시 ERROR, 부족하면 왼쪽부터 채워나간다
        . 기본키는 대부분 같은 길이를 가지기 때문에 기본키 DATA TYPE에 사용하기 좋음
        
    
    사용예)
CREATE TABLE TEMP01(
COL1 CHAR(10),
COL2 CHAR(10 CHAR),
COL3 CHAR(10 BYTE));
   
INSERT INTO TEMP01
VALUES ('BOYHOOD','보이후드','보이후');
SELECT *FROM TEMP01;

SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3)
FROM TEMP01;

    (2)VARCHAR2
        . 가변길이 문자열 저장 -문자열의 길이만큼만 사용하고 남은 공간은 시스템에 반환
        . 4000BYTE 까지 저장가능/ 한글은 1333글자까지
        (사용형식)
        컬럼명 VARCHAR2(크기 [BYTE|CHAR])
        
사용예)
CREATE TABLE TEMP02(
 COL1 VARCHAR2(200),
 COL2 VARCHAR2(200 CHAR),
 COL3 VARCHAR2(200 BYTE));
 
 INSERT INTO TEMP02 
 VALUES ('ILPOSTINO','일포스티노','ABCDEFGHIJK');
        
SELECT *FROM TEMP02;
SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3)
FROM TEMP02;

사용예) HR계정의 사원테이블에서 FIRST_NAME 컬럼DMF CHAR(50)DMFH 변경하시오

ALTER TABLE HR.EMPLOYEES
    MODIFY (FIRST_NAME CHAR(50));

 (3)LONG
 - 가변길이 문자열 저장
 - 2gb까지 저장가능
 - 한 테이블에 한 컬러만 사용가능
 - CLOB 타입으로 대체
 (사용형식)
 컬럼명 LONG;
 . SELECT 문의 SELECT절, UPDATE문의 SET절, INSERT문의 VALUES절에서 사용가능
 . 더이상 기능 개선 서비스가 제공되지 않음

CREATE TABLE TEMP03(
    COL1 VARCHAR2(4000),
    COL2 LONG;
    
    
 (4) CLOB
  - Character Large Objects
  - 대용량 가변길이 문자열 자료 저장(4GB = 2^30 BYTE)
  - 한 테이블에 복수개의 clob선언가능
  - 일부 기능은 lob api 지원을 받아야 함
  - 용량이 크기때문에 일부 명령어(함수)들이 사용이 불가능하여 특수함수들을 사용해여한다.
  (사용형식)
  컬럼명 clob;
  
  CREATE TABLE TEMP04(
    COL1 CLOB,
    COL2 CLOB,
    COL3 VARCHAR2(4000));
    INSERT INTO TEMP04
    VALUES ('대전시 중구 대흥동 500 영민빌딩','대한민국은 민주공화국이다','SFDJIQJLLF');
  SELECT LENGTH(COL1),LENGTH(COL2) FROM TEMP04;
  
  SELECT SUBSTR(COL1, 2,4) FROM TEMP04; --COL 1 에서 2번째부터 4글자를 읽는다.
  SELECT DBMS_LOB.SUBSTR(COL1,2,4) FROM TEMP04; --COL 1에서 4번째부터 2글자를 읽는다.
  
  (5)NCLOB, NVARCHAR2
  - 자료를 국제표준코드(UTF-8, UTF-16)를 사용하여 저장
  - 나머지 기능은 동일
  (사용형식)
  