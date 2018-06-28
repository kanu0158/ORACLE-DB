select * from team;
select count(*) AS "���̺��� ��" from tab;
select count(*) ���̺��Ǽ� from tab; -- �÷��� ���̾ƽ�

select team_name as "��ü �౸�� ���" from team;
select team_name "��ü �౸�� ���" from team order by team_name; -- ��������
select team_name as "��ü �౸�� ���" from team order by team_name desc; -- ��������

select distinct position as "������" from player;
select 
    distinct nvl2(position,position,'����') "������" 
from player; -- nvl2(a,'b','c') a�� null�̸� c, null�ƴϸ� b

select player_name �̸�
from player
where team_id like 'K02'
    and position like 'GK'
order by player_name
;


select position ������, player_name �̸�
from player
where team_id like 'K02'
    and height >= 170
    and substr(player_name,1,1) like '��'
;

select substr(player_name,1,2) �׽�Ʈ��
from player
;
select position ������, player_name �̸�
from player
where team_id like 'K02'
    and height >= 170
    and player_name like '��__'
;

select player_name �̸�,
     to_char(nvl2(height,height,0)) || 'cm' Ű,
     to_char(nvl2(weight,weight,0)) || 'kg' ����
from player
where team_id like 'K02'
order by height desc
;
select player_name || '����' �̸�,
     nvl2(height,height,0) || 'cm' Ű,
     nvl2(weight,weight,0) || 'kg' ����
from player
where team_id like 'K02'
order by height desc
;

select player_name || '����' �̸�,
     nvl2(height,height,0) || 'cm' Ű,
     nvl2(weight,weight,0) || 'kg' ����,
     ROUND(weight/(POWER(height,2)/10000),2) BMI
from player
where team_id like 'K02'
order by height desc
;

select player_name || '����' �̸�, p.team_id ���Ƶ�
from player p, team t
where p.team_id = t.team_id 
    AND p.team_id IN('K10','K02') 
    AND p.position like 'MF'
    AND player_name like '��%'
order by team_name
;
select p.player_name || '����' �̸�, t.team_id
from player p
inner join team t
on p.team_id = t.team_id
where p.team_id in('K10','K02')
    and p.position like 'MF'
    and p.player_name like '��%'
order by t.team_name
;

select player_name || '����' �̸�, team_id �Ƶ�
from player
where player_name like '��%'
;


select team_name, position, player_name, nation, t.team_id,p.team_id 
from team t, player p
where p.team_id = t.team_id
    and p.team_id IN('K02','K10')
    and p.position like 'GK'
order by t.team_name, p.player_name
;
select team_name, position, player_name, nation, t.team_id,p.team_id 
from player p
inner join team t 
on p.team_id like t.team_id
where t.team_id IN('K02','K10')
    and p.position like 'GK'
order by t.team_name, p.player_name
;


select height || 'cm' Ű, team_name ����, player_name �̸�
from team t, player p
where t.team_id = p.team_id
    and p.team_id IN('K02','K10')
    and height BETWEEN 180 and 183
order by height,team_name,player_name
;
select p.height || 'cm' Ű, t.team_name ����, p.player_name �̸�
from player p
    join team t
    on p.team_id like t.team_id
where t.team_id IN('K02','K10')
    and p.height between 180 and 183
order by p.height, t.team_name, p.player_name
;

--10
--  ��� ������ ��
-- �������� �������� ���� �������� ���� �̸�
-- ����, ����� ��������
select t.team_name ����, p.player_name �̸�
from player p
    join team t
    on p.team_id like t.team_id
where p.position is null
order by t.team_name, p.player_name;

--sql �׽�Ʈ 011:
--  ���� ��Ÿ����� �����Ͽ�
-- ���̸�, ��Ÿ��� �̸� ���
select t.team_name ����, s.stadium_name ��Ÿ����
from team t
    join stadium s
    on t.stadium_id like s.stadium_id
;

--sql �׽�Ʈ 012 :
--  ���� ��Ÿ���, �������� �����Ͽ�
-- 2012�� 3�� 17�Ͽ� ���� �� �����
-- ���̸�, ��Ÿ���, ������� �̸� ���
-- �������̺� join �� ã�Ƽ� �ذ��Ͻÿ�.
select t1.team_name ����, st.stadium_name ��Ÿ����, t2.team_name ���������
from team t2, team t1   
    join stadium st
    on t1.stadium_id like st.stadium_id
        join schedule sc
        on st.stadium_id like sc.STADIUM_ID
