2021-0506-02

SELECT*FROM REMAIN;

INSERT INTO remain (remain_year,prod_id
    SELECT  '2005', PROD_ID
    FROM    PROD;
    

UPDATE REMAIN A
   SET (REMAIN_J_00, REMAIN_I, REMAIN_O, REMAIN_J_99,REMAIN_DATE) =
       (SELECT  PROD_PROPERSTOCK,0,0,PROD_PROPERSTOCK,
                TO_DATE('20050103')
        FROM    PROD B
        WHERE   B.PROD_ID = A.PROD_ID
                AND A.REMAIN_YEAR = '2005')
                
                
UPDATE REMAIN A
   SET (REMAIN_I, REMAIN_J_99, REMAIN_DATE) =
       (SELECT  B.CAMT+A.REMAIN_I, 
                A.REMAIN_J_99+B.CAMT, 
                '20050331'
        FROM    (SELECT  BUY_PROD BID,
                    SUM(BUY_QTY) CAMT
                 FROM    BUYPROD
                 WHERE   BUY_DATE BETWEEN '20050101' AND '20050331'
                 GROUP BY BUY_PROD) B            
        WHERE   A.PROD_ID = B.BID)
 WHERE  REMAIN_YEAR = '2005';
        
SELECT * FROM REMAIN;
COMMIT;
ORACLE_SQL2_김민석.TXT
camillo0210@gmail.com
2005년 4월 매입매출자료를 이용하여 재고수불테이블을 갱신하시오
REMAIN_DATE는 갱신된자료만 '20050430'일로 변경


UPDATE REMAIN A
   SET (REMAIN_I,REMAIN_O,REMAIN_J_99,REMAIN_DATE) =    
        (SELECT  A.REMAIN_I+C.CSBQ,
                 C.CSCQ,
                 A.REMAIN_J_00 + REMAIN_I - C.CSCQ + C.CSBQ
                 ,CASE WHEN REMAIN_I = 0 and REMAIN_O = 0 THEN remain_date
                 ELSE to_date('20050430')END
           FROM  (SELECT  A.PROD_ID CID,
                          NVL(B.SBQ,0) CSBQ,
                          NVL(F.FCQ,0) CSCQ
                    FROM  PROD A,
                          (SELECT  BUY_PROD BID,
                                   SUM(BUY_QTY) SBQ
                           FROM    BUYPROD
                           WHERE   BUY_DATE BETWEEN '20050401' AND '20050430'
                           GROUP BY BUY_PROD) B,
                           (SELECT  D.PROD_ID FID,
                                    NVL(E.SCQ,0) FCQ
                            FROM    PROD D,
                                    (SELECT  CART_PROD CID,
                                            SUM(CART_QTY) SCQ
                                    FROM    CART
                                    WHERE   CART_NO LIKE '200504%'
                                    GROUP BY CART_PROD) E
                            WHERE   D.PROD_ID = E.CID(+)) F
                    WHERE   A.PROD_ID = B.BID(+)
                            AND A.PROD_ID = F.FID(+)) C
          WHERE  A.PROD_ID =C.CID)
WHERE   REMAIN_YEAR = '2005'
;
        
        select * from remain;
        rollback;
        
SELECT  A.PROD_ID,
        NVL(B.SBQ,0)
FROM    PROD A,
        (SELECT  BUY_PROD BID,
                SUM(BUY_QTY) SBQ
        FROM    BUYPROD
        WHERE   BUY_DATE BETWEEN '20050401' AND '20050430'
        GROUP BY BUY_PROD) B
WHERE   A.PROD_ID = B.BID(+);

(SELECT  D.PROD_ID,
        NVL(E.SCQ,0)
FROM    PROD D,
        (SELECT  CART_PROD CID,
                SUM(CART_QTY) SCQ
        FROM    CART
        WHERE   CART_NO LIKE '200504%'
        GROUP BY CART_PROD) E
WHERE   D.PROD_ID = E.CID(+));


ROLLBACK;

SELECT * FROM REMAIN;

UPDATE REMAIN A
   SET (REMAIN_I,REMAIN_O,REMAIN_J_99,REMAIN_DATE) =    
        (SELECT  A.REMAIN_I+C.CSBQ,
                 C.CSCQ,
                 A.REMAIN_J_00 + REMAIN_I - C.CSCQ + C.CSBQ
                 ,CASE WHEN c.csbq = 0 and c.cscq = 0 THEN remain_date
                 ELSE to_date('20050430') END
           FROM  (SELECT  A.PROD_ID CID,
                          NVL(B.SBQ,0) CSBQ,
                          NVL(F.FCQ,0) CSCQ
                    FROM  PROD A,
                          (SELECT  BUY_PROD BID,
                                   SUM(BUY_QTY) SBQ
                           FROM    BUYPROD
                           WHERE   BUY_DATE BETWEEN '20050401' AND '20050430'
                           GROUP BY BUY_PROD) B,
                           (SELECT  D.PROD_ID FID,
                                    NVL(E.SCQ,0) FCQ
                            FROM    PROD D,
                                    (SELECT  CART_PROD CID,
                                            SUM(CART_QTY) SCQ
                                    FROM    CART
                                    WHERE   CART_NO LIKE '200504%'
                                    GROUP BY CART_PROD) E
                            WHERE   D.PROD_ID = E.CID(+)) F
                    WHERE   A.PROD_ID = B.BID(+)
                            AND A.PROD_ID = F.FID(+)) C
          WHERE  A.PROD_ID =C.CID)
WHERE   REMAIN_YEAR = '2005'
;

