2021-0428-01
--GROUPBY ���� �ð��� ���� �� ��� �÷��� ������ �Ǵ� ����� �����ϰ�
--ROLLUP



SELECT  PROD_LGU AS �����ڵ�, 
        PROD_BUYER AS �ŷ�ó�ڵ�, 
        COUNT(*) AS "��ǰ�� ��"
 FROM   PROD
GROUP BY PROD_LGU, PROD_BUYER
ORDER BY 1
;

SELECT  PROD_LGU AS �����ڵ�, 
        PROD_BUYER AS �ŷ�ó�ڵ�, 
        COUNT(*) AS "��ǰ�� ��"
 FROM   PROD
GROUP BY ROLLUP(PROD_LGU, PROD_BUYER)
ORDER BY 1
;

SELECT  PROD_LGU AS �����ڵ�, 
        PROD_BUYER AS �ŷ�ó�ڵ�, 
        COUNT(*) AS "��ǰ�� ��"
 FROM   PROD
GROUP BY CUBE(PROD_LGU, PROD_BUYER)
ORDER BY 1
;