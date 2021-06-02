2021-0414-01)
1. INSERT 
 - 테이블에 자료를 삽입할 경우 사용
 
 (사용형식)
 INSERT INTO 테이블명(컬럼명1..)
    VALUES(값1, 값2..);
    - '(컬럼명1,....)'이 생략되면 모든 컬럼에 정의된 순서대로 VALUES 절에 값을 정의해야한다.
    - '(컬러명1,....)'이 기술되면 각 컬럼에 저장될 값만 VALUES 절에 기술
    - 컬럼의 제약사항 중 NOT NULL 로 설정된 컬럼은 생략할 수 없다(=NOT NULL 의 column반드시 VALUES값을 작성해야한다.)
    
    
 EX)
 -------------------------------------------------------------------------
 사원번호   사원명              주소            전화번호        직위      부서
 -------------------------------------------------------------------------
 S100      홍일동      대전시 중구 중앙로 76  042-222-8202     사원      개발부  
 S201      강감찬      청주시 상당구 문의면                     부장     영업부
 S300      이순신      서울시 성북구 장위동   010-2345-6789     팀장     개발부 
 --------------------------------------------------------------------------
 
 INSERT INTO EMP
    VALUES ('S100','홍일동','대전시 중구 중앙로 76', '042-222-8202', '사원', '개발부');
    
SELECT * FROM EMP;

 INSERT INTO EMP (EMP_ID, EMP_NAME, ADDR, POSTION_NAME, DEARTMNT_NAME)
    VALUES ('S201','강감찬','청주시 상당구 문의면', '부장', '영업부'); 
    
 INSERT INTO EMP (EMP_ID, EMP_NAME, ADDR, TEL_NO, POSTION_NAME, DEARTMNT_NAME)
    VALUES ('S300','이순신','서울시 성북구 장위동','010-2345-6789','팀장','개발부');
 SELECT * FROM EMP;

문제1] 다음자료를 공사현장(WORKPLACE)테이블에 저장하시오

SELECT * FROM WORKPLACE;
------------------------------------------------------------------------------------------------------------
공사장번호   공사자명      주소               공사금액       투입인원        시작일자        예상완공일     비고
------------------------------------------------------------------------------------------------------------
W100       학교신축    대전시 대덕구 법동   1,200,000,000    1000        2021.04.14      2021/12/20    공사중
W101       아파트신축  대전시 유성구         300,000,000     400         2021.02.10      2022/01/17    공사중
W200       도로개설     강원도 삼척시       
-------------------------------------------------------------------------------------------------------------
INSERT INTO WORKPLACE (WP_ID, WP_NAME, ADDR, WP_AMT, MAN_AMT, STAT_DATE,COMPLETE_DATA,REMARKS)
VALUES ('W100', '학교신축', '대전시 대덕구 법동', '1200000000', '1000','2021/04/14','2021/12/20','공사중');
INSERT INTO WORKPLACE (WP_ID, WP_NAME, ADDR, WP_AMT, MAN_AMT, STAT_DATE,COMPLETE_DATA,REMARKS)
VALUES ('W101', '아파트신축', '대전시 유성구', '300000000', '400','2021.02.10','2022/01/17','공사중');
INSERT INTO WORKPLACE (WP_ID, WP_NAME, ADDR)
VALUES ('W200', '도로개설', '강원도 삼척시');



SELECT * FROM WORKPLACE;


**ALTER 명령
 -테이블을 변경(테이블의 이름, 컬럼의 명, 컬럼의 데이터 타입, 컬럼의 크기나 제약사항(기본키 변경,생성,삭제) 등)하는 경우

(1) 테이블 이름 변경
ALTER TABLE 구테이블명
    RENAME TO 신테이블명;
예) EMP테이블을 EMPT테이블로
ALTER TABLE EMP RENAME TO EMPT;

(2) 테이블의 컬럼 추가
ALTER TABLE 테이블명 
ADD (컬럼명 데이터타입 (크기) NOT NULL 제약조건);
예) 사원테이블(EMPT)에 관리사원(MANAGER_ID) 사원번호 컬럼을 추가하시오
ALTER TABLE EMPT ADD(MANAGER_ID CHAR(4));

(3) 테이블의 제약사항 추가
ALTER TABLE 테이블명
ADD(CONSTRAINT 기본키 설정명 PRIMARY KEY (컬러명));

(4) 테이블의 컬럼명 변경
ALTER TABLE 테이블명
RENAME COLUMN 구컬럼명 TO 신컬럼명;
예) 사원테이블(EMPT)에서 ADDR컬럼명을 EMP_ADDR로 변경하여라
ALTER TABLE EMPT RENAME COLUMN ADDR TO EMP_ADDR;

(5) 테이블의 데이터 타입 및 크기 변경
ALTER TABLE 테이블명
MODIFY (컬럼명 데이터타입(크기) NOT NULL);
 예) ALTER TABLE EMPT MODIFY (TEL_NO CHAR(20));

(6) 테이블의 컬럼 삭제
ALTER TABLE 테이블명
    SET UNUSED | DROP COLUMN 컬럼명;
    'SET UNUSED' : 사용하지 않음으로 설정한다. 후에, 삭제가능. 되돌리 수 없음.
    'DROP COLUMN' : 해당 컬럼 삭제
    
ALTER TABLE EMPT
DROP COLUMN MANAGER_ID;

(7) 테이블의 제약사항 삭제
ALTER TABLE 테이블명
DROP 제약종류명(INDEX, CONSTRAINT 등) 제약명;



2. DELETE 문
    -테이블 내에 저장된 자료 삭제
    -ROLLBACK 의 대상
    (사용형식)
    DELETE 테이블명 [WHERE 조건];
    
    '[HWERE 조건]'이 생략 되면 테이블에 있는 자료 삭제
    BUT ROLLBACK 가능
SELECT*FROM EMP;


DELETE EMP
 WHERE EMP_ID= 'S100';

ROLLBACK;


사용예) WROK TABLE에 다음자료를 입력하시오
-----------------------------------
사원번호    사업장번호   투입일자    
-----------------------------------
S100        W100        오늘
S100        W101        한달 후
S201        W200        15일 전
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






    