where sc.sche_date like '20120317'
    and t2.team_id like sc.awayteam_id
;

SELECT
    T.TEAM_NAME ���̸�,
    S.STADIUM_NAME ��Ÿ���,
    K.AWAYTEAM_ID ������ID,
    K.SCHE_DATE ����
FROM TEAM T
    JOIN STADIUM S
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN SCHEDULE K
        ON S.STADIUM_ID LIKE K.STADIUM_ID
WHERE K.SCHE_DATE LIKE '20120317'
ORDER BY T.TEAM_NAME
;
-- sql �׽�Ʈ 013 :
-- 2012�� 3�� 17�� ��⿡
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������),
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�
select p.player_name ������, p.position ������, t.region_name || ' ' || t.team_name ����, stadium_name ��Ÿ���, sche_date �����ٳ�¥
from schedule sc
    join stadium st
        on sc.stadium_id like st.stadium_id
    join team t
        on t.stadium_id like st.stadium_id
    join player p
        on t.team_id like p.team_id   
where sc.sche_date like '20120317'
    and t.team_id like 'K03'
    and p.position like 'GK'
;

--sql �׽�Ʈ 014 :
-- Ȩ���� 3���̻� ���̷� �¸��� �����
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�
select st.stadium_name ��Ÿ���,sc.sche_date ��⳯¥,t1.region_name || ' ' || t1.team_name Ȩ��,t2.region_name || ' ' || t2.team_name ������,home_score "Ȩ�� ����" ,away_score "������ ����"
from team t1
    join stadium st 
        on t1.stadium_id like st.stadium_id
    join schedule sc
        on st.stadium_id like sc.stadium_id
    join team t2
        on t2.team_id like sc.awayteam_id
where sc.home_score - sc.away_score >= 3
order by sc.sche_date
;
SELECT
    S.STADIUM_NAME ��Ÿ���,
    K.SCHE_DATE ��⳯¥,
    HT.REGION_NAME || ' ' || HT.TEAM_NAME Ȩ��,
    AT.REGION_NAME || ' ' || AT.TEAM_NAME ������,
    K.HOME_SCORE "Ȩ�� ����",
    K.AWAY_SCORE "������ ����"
FROM SCHEDULE K
    JOIN STADIUM S
        ON K.STADIUM_ID LIKE S.STADIUM_ID
    JOIN TEAM HT
        ON K.HOMETEAM_ID LIKE HT.TEAM_ID
    JOIN TEAM AT
        ON K.AWAYTEAM_ID LIKE AT.TEAM_ID
WHERE
    K.HOME_SCORE >= K.AWAY_SCORE + 3
ORDER BY K.SCHE_DATE
;

--sql �׽�Ʈ 015 :
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
-- ī��Ʈ ���� 20 , �ϻ� �ؿ� ����, �Ⱦ絵 ����
select st.stadium_name,st.stadium_id,st.seat_count,st.hometeam_id,t.e_team_name
from stadium st
    left join team t
    on t.stadium_id like st.stadium_id
order by st.hometeam_id
;
-- SOCCER_SQL_016
-- �Ҽ��� �Ｚ������� ���� �������
-- �巡�������� �������� ���� ����
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ('K02', 'K07') -- K02 K07
;
-- SOCCER_SQL_017
-- �Ҽ��� �Ｚ������� ���� �������
-- �巡�������� �������� ���� ����
-- ���̵� �� ��
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN (
        (SELECT TEAM_ID
        FROM TEAM T
        WHERE T.TEAM_NAME IN ('�Ｚ�������','�巡����'))
    ) 
ORDER BY T.TEAM_NAME
;

--SOCCER_SQL_018
--��ȣ�� ������ �Ҽ����� ������, ��ѹ��� �����Դϱ�?
SELECT 
     P.PLAYER_NAME ������,
     T.TEAM_NAME ����,
     P.POSITION ������,
     P.BACK_NO ��ѹ�  
FROM PLAYER P 
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.PLAYER_NAME LIKE '��ȣ��'
;



-- 019
-- ������Ƽ���� MF ���Ű�� ���Դϱ�
SELECT ROUND(AVG(P.HEIGHT),2) ���Ű
FROM PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE T.TEAM_NAME LIKE '��Ƽ��'
    AND P.POSITION LIKE 'MF';

