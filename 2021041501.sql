2021-0415-01
UPDATE ��-----------UPDATE, SET, WHERE
-���̺� ���� �ڷ�(ROW)�� ������ �� ���
(�������)
UPDATE ���̺�� 
    SET �÷��� = ��...
    WHERE ����
    
��뿹)
ȸ�����̺��� ȸ����ȣ 'c100'ȸ���� �ֹι�ȣ�� ��������� ������ ���� �����Ͻÿ�
�ֹι�ȣ : 010124-3400716
������� : 2001/01/24

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
