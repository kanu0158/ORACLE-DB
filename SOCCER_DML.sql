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
FROM PLAYER P, TEAM T
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
SELECT COUNT(SC3.SCHE_DATE)
FROM SCHEDULE SC3, SCHEDULE SC4, SCHEDULE SC5,
    SCHEDULE SC6, SCHEDULE SC7, SCHEDULE SC8, SCHEDULE SC9, SCHEDULE SC10,
    SCHEDULE SC11, SCHEDULE SC12
WHERE SC3.SCHE_DATE LIKE '201203%'
     SC4.SCHE_DATE LIKE '201204%'
     SC5.SCHE_DATE LIKE '201205%'
     SC6.SCHE_DATE LIKE '201206%'
     SC7.SCHE_DATE LIKE '201207%'
     SC8.SCHE_DATE LIKE '201208%'
     SC9.SCHE_DATE LIKE '201209%'
     SC10.SCHE_DATE LIKE '201210%'
     SC11.SCHE_DATE LIKE '201211%'
     SC12.SCHE_DATE LIKE '201212%'
;

SELECT 
    COUNT(SC3.SCHE_DATE), 
    COUNT(SC4.SCHE_DATE), 
    COUNT(SC5.SCHE_DATE),
    COUNT(SC6.SCHE_DATE),
    COUNT(SC7.SCHE_DATE),
    COUNT(SC8.SCHE_DATE),
    COUNT(SC9.SCHE_DATE),
    COUNT(SC10.SCHE_DATE),
    COUNT(SC11.SCHE_DATE),
    COUNT(SC12.SCHE_DATE)
FROM (SELECT SCHEDULE.SCHE_DATE
      FROM SCHEDULE
      WHERE SCHEDULE.SCHE_DATE LIKE '201203%') SC3,
      (SELECT SCHEDULE.SCHE_DATE
      FROM SCHEDULE
      WHERE SCHEDULE.SCHE_DATE LIKE '201204%') SC4,
      (SELECT SCHEDULE.SCHE_DATE
      FROM SCHEDULE
      WHERE SCHEDULE.SCHE_DATE LIKE '201205%') SC5,
      (SELECT SCHEDULE.SCHE_DATE
      FROM SCHEDULE
      WHERE SCHEDULE.SCHE_DATE LIKE '201206%') SC6,
      (SELECT SCHEDULE.SCHE_DATE
      FROM SCHEDULE
      WHERE SCHEDULE.SCHE_DATE LIKE '201207%') SC7,
      (SELECT SCHEDULE.SCHE_DATE
      FROM SCHEDULE
      WHERE SCHEDULE.SCHE_DATE LIKE '201208%') SC8,
      (SELECT SCHEDULE.SCHE_DATE
      FROM SCHEDULE
      WHERE SCHEDULE.SCHE_DATE LIKE '201209%') SC9,
      (SELECT SCHEDULE.SCHE_DATE
      FROM SCHEDULE
      WHERE SCHEDULE.SCHE_DATE LIKE '201210%') SC10,
      (SELECT SCHEDULE.SCHE_DATE
      FROM SCHEDULE
      WHERE SCHEDULE.SCHE_DATE LIKE '201211%') SC11,
      (SELECT SCHEDULE.SCHE_DATE
      FROM SCHEDULE
      WHERE SCHEDULE.SCHE_DATE LIKE '201212%') SC12
;
      


SELECT COUNT(SC.SCHE_DATE)
FROM SCHEDULE SC
WHERE SC.SCHE_DATE LIKE '201203%'
;

desc team;
desc schedule;
desc schedule;
select * from schedule;
select * from team;
select * from staZdium;
