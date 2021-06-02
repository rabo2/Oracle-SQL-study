2021 - 0514 - 01);

create or replace procedure proc_prod02(
 p_pid  in  prod.prod_id%type;
 p_name out varchar2)
is
begin
 select prod_name
   into p_name
   from prod 
  where prod_id = p_pid;
end;

declare
 v_name:=prod.prod_name%type;
 cursor cur_prod02
  is
     select prod_id
       from prod
      order by 1;
begin
 for r1 in cur_prod02 loop
   proc_prod02(r1.prod_id,v_name);
   dbms_output.put_line(r1.prod_id ||'=>'||v_name);
 end loop;
end;




(함수)
CREATE OR REPLACE FUNCTION FN_PROD01(
  PID IN PROD.PROD_ID%TYPE)
  --이름에 넣어서 반환해주기때문에 out이 필요없다.
  RETURN PROD.PROD_NAME%TYPE 
IS
  V_NAME PROD.PROD_NAME%TYPE; 
  --잠시머무는 공간 반환되어지는 값은 하나! 두개이상반환은 불가능하다.
  --문자열로 받아서 하나로 반환하면 2개이상사용가능..
BEGIN
  SELECT PROD_NAME INTO V_NAME
    FROM PROD
   WHERE PROD_ID=PID;
 
   RETURN V_NAME; 
   --반환해야하기때문에 반환해줄 변수가 필요해서 V_NAME을 해준것이다.
END;

select prod_id||'=>'||fn_prod01(prod_id)
  from prod;


2005년 7월 장바구니 테이블에서 판매된 상품코드, 상품명, 수량을 날짜순으로
출력하시오

select cart_prod,fn_prod01(cart_prod),cart_qty
  from cart
 where cart_no like '200507%'
 order by substr(cart_no,1,8);
 
 
년도와 월을 입력받아 그 기간에 상품을 가장 많이 구매한(금액기준) 회원명과
구매 금액을 함수를 이용하여 조회하시오.

create or replace function fn_crt03(
 p_period char)
 return varchar2
is
 v_name member.mem_name%type;
 v_sum number:=0;
 v_res varchar2(100);
 v_period char(7):=p_period||'%';
begin
 select b.mem_name, a.csum into v_name,v_sum
   from (select cart_member as cid,
                sum(cart_qty*prod_price) as csum
           from cart,prod
          where cart_prod = prod_id
            and cart_no like v_period
            group by cart_member
            order by 2) a, member b
  where rownum = 1
    and a.cid = b.mem_id;
    
 v_res:='회원명 : '||v_name||', 구매액 : '||v_sum;
 return v_res;
end;
 
select fn_crt03('200505') from dual;





년도와 월(2005년 5월)을 입력받아 입고 수량과 출고수량을 계산하여
재고수불테이블을 update하는 함수를 작성하시오.
update 후 처리 건수를 출력하시오
--(함수)
CREATE OR REPLACE FUNCTION FN_BUYPROD01(
    PDATE IN CHAR,
    PID IN PROD.PROD_ID%TYPE)
    RETURN NUMBER
IS
  V_AMT NUMBER:=0;
  V_SDATE DATE:=TO_DATE(PDATE||'01');
  V_EDATE DATE:=LAST_DAY(TO_DATE(PDATE||'01'));
BEGIN
  SELECT SUM(BUY_QTY) INTO V_AMT
    FROM BUYPROD
   WHERE BUY_PROD=PID
     AND BUY_DATE BETWEEN V_SDATE AND V_EDATE;
 RETURN V_AMT;
END;

--(실행)
DECLARE
 CURSOR CUR_BUYPROD3
IS
 SELECT DISTINCT BUY_PROD
   FROM BUYPROD
  WHERE BUY_DATE BETWEEN '20050501' AND '20050531';
BEGIN
 FOR R1 IN CUR_BUYPROD3 LOOP
   UPDATE REMAIN
      SET REMAIN_I = REMAIN_I+FN_BUYPROD01('200505',R1.BUY_PROD),
          REMAIN_J_99 = REMAIN_J_99+FN_BUYPROD01('200505',R1.BUY_PROD),
          REMAIN_DATE = '20050531'
    WHERE PROD_ID=R1.BUY_PROD
      AND REMAIN_YEAR='2005';
 END LOOP;
END;



SELECT * FROM REMAIN;


년도와 월(2005년 5월)을 입력받아 입고 수량과 출고수량을 계산하여
재고수불테이블을 update하는 프로시져를 작성하시오.


