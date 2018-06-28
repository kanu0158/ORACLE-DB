--GROUP BY
-- ���� 4�� �������̺� 20��(��������)
-- �� ������ ����ID�� �Ӽ����� ����

--UPDATE TEAMW SET MEM_NAME = '����' WHERE MEM_NAME LIKE '�¿�';
--DROP TABLE TEAMZ;
CREATE TABLE TEAMZ(
    TEAM_ID VARCHAR2(20) PRIMARY KEY,
    TEAM_NAME VARCHAR2(20)
);
CREATE TABLE TEAMW(
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    TEAM_ID VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    MEM_AGE DECIMAL,
    ROLL VARCHAR2(20) --����, ����
);
ALTER TABLE TEAMW ADD CONSTRAINT teamw_fk_team_id FOREIGN KEY (TEAM_ID) REFERENCES TEAMZ(TEAM_ID);

INSERT INTO TEAMZ(
    TEAM_ID, TEAM_NAME
)
VALUES(
    'ATEAM','����Ƽ��'
);
INSERT INTO TEAMZ(
    TEAM_ID, TEAM_NAME
)
VALUES(
    'HTEAM','��ī��'
);
INSERT INTO TEAMZ(
    TEAM_ID, TEAM_NAME
)
VALUES(
    'CTEAM','������'
);
INSERT INTO TEAMZ(
    TEAM_ID, TEAM_NAME
)
VALUES(
    'STEAM','�����'
);

INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '����Ƽ��1', 'ATEAM', '����', 34, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '����Ƽ��2', 'ATEAM', '����', 35, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '����Ƽ��3', 'ATEAM', '����', 21, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '����Ƽ��4', 'ATEAM', '����', 29, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '����Ƽ��5', 'ATEAM', '����', 25, '����'
);

INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '��ī��1', 'HTEAM', '����', 26, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '��ī��2', 'HTEAM', '����', 26, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '��ī��3', 'HTEAM', '��', 27, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '��ī��4', 'HTEAM', '���', 30, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '��ī��5', 'HTEAM', '�ܾ�', 26, '����'
);

INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '������1', 'CTEAM', '������', 32, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '������2', 'CTEAM', '��ȣ', 31, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '������3', 'CTEAM', '����', 29, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '������4', 'CTEAM', '����', 23, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '������5', 'CTEAM', '����', 30, '����'
);

INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '�����1', 'STEAM', '��ȣ', 27, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '�����2', 'STEAM', '����', 26, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '�����3', 'STEAM', '�̽�', 29, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '�����4', 'STEAM', '����', 26, '����'
);
INSERT INTO TEAMW(
    MEM_ID, TEAM_ID, MEM_NAME, MEM_AGE, ROLL
)
VALUES(
    '�����5', 'STEAM', '����', 30, '����'
);

SELECT * FROM TEAMZ;
SELECT * FROM TEAMW;
DESC TEAMZ;
DESC TEAMW;

--COUNT() ������
--SUM() ���� ������
--MAX() ���� ���� �ִ�ġ
--MIN() ���� �����ּ�ġ
--AVG() ���� �������
SELECT
    (SELECT MEM_NAME
     FROM TEAMW
     WHERE TEAM_ID LIKE TW.TEAM_ID
        AND ROLL LIKE '����') ����,
    (SELECT TEAM_NAME
     FROM TEAMZ
     WHERE TEAM_ID LIKE TW.TEAM_ID) ����,     
     COUNT(*) �ο���,
     SUM(TW.MEM_AGE) �����հ�,
     MAX(TW.MEM_AGE) �ִ볪��,
     MIN(TW.MEM_AGE) �ּҳ���,
     AVG(TW.MEM_AGE) ��ճ���
FROM TEAMW TW
GROUP BY
    TW.TEAM_ID
ORDER BY
    TW.TEAM_ID
;

-- �׷����� ������ ó���ϴ� ����
SELECT 
     (SELECT TEAM_NAME
      FROM TEAMZ
      WHERE TEAM_ID LIKE TW.TEAM_ID) ����,     
     COUNT(*) �ο���,
     SUM(TW.MEM_AGE) �����հ�,
     MAX(TW.MEM_AGE) �ִ볪��,
     MIN(TW.MEM_AGE) �ּҳ���,
     AVG(TW.MEM_AGE) ��ճ���
FROM TEAMW TW
--    JOIN TEAMZ TZ
--        ON TW.TEAM_ID LIKE TZ.TEAM_ID
GROUP BY
    --TZ.TEAM_ID
    TW.TEAM_ID
HAVING  -- �׷���̰� ������ ���������ʴ´�.
    AVG(TW.MEM_AGE) >= 28
ORDER BY
    TW.TEAM_ID
;
-- CASE�� ���
SELECT
    Z.TEAM_ID ��ID,
    Z.TEAM_NAME ����,
    W.MEM_ID ID,
    W.MEM_NAME �̸�,
    W.MEM_AGE ����,
    W.ROLL ����
FROM TEAMW W
    JOIN TEAMZ Z
        ON W.TEAM_ID LIKE Z.TEAM_ID
;

-- UPDATE�� ���̽� ���
UPDATE TEAMW
SET ROLL = CASE
                WHEN TEAMW.MEM_NAME IN('����','����','������','��ȣ') THEN '����'
                ELSE '����' 
           END
WHERE ROLL IS NOT NULL
;


SELECT
    CASE
        WHEN TEAMW.MEM_NAME LIKE '��ȣ' THEN '��ĭŸ'
        WHEN TEAMW.MEM_NAME IS NOT NULL THEN '����ũ'
        ELSE TEAMW.MEM_NAME
    END ������
FROM
    TEAMW
;


ALTER TABLE TEAMW DROP COLUMN ROLL;
ALTER TABLE TEAMW ADD(ROLL VARCHAR2(20));