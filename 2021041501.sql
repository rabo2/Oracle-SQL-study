2021-0415-01
UPDATE 문-----------UPDATE, SET, WHERE
-테이블에 저장 자료(ROW)를 수정할 때 사용
(사용형식)
UPDATE 테이블명 
    SET 컬럼명 = 값...
    WHERE 조건
    
사용예)
회원테이블에서 회원번호 'c100'회원의 주민번호와 생년월일을 다음과 같이 변경하시오
주민번호 : 010124-3400716
생년월일 : 2001/01/24

UPDATE MEMBER
    SET MEM_REGNO1 = '970523',
        MEM_REGNO2 = '2407564',
        MEM_BIR = TO_DATE('19970523')
        WHERE
        MEM_ID = 'c001'
        ;

UPDATE MEMBER
    SET MEM_REGNO1 = '100819',
        MEM_REGNO2 = '4459927',
        MEM_BIR = TO_DATE('20100819')
        WHERE
        MEM_ID = 'c001';
        COMMIT;
        

SELECT MEM_ID,MEM_REGNO1,MEM_REGNO2,MEM_BIR FROM MEMBER WHERE MEM_ID = 'c001';
