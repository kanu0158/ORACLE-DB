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
FROM PLAYER P 
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
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
SELECT 
    (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '03') "3월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '04') "4월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '05') "5월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '06') "6월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '07') "7월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '08') "8월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '09') "9월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '10') "10월", 
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '11') "11월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '12') "12월"
FROM DUAL
;   


SELECT COUNT(SC.SCHE_DATE)
FROM SCHEDULE SC
WHERE SC.SCHE_DATE LIKE '201203%'
;

-- 021
-- 2012년 월별 진행된 경기수(GUBUN IS YES)를 구하시오
-- 출력은 1월:20경기 이런식으로...
SELECT 
    (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '03'
     AND SCHEDULE.GUBUN LIKE 'Y') "3월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '04'
     AND SCHEDULE.GUBUN LIKE 'Y') "4월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '05'
     AND SCHEDULE.GUBUN LIKE 'Y') "5월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '06'
     AND SCHEDULE.GUBUN LIKE 'Y') "6월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '07'
     AND SCHEDULE.GUBUN LIKE 'Y') "7월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '08'
     AND SCHEDULE.GUBUN LIKE 'Y') "8월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '09'
     AND SCHEDULE.GUBUN LIKE 'Y') "9월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '10'
     AND SCHEDULE.GUBUN LIKE 'Y') "10월", 
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '11'
     AND SCHEDULE.GUBUN LIKE 'Y') "11월",
     (SELECT COUNT(*)
     FROM SCHEDULE
     WHERE SUBSTR(SCHEDULE.SCHE_DATE,5,2) LIKE '12'
     AND SCHEDULE.GUBUN LIKE 'Y') "12월"
FROM DUAL
;   

-- 022
-- 2012년 9월 14일에 벌어질 경기는 어디와 어디입니까
-- 홈팀: ?   원정팀: ? 로 출력
SELECT SC.SCHE_DATE 경기날짜, T1.TEAM_NAME 홈팀, T2.TEAM_NAME 어웨이팀
FROM SCHEDULE SC
    JOIN TEAM T1
        ON SC.HOMETEAM_ID LIKE T1.TEAM_ID
    JOIN TEAM T2
        ON SC.AWAYTEAM_ID LIKE T2.TEAM_ID
WHERE SC.SCHE_DATE LIKE '20120914'
;

-- 023
-- Group by 사용
-- 팀별 선수의 수
-- 아이파크 20명
-- 드래곤즈 19명
SELECT 
    T.TEAM_NAME 팀명,
    COUNT(P.PLAYER_ID) 선수인원
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
     WHERE TEAM_ID LIKE T.TEAM_ID) 팀명,
    COUNT(P.PLAYER_ID) 선수인원
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
-- Group by 사용
-- 팀별 골키퍼의 평균 키
-- 아이파크 180CM
-- 드래곤즈 178CM
SELECT
    T.TEAM_NAME 팀명,
    --P.POSITION 포지션,
    AVG(P.HEIGHT) 키
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

-- NVL2는 오라클꺼 ... 대신 이걸 사용해라
SELECT
    PLAYER_NAME 이름,
    CASE
        WHEN POSITION IS NULL THEN '없음' -- 한글을 달 수 있다.
        WHEN POSITION LIKE 'GK' THEN '골키퍼'
        WHEN POSITION LIKE 'DF' THEN '수비수'
        WHEN POSITION LIKE 'MF' THEN '미드필더'
        WHEN POSITION LIKE 'FW' THEN '공격수'
        ELSE POSITION -- DEFAULT
    END 포지션 -- 아이아스
FROM
    PLAYER
WHERE
    TEAM_ID = 'K08'
;


---------------------------------------------------------------------------------------------------


-- SOCCER_SQL_001
SELECT 
    COUNT(*) "테이블의 수" 
FROM TAB;
-- SOCCER_SQL_002
SELECT 
    TEAM_NAME "전체 축구팀 목록" 
FROM TEAM
ORDER BY TEAM_NAME DESC
;
-- SOCCER_SQL_003
-- 포지션 종류(중복제거,없으면 신입으로 기재)
-- NVL2()
SELECT DISTINCT NVL2(POSITION,POSITION,'신입') "포지션" 
FROM PLAYER;
-- SOCCER_SQL_004
-- 수원팀(ID: K02)골키퍼
SELECT PLAYER_NAME 이름
FROM PLAYER
WHERE TEAM_ID = 'K02'
    AND POSITION = 'GK'
ORDER BY PLAYER_NAME 
;
-- SOCCER_SQL_005
-- 수원팀(ID: K02)키가 170 이상 선수
-- 이면서 성이 고씨인 선수
SELECT POSITION 포지션,PLAYER_NAME 이름
FROM PLAYER
WHERE HEIGHT >= 170
    AND TEAM_ID LIKE 'K02'
    AND SUBSTR(PLAYER_NAME,0,1) LIKE '고'
ORDER BY PLAYER_NAME 
;
-- SUBSTR('홍길동',2,2) 하면
-- 길동이 출력되는데
-- 앞2는 시작위치, 뒤2는 글자수를 뜻함
SELECT SUBSTR(PLAYER_NAME,2,2) 테스트값
FROM PLAYER
;
-- 다른 풀이(권장)
SELECT POSITION 포지션,PLAYER_NAME 이름
FROM PLAYER
WHERE HEIGHT >= 170
    AND TEAM_ID LIKE 'K02'
    AND PLAYER_NAME LIKE '고%'