-- 020
-- 2012�� ���� ������ ���Ͻÿ�
SELECT 
    (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '03') "3��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '04') "4��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '05') "5��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '06') "6��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '07') "7��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '08') "8��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '09') "9��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '10') "10��", 
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '11') "11��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '12') "12��"
FROM DUAL
;   


SELECT COUNT(SC.SCHE_DATE)
FROM SCHEDULE SC
WHERE SC.SCHE_DATE LIKE '201203%'
;

-- 021
-- 2012�� ���� ����� ����(GUBUN IS YES)�� ���Ͻÿ�
-- ����� 1��:20��� �̷�������...
SELECT 
    (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '03'
     AND SCHEDULE.GUBUN LIKE 'Y') "3��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '04'
     AND SCHEDULE.GUBUN LIKE 'Y') "4��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '05'
     AND SCHEDULE.GUBUN LIKE 'Y') "5��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '06'
     AND SCHEDULE.GUBUN LIKE 'Y') "6��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '07'
     AND SCHEDULE.GUBUN LIKE 'Y') "7��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '08'
     AND SCHEDULE.GUBUN LIKE 'Y') "8��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '09'
     AND SCHEDULE.GUBUN LIKE 'Y') "9��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '10'
     AND SCHEDULE.GUBUN LIKE 'Y') "10��", 
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '11'
     AND SCHEDULE.GUBUN LIKE 'Y') "11��",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '12'
     AND SCHEDULE.GUBUN LIKE 'Y') "12��"
FROM DUAL
;   

-- 022
-- 2012�� 9�� 14�Ͽ� ������ ���� ���� ����Դϱ�
-- Ȩ��: ?   ������: ? �� ���
SELECT SC.SCHE_DATE ��⳯¥, T1.TEAM_NAME Ȩ��, T2.TEAM_NAME �������
FROM SCHEDULE SC
    JOIN TEAM T1
        ON SC.HOMETEAM_ID LIKE T1.TEAM_ID
    JOIN TEAM T2
        ON SC.AWAYTEAM_ID LIKE T2.TEAM_ID
WHERE SC.SCHE_DATE LIKE '20120914'
;

-- 023
-- Group by ���
-- ���� ������ ��
-- ������ũ 20��
-- �巡���� 19��
SELECT 
    T.TEAM_NAME ����,
    COUNT(P.PLAYER_ID) �����ο�
FROM
    TEAM T
    JOIN PLAYER P
        ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY
    T.TEAM_ID,
    T.TEAM_NAME
ORDER BY
    T.TEAM_ID
;
SELECT 
    (SELECT
        TEAM_NAME
     FROM TEAM
     WHERE TEAM_ID LIKE T.TEAM_ID) ����,
    COUNT(P.PLAYER_ID) �����ο�
FROM
    TEAM T
    JOIN PLAYER P
        ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY
    T.TEAM_ID
ORDER BY
    T.TEAM_ID
;

-- 024
-- Group by ���
-- ���� ��Ű���� ��� Ű
-- ������ũ 180CM
-- �巡���� 178CM
SELECT
    T.TEAM_NAME ����,
    --P.POSITION ������,
    AVG(P.HEIGHT) Ű
FROM 
    PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE
    P.POSITION LIKE 'GK'
GROUP BY 
    T.TEAM_NAME
    --P.POSITION
ORDER BY
    T.TEAM_NAME
;

desc team;
desc schedule;
desc PLAYER;
select * from schedule WHERE schedule.SCHE_DATE LIKE '201210%';
select * from team;
select * from stadium;
select * from PLAYER;

-- NVL2�� ����Ŭ�� ... ��� �̰� ����ض�
SELECT
    PLAYER_NAME �̸�,
    CASE
        WHEN POSITION IS NULL THEN '����' -- �ѱ��� �� �� �ִ�.
        WHEN POSITION LIKE 'GK' THEN '��Ű��'
        WHEN POSITION LIKE 'DF' THEN '�����'
        WHEN POSITION LIKE 'MF' THEN '�̵��ʴ�'
        WHEN POSITION LIKE 'FW' THEN '���ݼ�'
        ELSE POSITION -- DEFAULT
    END ������ -- ���̾ƽ�
FROM
    PLAYER
WHERE
    TEAM_ID = 'K08'
;


---------------------------------------------------------------------------------------------------


-- SOCCER_SQL_001
SELECT 
    COUNT(*) "���̺��� ��" 
FROM TAB;
-- SOCCER_SQL_002
SELECT 
    TEAM_NAME "��ü �౸�� ���" 
