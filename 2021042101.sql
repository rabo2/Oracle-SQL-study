2021-0421-01

SELECT  ABS(-10.77), ABS(29), ABS(0) FROM DUAL;
SELECT  SIGN(-2000), SIGN(0.0006) FROM DUAL;
SELECT  POWER(2,10), POWER(10,7) FROM DUAL;
SELECT  SQRT(16), SQRT(9.9) FROM DUAL;


SELECT CEIL(10.2), CEIL(-10.2) FROM DUAL;
SELECT FLOOR(10.2), FLOOR(-10.2) FROM DUAL;


SELECT  EMPLOYEE_ID AS 사원번호, 
        EMP_NAME AS 사원명, 
        SALARY - ROUND(SALARY/13,1) AS 연봉, 
        ROUND((SALARY - ROUND(SALARY/13,1))/12,1) AS 월지급액
  FROM  HR.EMPLOYEES
;
 
 
SELECT  EMPLOYEE_ID AS 사원번호, 
        EMP_NAME AS 사원명, 
        SALARY AS 급여, 
        TRUNC((SALARY*0.03),-1) AS 각근세, 
        ROUND((SALARY-(SALARY*0.03)),-1) AS 지급액
  FROM  EMPLOYEES
;

MOD(10,3) = 10 -3*FLOOR(10/3)
          = 10 -3*FLOOR(3.333..)
          = 10 -3*3 => 1
          
REMAINDER(10,3) = 10 -3*ROUND(10/3)
                = 10 -3*ROUND(0.333...)
                = 10 -3*3 => 1
                
MOD(18,7) = 18 -7*FLOOR(18/7)
          = 18 -7*FLOOR(2.57..)
          = 18 -7*2  => 4
          
REMAINDER(18,7) = 18-7*ROUND(18/7)
                = 18 -7*ROUND(18/7)
                = 18 -7*3 => -3
                
                
ACCEPT P_YEAR PROMPT '년도 입력(4자리) : ' --ACCEPT : 사용자 입력값 
DECLARE                                     --P_(parameter , 매개변수
  V_YEAR NUMBER(4) :='&P_YEAR'; -- ':==' 초기화(==) ,&(참조)
  V_RES VARCHAR2(50);
BEGIN --BEGIN 이후에 로직이 들어옴
  IF(MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR --
    (MOD(V_YEAR,400)=0) THEN  -- THEN..END IF;(= {} 실행부분)
                              -- & 반복문은  THEN...END LOOP;
     V_RES:=V_YEAR||'는 윤년입니다.';
ELSE 
     V_RES:=V_YEAR||'는 평년입니다.';
END IF;

-- 보기 -> DBMS 출력
DBMS_OUTPUT.PUT_LINE(V_RES);
END;


SELECT  MEM_ID AS 회원번호, 
        MEM_NAME AS 회원명, 
        MEM_MILEAGE AS 마일리지, 
  --    5-WIDTH_BUCKET(MEM_MILEAGE,1000,9000,4)||'등급'
        WIDTH_BUCKET(MEM_MILEAGE,9000,500,4)||'등급'        
        AS 등급
  FROM  MEMBER
;


SELECT  GREATEST('홍길동','강감찬','홍길순'), 
        --알파벳 혹은 한글의 순서가 뒤에 있을 수록 큰 것으로 취급
        LEAST(70,5,24) FROM DUAL;
 
 
SELECT  EMPLOYEE_ID AS 사원번호, 
        EMP_NAME AS 사원명, 
        SALARY AS 급여, 
        GREATEST(SALARY, 2500) AS 조정급여 -- SALARY 와 2500을 비교해서 값을 반환
  FROM  HR.EMPLOYEES
ORDER BY 3
 ;
 