ORDER BY PLAYER_NAME 
;
-- SOCCER_SQL_006
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 CM 와 KG 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- 키 내림차순
SELECT 
    PLAYER_NAME || '선수' 이름,
    NVL2(HEIGHT,HEIGHT,0) || 'CM' 키,
    NVL2(WEIGHT,WEIGHT,0) || 'KG' 몸무게
FROM PLAYER
WHERE TEAM_ID LIKE 'K02'
ORDER BY HEIGHT DESC
;
-- SOCCER_SQL_007
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 CM 와 KG 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- BMI지수 
-- 키 내림차순
SELECT 
    PLAYER_NAME || '선수' 이름,
    NVL2(HEIGHT,HEIGHT,0) || 'CM' 키,
    NVL2(WEIGHT,WEIGHT,0) || 'KG' 몸무게,
    ROUND(WEIGHT/((HEIGHT/100)*(HEIGHT/100)),2) "BMI 비만지수"
FROM PLAYER
WHERE TEAM_ID = 'K02'
ORDER BY HEIGHT DESC
;
-- SOCCER_SQL_008
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- GK 포지션인 선수
-- 팀명, 사람명 오름차순
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
-- ANSI JOIN 사용(권장)
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
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- 키가 180 이상 183 이하인 선수들
-- 키, 팀명, 사람명 오름차순
SELECT 
    P.HEIGHT || 'CM' 키,
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 이름
FROM PLAYER P, TEAM T
WHERE 
    T.TEAM_ID = P.TEAM_ID
    AND T.TEAM_ID IN ( 'K02', 'K10')
    AND P.HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT, T.TEAM_NAME, P.PLAYER_NAME
;
-- ANSI JOIN 사용(권장)
SELECT P.HEIGHT ||'CM' 키,
    T.TEAM_NAME 팀명, 
    P.PLAYER_NAME 이름
FROM PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE T.TEAM_ID IN ('K02', 'K10')
    AND P.HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT, T.TEAM_NAME, P.PLAYER_NAME
; 
-- SOCCER_SQL_010
--  모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순
SELECT 
    T.TEAM_NAME,
    P.PLAYER_NAME 
FROM PLAYER P, TEAM T
WHERE  P.POSITION IS NULL
ORDER BY T.TEAM_NAME, P.PLAYER_NAME
;
-- SOCCER_SQL_011
-- 팀이름, 스타디움 이름 출력
SELECT T.TEAM_NAME 팀명,S.STADIUM_NAME 스타디움
FROM STADIUM S 
    JOIN TEAM T
    ON T.STADIUM_ID LIKE S.STADIUM_ID
ORDER BY T.TEAM_NAME     
;
-- SOCCER_SQL_012
-- 2012년 3월 17일에 열린 각 경기의 
-- 팀이름, 스타디움, 어웨이팀 이름 출력



-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에 
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함), 
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오
SELECT 
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    T.REGION_NAME || '  '||T.TEAM_NAME 팀명,
    S.STADIUM_NAME 스타디움,
    K.SCHE_DATE 스케줄날짜
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
    AND S.STADIUM_NAME LIKE '포항스틸야드'
ORDER BY P.PLAYER_NAME     
; 
-- SOCCER_SQL_014
-- 홈팀이 3점이상 차이로 승리한 경기의 
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오
SELECT 
    S.STADIUM_NAME 스타디움,
    K.SCHE_DATE 경기날짜,
    HT.REGION_NAME || '  '||HT.TEAM_NAME 홈팀,
    AT.REGION_NAME || '  '||AT.TEAM_NAME 원정팀,
    K.HOME_SCORE "홈팀 점수",
    K.AWAY_SCORE "원정팀 점수"
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
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
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
-- 소속이 삼성 블루윙즈 팀인 선수들과
-- 전남 드래곤즈팀인 선수들의 선수 정보
---- UNION VERSION
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
    T.TEAM_ID LIKE 'K02'
UNION
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
    T.TEAM_ID LIKE 'K07'
;
---- OR VERSION
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
    T.TEAM_ID LIKE 'K02' 
    OR T.TEAM_ID LIKE 'K07'
;
---- IN VERSION
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
    T.TEAM_ID IN ('K02', 'K07')
;
-- SOCCER_SQL_017
-- 소속이 삼성 블루윙즈 팀인 선수들과
-- 전남 드래곤즈팀인 선수들의 선수 정보
---- SUBQUERY VERSION


-- SOCCER_SQL_018
-- 소속이 삼성 블루윙즈 팀인 선수들과
-- 전남 드래곤즈팀인 선수들의 선수 정보
---- SUBQUERY VERSION




-- 018
-- 최호진 선수의 소속팀과 포지션, 백넘버는 무엇입니까

-- 019
-- 대전시티즌의 MF 평균키는 얼마입니까? 174.87

-- 020
-- 2012년 월별 경기수를 구하시오


-- 021
-- 2012년 월별 진행된 경기수(GUBUN IS YES)를 구하시오
-- 출력은 1월:20경기 이런식으로...


-- 022
-- 2012년 9월 14일에 벌어질 경기는 어디와 어디입니까
-- 홈팀: ?   원정팀: ? 로 출력