FROM TEAM
ORDER BY TEAM_NAME DESC
;
-- SOCCER_SQL_003
-- ������ ����(�ߺ�����,������ �������� ����)
-- NVL2()
SELECT DISTINCT NVL2(POSITION,POSITION,'����') "������" 
FROM PLAYER;
-- SOCCER_SQL_004
-- ������(ID: K02)��Ű��
SELECT PLAYER_NAME �̸�
FROM PLAYER
WHERE TEAM_ID = 'K02'
    AND POSITION = 'GK'
ORDER BY PLAYER_NAME 
;
-- SOCCER_SQL_005
-- ������(ID: K02)Ű�� 170 �̻� ����
-- �̸鼭 ���� ���� ����
SELECT POSITION ������,PLAYER_NAME �̸�
FROM PLAYER
WHERE HEIGHT >= 170
    AND TEAM_ID LIKE 'K02'
    AND SUBSTR(PLAYER_NAME,0,1) LIKE '��'
ORDER BY PLAYER_NAME 
;
-- SUBSTR('ȫ�浿',2,2) �ϸ�
-- �浿�� ��µǴµ�
-- ��2�� ������ġ, ��2�� ���ڼ��� ����
SELECT SUBSTR(PLAYER_NAME,2,2) �׽�Ʈ��
FROM PLAYER
;
-- �ٸ� Ǯ��(����)
SELECT POSITION ������,PLAYER_NAME �̸�
FROM PLAYER
WHERE HEIGHT >= 170
    AND TEAM_ID LIKE 'K02'
    AND PLAYER_NAME LIKE '��%'
ORDER BY PLAYER_NAME 
;
-- SOCCER_SQL_006
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� CM �� KG ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- Ű ��������
SELECT 
    PLAYER_NAME || '����' �̸�,
    NVL2(HEIGHT,HEIGHT,0) || 'CM' Ű,
    NVL2(WEIGHT,WEIGHT,0) || 'KG' ������
FROM PLAYER
WHERE TEAM_ID LIKE 'K02'
ORDER BY HEIGHT DESC
;
-- SOCCER_SQL_007
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� CM �� KG ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- BMI���� 
-- Ű ��������
SELECT 
    PLAYER_NAME || '����' �̸�,
    NVL2(HEIGHT,HEIGHT,0) || 'CM' Ű,
    NVL2(WEIGHT,WEIGHT,0) || 'KG' ������,
    ROUND(WEIGHT/((HEIGHT/100)*(HEIGHT/100)),2) "BMI ������"
FROM PLAYER
WHERE TEAM_ID = 'K02'
ORDER BY HEIGHT DESC
;
-- SOCCER_SQL_008
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- GK �������� ����
-- ����, ����� ��������
SELECT 
    T.TEAM_NAME,
    P.POSITION,
    P.PLAYER_NAME 
FROM PLAYER P, TEAM T
WHERE T.TEAM_ID = P.TEAM_ID
    AND T.TEAM_ID IN ( 'K02', 'K10')
    AND P.POSITION LIKE 'GK'
ORDER BY T.TEAM_NAME, P.PLAYER_NAME
;
-- ANSI JOIN ���(����)
SELECT 
    T.TEAM_NAME,
    P.POSITION,
    P.PLAYER_NAME 
FROM PLAYER P
INNER JOIN TEAM T
ON T.TEAM_ID LIKE P.TEAM_ID
WHERE T.TEAM_ID IN ( 'K02', 'K10')
    AND P.POSITION LIKE 'GK'
ORDER BY T.TEAM_NAME, P.PLAYER_NAME
;
-- SOCCER_SQL_009
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- Ű�� 180 �̻� 183 ������ ������
-- Ű, ����, ����� ��������
SELECT 
    P.HEIGHT || 'CM' Ű,
    T.TEAM_NAME ����,
    P.PLAYER_NAME �̸�
FROM PLAYER P, TEAM T
WHERE 
    T.TEAM_ID = P.TEAM_ID
    AND T.TEAM_ID IN ( 'K02', 'K10')
    AND P.HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT, T.TEAM_NAME, P.PLAYER_NAME
;
-- ANSI JOIN ���(����)
SELECT P.HEIGHT ||'CM' Ű,
    T.TEAM_NAME ����, 
    P.PLAYER_NAME �̸�
