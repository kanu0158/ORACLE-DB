select * from team;
select count(*) AS "테이블의 수" from tab;
select count(*) 테이블의수 from tab; -- 컬럼의 아이아스

select team_name as "전체 축구팀 목록" from team;
select team_name "전체 축구팀 목록" from team order by team_name; -- 오름차순
select team_name as "전체 축구팀 목록" from team order by team_name desc; -- 내림차순

select distinct position as "포지션" from player;
select 
    distinct nvl2(position,position,'신입') "포지션" 
from player; -- nvl2(a,'b','c') a가 null이면 c, null아니면 b

select player_name 이름
from player
where team_id like 'K02'
    and position like 'GK'
order by player_name
;


select position 포지션, player_name 이름
from player
where team_id like 'K02'
    and height >= 170
    and substr(player_name,1,1) like '고'
;

select substr(player_name,1,2) 테스트값
from player
;
select position 포지션, player_name 이름
from player
where team_id like 'K02'
    and height >= 170
    and player_name like '고__'
;

select player_name 이름,
     to_char(nvl2(height,height,0)) || 'cm' 키,
     to_char(nvl2(weight,weight,0)) || 'kg' 무게
from player
where team_id like 'K02'
order by height desc
;
select player_name || '선수' 이름,
     nvl2(height,height,0) || 'cm' 키,
     nvl2(weight,weight,0) || 'kg' 무게
from player
where team_id like 'K02'
order by height desc
;

select player_name || '선수' 이름,
     nvl2(height,height,0) || 'cm' 키,
     nvl2(weight,weight,0) || 'kg' 무게,
     ROUND(weight/(POWER(height,2)/10000),2) BMI
from player
where team_id like 'K02'
order by height desc
;

select player_name || '선수' 이름, p.team_id 팀아디
from player p, team t
where p.team_id = t.team_id 
    AND p.team_id IN('K10','K02') 
    AND p.position like 'MF'
    AND player_name like '고%'
order by team_name
;
select p.player_name || '선수' 이름, t.team_id
from player p
inner join team t
on p.team_id = t.team_id
where p.team_id in('K10','K02')
    and p.position like 'MF'
    and p.player_name like '고%'
order by t.team_name
;

select player_name || '선수' 이름, team_id 아디
from player
where player_name like '고%'
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


select height || 'cm' 키, team_name 팀명, player_name 이름
from team t, player p
where t.team_id = p.team_id
    and p.team_id IN('K02','K10')
    and height BETWEEN 180 and 183
order by height,team_name,player_name
;
select p.height || 'cm' 키, t.team_name 팀명, p.player_name 이름
from player p
    join team t
    on p.team_id like t.team_id
where t.team_id IN('K02','K10')
    and p.height between 180 and 183
order by p.height, t.team_name, p.player_name
;

--10
--  모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순
select t.team_name 팀명, p.player_name 이름
from player p
    join team t
    on p.team_id like t.team_id
where p.position is null
order by t.team_name, p.player_name;

--sql 테스트 011:
--  팀과 스타디움을 조인하여
-- 팀이름, 스타디움 이름 출력
select t.team_name 팀명, s.stadium_name 스타디움명
from team t
    join stadium s
    on t.stadium_id like s.stadium_id
;

--sql 테스트 012 :
--  팀과 스타디움, 스케줄을 조인하여
-- 2012년 3월 17일에 열린 각 경기의
-- 팀이름, 스타디움, 어웨이팀 이름 출력
-- 다중테이블 join 을 찾아서 해결하시오.
select t1.team_name 팀명, st.stadium_name 스타디움명, t2.team_name 어웨이팀명
from team t2, team t1   
    join stadium st
    on t1.stadium_id like st.stadium_id
        join schedule sc
        on st.stadium_id like sc.STADIUM_ID
where sc.sche_date like '20120317'
    and t2.team_id like sc.awayteam_id
;

SELECT
    T.TEAM_NAME 팀이름,
    S.STADIUM_NAME 스타디움,
    K.AWAYTEAM_ID 원정팀ID,
    K.SCHE_DATE 일정
FROM TEAM T
    JOIN STADIUM S
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN SCHEDULE K
        ON S.STADIUM_ID LIKE K.STADIUM_ID
WHERE K.SCHE_DATE LIKE '20120317'
ORDER BY T.TEAM_NAME
;
-- sql 테스트 013 :
-- 2012년 3월 17일 경기에
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함),
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오
select p.player_name 선수명, p.position 포지션, t.region_name || ' ' || t.team_name 팀명, stadium_name 스타디움, sche_date 스케줄날짜
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

--sql 테스트 014 :
-- 홈팀이 3점이상 차이로 승리한 경기의
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오
select st.stadium_name 스타디움,sc.sche_date 경기날짜,t1.region_name || ' ' || t1.team_name 홈팀,t2.region_name || ' ' || t2.team_name 원정팀,home_score "홈팀 점수" ,away_score "원정팀 점수"
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
    S.STADIUM_NAME 스타디움,
    K.SCHE_DATE 경기날짜,
    HT.REGION_NAME || ' ' || HT.TEAM_NAME 홈팀,
    AT.REGION_NAME || ' ' || AT.TEAM_NAME 원정팀,
    K.HOME_SCORE "홈팀 점수",
    K.AWAY_SCORE "원정팀 점수"
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

--sql 테스트 015 :
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
-- 카운트 값은 20 , 일산 밑에 마산, 안양도 있음
select st.stadium_name,st.stadium_id,st.seat_count,st.hometeam_id,t.e_team_name
from stadium st
    left join team t
    on t.stadium_id like st.stadium_id
order by st.hometeam_id
;
-- SOCCER_SQL_016
-- 소속이 삼성블루윙즈 팀인 선수들과
-- 드래곤즈팀인 선수들의 선수 정보
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ('K02', 'K07') -- K02 K07
;
-- SOCCER_SQL_017
-- 소속이 삼성블루윙즈 팀인 선수들과
-- 드래곤즈팀인 선수들의 선수 정보
-- 아이디 모를 때
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN (
        (SELECT TEAM_ID
        FROM TEAM T
        WHERE T.TEAM_NAME IN ('삼성블루윙즈','드래곤즈'))
    ) 
ORDER BY T.TEAM_NAME
;

--SOCCER_SQL_018
--최호진 선수의 소속팀과 포지션, 백넘버는 무엇입니까?
SELECT 
     P.PLAYER_NAME 선수명,
     T.TEAM_NAME 팀명,
     P.POSITION 포지션,
     P.BACK_NO 백넘버  
FROM PLAYER P, TEAM T
WHERE P.PLAYER_NAME LIKE '최호진'
;


-- 019
-- 대전시티즌의 MF 평균키는 얼마입니까
SELECT ROUND(AVG(P.HEIGHT),2) 평균키
FROM PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE T.TEAM_NAME LIKE '시티즌'
    AND P.POSITION LIKE 'MF';

-- 020
-- 2012년 월별 경기수를 구하시오
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