FROM PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE T.TEAM_ID IN ('K02', 'K10')
    AND P.HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT, T.TEAM_NAME, P.PLAYER_NAME
; 
-- SOCCER_SQL_010
--  ��� ������ ��
-- �������� �������� ���� �������� ���� �̸�
-- ����, ����� ��������
SELECT 
    T.TEAM_NAME,
    P.PLAYER_NAME 
FROM PLAYER P, TEAM T
WHERE  P.POSITION IS NULL
ORDER BY T.TEAM_NAME, P.PLAYER_NAME
;
-- SOCCER_SQL_011
-- ���̸�, ��Ÿ��� �̸� ���
SELECT T.TEAM_NAME ����,S.STADIUM_NAME ��Ÿ���
FROM STADIUM S 
    JOIN TEAM T
    ON T.STADIUM_ID LIKE S.STADIUM_ID
ORDER BY T.TEAM_NAME     
;
-- SOCCER_SQL_012
-- 2012�� 3�� 17�Ͽ� ���� �� ����� 
-- ���̸�, ��Ÿ���, ������� �̸� ���



-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�
SELECT 
    P.PLAYER_NAME ������,
    P.POSITION ������,
    T.REGION_NAME || '  '||T.TEAM_NAME ����,
    S.STADIUM_NAME ��Ÿ���,
    K.SCHE_DATE �����ٳ�¥
FROM 
    TEAM T    
    JOIN STADIUM S
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN PLAYER P     
        ON T.TEAM_ID LIKE P.TEAM_ID
    JOIN SCHEDULE K
        ON S.STADIUM_ID LIKE K.STADIUM_ID
WHERE
    K.SCHE_DATE LIKE '20120317'    
    AND P.POSITION LIKE 'GK'
    AND S.STADIUM_NAME LIKE '���׽�ƿ�ߵ�'
ORDER BY P.PLAYER_NAME     
; 
-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�
SELECT 
    S.STADIUM_NAME ��Ÿ���,
    K.SCHE_DATE ��⳯¥,
    HT.REGION_NAME || '  '||HT.TEAM_NAME Ȩ��,
    AT.REGION_NAME || '  '||AT.TEAM_NAME ������,
    K.HOME_SCORE "Ȩ�� ����",
    K.AWAY_SCORE "������ ����"
FROM 
    SCHEDULE K    
    JOIN STADIUM S
        ON K.STADIUM_ID LIKE S.STADIUM_ID
    JOIN TEAM HT     
        ON K.HOMETEAM_ID LIKE HT.TEAM_ID
    JOIN TEAM AT
        ON K.AWAYTEAM_ID LIKE AT.TEAM_ID
WHERE
    K.HOME_SCORE >= K.AWAY_SCORE +3 
ORDER BY K.SCHE_DATE     
;
-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
SELECT 
    S.STADIUM_NAME,
    S.STADIUM_ID,
    S.SEAT_COUNT,
    S.HOMETEAM_ID,
    T.E_TEAM_NAME
FROM STADIUM S
    LEFT JOIN TEAM T
        ON S.HOMETEAM_ID LIKE T.TEAM_ID
ORDER BY S.HOMETEAM_ID
;
-- SOCCER_SQL_016
-- �Ҽ��� �Ｚ ������� ���� �������
-- ���� �巡�������� �������� ���� ����
---- UNION VERSION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K02'
UNION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K07'
;
---- OR VERSION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K02' 
    OR T.TEAM_ID LIKE 'K07'
;
---- IN VERSION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ('K02', 'K07')
;
-- SOCCER_SQL_017
-- �Ҽ��� �Ｚ ������� ���� �������
-- ���� �巡�������� �������� ���� ����
---- SUBQUERY VERSION


-- SOCCER_SQL_018
-- �Ҽ��� �Ｚ ������� ���� �������
-- ���� �巡�������� �������� ���� ����
---- SUBQUERY VERSION




-- 018
-- ��ȣ�� ������ �Ҽ����� ������, ��ѹ��� �����Դϱ�

-- 019
-- ������Ƽ���� MF ���Ű�� ���Դϱ�? 174.87

-- 020
-- 2012�� ���� ������ ���Ͻÿ�


-- 021
-- 2012�� ���� ����� ����(GUBUN IS YES)�� ���Ͻÿ�
-- ����� 1��:20��� �̷�������...


-- 022
-- 2012�� 9�� 14�Ͽ� ������ ���� ���� ����Դϱ�
-- Ȩ��: ?   ������: ? �� ���


