/* Formatted on 2018/06/29 오전 11:10:40 (QP5 v5.326) */
SELECT * FROM team;

SELECT COUNT (*) AS "테이블의 수" FROM tab;

SELECT COUNT (*) 테이블의수 FROM tab;                                                                                                -- 컬럼의 아이아스

SELECT team_name AS "전체 축구팀 목록" FROM team;

  SELECT team_name     "전체 축구팀 목록"
    FROM team
ORDER BY team_name;                                                                                                 -- 오름차순

  SELECT team_name     AS "전체 축구팀 목록"
    FROM team
ORDER BY team_name DESC;                                                                                                                   -- 내림차순

SELECT DISTINCT position     AS "포지션"
  FROM player;

SELECT DISTINCT NVL2 (position, position, '신입')     "포지션"
  FROM player;                                         -- nvl2(a,'b','c') a가 null이면 c, null아니면 b

  SELECT player_name     이름
    FROM player
   WHERE team_id LIKE 'K02' AND position LIKE 'GK'
ORDER BY player_name;


SELECT position 포지션, player_name 이름
  FROM player
 WHERE     team_id LIKE 'K02'
       AND height >= 170
       AND SUBSTR (player_name, 1, 1) LIKE '고';

SELECT SUBSTR (player_name, 1, 2) 테스트값 FROM player;

SELECT position 포지션, player_name 이름
  FROM player
 WHERE team_id LIKE 'K02' AND height >= 170 AND player_name LIKE '고__';

  SELECT player_name                                    이름,
         TO_CHAR (NVL2 (height, height, 0)) || 'cm'     키,
         TO_CHAR (NVL2 (weight, weight, 0)) || 'kg'     무게
    FROM player
   WHERE team_id LIKE 'K02'
ORDER BY height DESC;

  SELECT player_name || '선수'              이름,
         NVL2 (height, height, 0) || 'cm'     키,
         NVL2 (weight, weight, 0) || 'kg'     무게
    FROM player
   WHERE team_id LIKE 'K02'
ORDER BY height DESC;

  SELECT player_name || '선수'                             이름,
         NVL2 (height, height, 0) || 'cm'                    키,
         NVL2 (weight, weight, 0) || 'kg'                    무게,
         ROUND (weight / (POWER (height, 2) / 10000), 2)     BMI
    FROM player
   WHERE team_id LIKE 'K02'
ORDER BY height DESC;

  SELECT player_name || '선수' 이름, p.team_id 팀아디
    FROM player p, team t
   WHERE     p.team_id = t.team_id
         AND p.team_id IN ('K10', 'K02')
         AND p.position LIKE 'MF'
         AND player_name LIKE '고%'
ORDER BY team_name;

  SELECT p.player_name || '선수' 이름, t.team_id
    FROM player p INNER JOIN team t ON p.team_id = t.team_id
   WHERE     p.team_id IN ('K10', 'K02')
         AND p.position LIKE 'MF'
         AND p.player_name LIKE '고%'
ORDER BY t.team_name;

SELECT player_name || '선수' 이름, team_id 아디
  FROM player
 WHERE player_name LIKE '고%';


  SELECT team_name,
         position,
         player_name,
         nation,
         t.team_id,
         p.team_id
    FROM team t, player p
   WHERE     p.team_id = t.team_id
         AND p.team_id IN ('K02', 'K10')
         AND p.position LIKE 'GK'
ORDER BY t.team_name, p.player_name;

  SELECT team_name,
         position,
         player_name,
         nation,
         t.team_id,
         p.team_id
    FROM player p INNER JOIN team t ON p.team_id LIKE t.team_id
   WHERE t.team_id IN ('K02', 'K10') AND p.position LIKE 'GK'
ORDER BY t.team_name, p.player_name;


  SELECT height || 'cm' 키, team_name 팀명, player_name 이름
    FROM team t, player p
   WHERE     t.team_id = p.team_id
         AND p.team_id IN ('K02', 'K10')
         AND height BETWEEN 180 AND 183
ORDER BY height, team_name, player_name;

  SELECT p.height || 'cm' 키, t.team_name 팀명, p.player_name 이름
    FROM player p JOIN team t ON p.team_id LIKE t.team_id
   WHERE t.team_id IN ('K02', 'K10') AND p.height BETWEEN 180 AND 183
ORDER BY p.height, t.team_name, p.player_name;

--10
--  모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순

  SELECT t.team_name 팀명, p.player_name 이름
    FROM player p JOIN team t ON p.team_id LIKE t.team_id
   WHERE p.position IS NULL
ORDER BY t.team_name, p.player_name;

--sql 테스트 011:
--  팀과 스타디움을 조인하여
-- 팀이름, 스타디움 이름 출력

SELECT t.team_name 팀명, s.stadium_name 스타디움명
  FROM team t JOIN stadium s ON t.stadium_id LIKE s.stadium_id;

--sql 테스트 012 :
--  팀과 스타디움, 스케줄을 조인하여
-- 2012년 3월 17일에 열린 각 경기의
-- 팀이름, 스타디움, 어웨이팀 이름 출력
-- 다중테이블 join 을 찾아서 해결하시오.

SELECT t1.team_name        팀명,
       st.stadium_name     스타디움명,
       t2.team_name        어웨이팀명
  FROM team  t2,
       team  t1
       JOIN stadium st ON t1.stadium_id LIKE st.stadium_id
       JOIN schedule sc ON st.stadium_id LIKE sc.STADIUM_ID
 WHERE sc.sche_date LIKE '20120317' AND t2.team_id LIKE sc.awayteam_id;

  SELECT T.TEAM_NAME        팀이름,
         S.STADIUM_NAME     스타디움,
         K.AWAYTEAM_ID      원정팀ID,
         K.SCHE_DATE        일정
    FROM TEAM T
         JOIN STADIUM S ON T.STADIUM_ID LIKE S.STADIUM_ID
         JOIN SCHEDULE K ON S.STADIUM_ID LIKE K.STADIUM_ID
   WHERE K.SCHE_DATE LIKE '20120317'
ORDER BY T.TEAM_NAME;

-- sql 테스트 013 :
-- 2012년 3월 17일 경기에
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함),
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오

SELECT p.player_name                           선수명,
       p.position                              포지션,
       t.region_name || ' ' || t.team_name     팀명,
       stadium_name                            스타디움,
       sche_date                               스케줄날짜
  FROM schedule  sc
       JOIN stadium st ON sc.stadium_id LIKE st.stadium_id
       JOIN team t ON t.stadium_id LIKE st.stadium_id
       JOIN player p ON t.team_id LIKE p.team_id
 WHERE     sc.sche_date LIKE '20120317'
       AND t.team_id LIKE 'K03'
       AND p.position LIKE 'GK';

--sql 테스트 014 :
-- 홈팀이 3점이상 차이로 승리한 경기의
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오

  SELECT st.stadium_name                           스타디움,
         sc.sche_date                              경기날짜,
         t1.region_name || ' ' || t1.team_name     홈팀,
         t2.region_name || ' ' || t2.team_name     원정팀,
         home_score                                "홈팀 점수",
         away_score                                "원정팀 점수"
    FROM team t1
         JOIN stadium st ON t1.stadium_id LIKE st.stadium_id
         JOIN schedule sc ON st.stadium_id LIKE sc.stadium_id
         JOIN team t2 ON t2.team_id LIKE sc.awayteam_id
   WHERE sc.home_score - sc.away_score >= 3
ORDER BY sc.sche_date;

  SELECT S.STADIUM_NAME                            스타디움,
         K.SCHE_DATE                               경기날짜,
         HT.REGION_NAME || ' ' || HT.TEAM_NAME     홈팀,
         AT.REGION_NAME || ' ' || AT.TEAM_NAME     원정팀,
         K.HOME_SCORE                              "홈팀 점수",
         K.AWAY_SCORE                              "원정팀 점수"
    FROM SCHEDULE K
         JOIN STADIUM S ON K.STADIUM_ID LIKE S.STADIUM_ID
         JOIN TEAM HT ON K.HOMETEAM_ID LIKE HT.TEAM_ID
         JOIN TEAM AT ON K.AWAYTEAM_ID LIKE AT.TEAM_ID
   WHERE K.HOME_SCORE >= K.AWAY_SCORE + 3
ORDER BY K.SCHE_DATE;

--sql 테스트 015 :
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
-- 카운트 값은 20 , 일산 밑에 마산, 안양도 있음

  SELECT st.stadium_name,
         st.stadium_id,
         st.seat_count,
         st.hometeam_id,
         t.e_team_name
    FROM stadium st LEFT JOIN team t ON t.stadium_id LIKE st.stadium_id
ORDER BY st.hometeam_id;

-- SOCCER_SQL_016
-- 소속이 삼성블루윙즈 팀인 선수들과
-- 드래곤즈팀인 선수들의 선수 정보

SELECT T.TEAM_NAME       팀명,
       P.PLAYER_NAME     선수명,
       P.POSITION        포지션,
       P.BACK_NO         백넘버,
       P.HEIGHT          키
  FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE T.TEAM_ID IN ('K02', 'K07')                                  -- K02 K07
;
-- SOCCER_SQL_017
-- 소속이 삼성블루윙즈 팀인 선수들과
-- 드래곤즈팀인 선수들의 선수 정보
-- 아이디 모를 때

  SELECT T.TEAM_NAME       팀명,
         P.PLAYER_NAME     선수명,
         P.POSITION        포지션,
         P.BACK_NO         백넘버,
         P.HEIGHT          키
    FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
   WHERE T.TEAM_ID IN
             ((SELECT TEAM_ID
                 FROM TEAM T
                WHERE T.TEAM_NAME IN ('삼성블루윙즈', '드래곤즈')))
ORDER BY T.TEAM_NAME;

--SOCCER_SQL_018
--최호진 선수의 소속팀과 포지션, 백넘버는 무엇입니까?

SELECT P.PLAYER_NAME     선수명,
       T.TEAM_NAME       팀명,
       P.POSITION        포지션,
       P.BACK_NO         백넘버
  FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE P.PLAYER_NAME LIKE '최호진';



-- 019
-- 대전시티즌의 MF 평균키는 얼마입니까

SELECT ROUND (AVG (P.HEIGHT), 2)     평균키
  FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE T.TEAM_NAME LIKE '시티즌' AND P.POSITION LIKE 'MF';

-- 020
-- 2012년 월별 경기수를 구하시오

SELECT (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '03')
           "3월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '04')
           "4월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '05')
           "5월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '06')
           "6월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '07')
           "7월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '08')
           "8월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '09')
           "9월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '10')
           "10월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '11')
           "11월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '12')
           "12월"
  FROM DUAL;


SELECT COUNT (SC.SCHE_DATE)
  FROM SCHEDULE SC
 WHERE SC.SCHE_DATE LIKE '201203%';

-- 021
-- 2012년 월별 진행된 경기수(GUBUN IS YES)를 구하시오
-- 출력은 1월:20경기 이런식으로...

SELECT (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE     SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '03'
               AND SCHEDULE.GUBUN LIKE 'Y')
           "3월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE     SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '04'
               AND SCHEDULE.GUBUN LIKE 'Y')
           "4월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE     SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '05'
               AND SCHEDULE.GUBUN LIKE 'Y')
           "5월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE     SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '06'
               AND SCHEDULE.GUBUN LIKE 'Y')
           "6월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE     SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '07'
               AND SCHEDULE.GUBUN LIKE 'Y')
           "7월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE     SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '08'
               AND SCHEDULE.GUBUN LIKE 'Y')
           "8월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE     SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '09'
               AND SCHEDULE.GUBUN LIKE 'Y')
           "9월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE     SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '10'
               AND SCHEDULE.GUBUN LIKE 'Y')
           "10월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE     SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '11'
               AND SCHEDULE.GUBUN LIKE 'Y')
           "11월",
       (SELECT COUNT (*)
          FROM SCHEDULE
         WHERE     SUBSTR (SCHEDULE.SCHE_DATE, 5, 2) LIKE '12'
               AND SCHEDULE.GUBUN LIKE 'Y')
           "12월"
  FROM DUAL;

-- 022
-- 2012년 9월 14일에 벌어질 경기는 어디와 어디입니까
-- 홈팀: ?   원정팀: ? 로 출력

SELECT SC.SCHE_DATE     경기날짜,
       T1.TEAM_NAME     홈팀,
       T2.TEAM_NAME     어웨이팀
  FROM SCHEDULE  SC
       JOIN TEAM T1 ON SC.HOMETEAM_ID LIKE T1.TEAM_ID
       JOIN TEAM T2 ON SC.AWAYTEAM_ID LIKE T2.TEAM_ID
 WHERE SC.SCHE_DATE LIKE '20120914';

-- 023
-- Group by 사용
-- 팀별 선수의 수
-- 아이파크 20명
-- 드래곤즈 19명

  SELECT T.TEAM_NAME 팀명, COUNT (P.PLAYER_ID) 선수인원
    FROM TEAM T JOIN PLAYER P ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY T.TEAM_ID, T.TEAM_NAME
ORDER BY T.TEAM_ID;

  SELECT (SELECT TEAM_NAME
            FROM TEAM
           WHERE TEAM_ID LIKE T.TEAM_ID)
             팀명,
         COUNT (P.PLAYER_ID)
             선수인원
    FROM TEAM T JOIN PLAYER P ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY T.TEAM_ID
ORDER BY T.TEAM_ID;

-- 024
-- Group by 사용
-- 팀별 골키퍼의 평균 키
-- 아이파크 180CM
-- 드래곤즈 178CM

  SELECT T.TEAM_NAME 팀명,                                 --P.POSITION 포지션,
         AVG (P.HEIGHT) 키
    FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
   WHERE P.POSITION LIKE 'GK'
GROUP BY T.TEAM_NAME
--P.POSITION
ORDER BY T.TEAM_NAME
;

DESC team;
DESC schedule;
DESC PLAYER;

SELECT *
  FROM schedule
 WHERE schedule.SCHE_DATE LIKE '201210%';

SELECT * FROM team;

SELECT * FROM stadium;

SELECT * FROM PLAYER;

-- NVL2는 오라클꺼 ... 대신 이걸 사용해라

-- SQL024
SELECT PLAYER_NAME
           이름,
       CASE
           WHEN POSITION IS NULL THEN '없음'                  -- 한글을 달 수 있다.
           WHEN POSITION LIKE 'GK' THEN '골키퍼'
           WHEN POSITION LIKE 'DF' THEN '수비수'
           WHEN POSITION LIKE 'MF' THEN '미드필더'
           WHEN POSITION LIKE 'FW' THEN '공격수'
           ELSE POSITION                                            -- DEFAULT
       END
           포지션                                                   -- 아이아스
  FROM PLAYER
 WHERE TEAM_ID = 'K08';


---- IN VERSION

  SELECT ROWNUM            "NO.",                 -- DEFAULT가 INSERT INTO 순서인듯
         T.TEAM_NAME       팀명,
         P.PLAYER_NAME     선수명,
         P.POSITION        포지션,
         P.BACK_NO         백넘버,
         P.HEIGHT          키
    FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
   WHERE         --T.TEAM_NAME LIKE '삼성블루윙즈' <- 유니크한 키값이라는 걸 알수가 없어 PK가 아니기때문에
                                                         -- 항상 PK로 제약조건을 걸도록 해
         T.TEAM_ID LIKE
             (SELECT TEAM_ID
                FROM TEAM
               WHERE TEAM_NAME LIKE ('삼성블루윙즈'))
ORDER BY P.HEIGHT DESC;


---- IN VERSION 2

SELECT 
    ROWNUM "NO.",
    A.*
FROM (  SELECT T.TEAM_NAME       팀명,
                 P.PLAYER_NAME     선수명,
                 P.POSITION        포지션,
                 P.BACK_NO         백넘버,
                 P.HEIGHT          키
            FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
           WHERE T.TEAM_ID LIKE
                     (SELECT TEAM_ID
                        FROM TEAM
                       WHERE TEAM_NAME LIKE ('삼성블루윙즈')
                       AND P.HEIGHT IS NOT NULL)
                        ORDER BY P.HEIGHT DESC) A
;

----SQL025-1
-- 삼성블루윙즈에서 키순으로  TOP 10 출력  
-- ROWNUM 10번까지 뽑으세요

SELECT 
    ROWNUM "NO.",
    A.*
FROM (SELECT T.TEAM_NAME       팀명,
                 P.PLAYER_NAME     선수명,
                 P.POSITION        포지션,
                 P.BACK_NO         백넘버,
                 P.HEIGHT          키
      FROM PLAYER P 
          JOIN TEAM T 
              ON P.TEAM_ID LIKE T.TEAM_ID
      WHERE 
        T.TEAM_ID LIKE (SELECT TEAM_ID
                        FROM TEAM
                        WHERE TEAM_NAME LIKE '삼성블루윙즈'
                            AND P.HEIGHT IS NOT NULL
                        )
      ORDER BY P.HEIGHT DESC) A
WHERE 
    ROWNUM <= 10;
;

----SQL025-2
-- 삼성블루윙즈에서 키순으로  TOP 10 출력  
-- ROWNUM 10번부터 20번까지를 뽑으세요
SELECT
    B.*
FROM
    (SELECT 
        ROWNUM NO,
        A.*
     FROM (SELECT T.TEAM_NAME       팀명,
                 P.PLAYER_NAME     선수명,
                 P.POSITION        포지션,
                 P.BACK_NO         백넘버,
                 P.HEIGHT          키
            FROM PLAYER P 
                JOIN TEAM T 
                    ON P.TEAM_ID LIKE T.TEAM_ID
     WHERE 
        T.TEAM_ID LIKE (SELECT TEAM_ID
                        FROM TEAM
                        WHERE TEAM_NAME LIKE '삼성블루윙즈'
                            AND P.HEIGHT IS NOT NULL
                        )
     ORDER BY P.HEIGHT DESC) A) B
WHERE 
    B.NO BETWEEN 10 AND 20;
;

-- 026
-- 팀별 골키퍼의 평균 키에서
-- 가장 평균키가 큰 팀명은
SELECT 
    B.팀이름
FROM
    (SELECT 
    ROWNUM "No",
    A.팀명 팀이름
FROM (
    SELECT
         T.TEAM_NAME 팀명,                               
         AVG (P.HEIGHT) 평균키
    FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
    WHERE P.POSITION LIKE 'GK'
    GROUP BY T.TEAM_NAME
    ORDER BY 평균키 DESC
    ) A) B
WHERE
    ROWNUM LIKE 1
;




-- 027
-- 각 구단별 선수들 평균키가 삼성 블루윙즈팀의
-- 평균키보다 작은 팀의 이름과 해당 팀의 평균키를 
-- 구하시오
SELECT 
    A.팀명,
    ROUND(A.평균키,2) 평균키
FROM
   (
    SELECT
         T.TEAM_NAME 팀명,                               
         AVG (P.HEIGHT) 평균키
    FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
    GROUP BY T.TEAM_NAME
    ORDER BY 평균키 DESC
    ) A
WHERE
   A.평균키 < (SELECT AVG(P.HEIGHT)
               FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
               WHERE T.TEAM_NAME LIKE '삼성블루윙즈'
               GROUP BY T.TEAM_NAME )
;


SELECT * FROM SCHEDULE;




-- 028
-- 2012년 경기 중에서 점수차가 가장 큰 경기 전부

SELECT
    A.*
FROM
    (SELECT  HT.TEAM_NAME 홈팀,
           AT.TEAM_NAME 어웨이팀,
           SC.HOME_SCORE 홈팀점수,
           SC.AWAY_SCORE 어웨이팀점수,
           ABS(SC.HOME_SCORE-SC.AWAY_SCORE) 점수차
     FROM SCHEDULE SC
          JOIN STADIUM ST
            ON SC.STADIUM_ID LIKE ST.STADIUM_ID
          JOIN TEAM HT
            ON HT.TEAM_ID LIKE SC.HOMETEAM_ID
          JOIN TEAM AT
            ON AT.TEAM_ID LIKE SC.AWAYTEAM_ID
     WHERE SC.GUBUN LIKE 'Y'
     ORDER BY 점수차 DESC) A
     
WHERE
  A.점수차 LIKE (SELECT MAX(X.점수차)
                 FROM(
                 SELECT ABS(SC.HOME_SCORE-SC.AWAY_SCORE) 점수차
                 FROM SCHEDULE SC
                 GROUP BY ABS(SC.HOME_SCORE-SC.AWAY_SCORE) 
                                  ) X 
                 )  
;


-- 029
-- 좌석수대로 스타디움 순서 매기기
SELECT
    ROWNUM NO,
    A.*
FROM(
SELECT ST.STADIUM_NAME,
       ST.SEAT_COUNT
FROM STADIUM ST
ORDER BY ST.SEAT_COUNT DESC
) A
;
-- 030
-- 2012년 구단 승리 순으로 순위매기기
SELECT A.결과,
      COUNT(*) 승리수
FROM(
    SELECT 
            CASE
                WHEN SC.HOME_SCORE - SC.AWAY_SCORE > 0 THEN HT.TEAM_NAME
                WHEN SC.AWAY_SCORE - SC.HOME_SCORE > 0 THEN AT.TEAM_NAME
                ELSE 'DL'
            END 결과               
    FROM
        SCHEDULE SC
          JOIN STADIUM ST 
            ON SC.STADIUM_ID LIKE ST.STADIUM_ID
          JOIN TEAM HT
            ON HT.TEAM_ID LIKE SC.HOMETEAM_ID
          JOIN TEAM AT
            ON AT.TEAM_ID LIKE SC.AWAYTEAM_ID 
            ) A
WHERE
     A.결과 NOT LIKE 'DL'       
GROUP BY
     A.결과
ORDER BY 승리수 DESC
;



---------------------------------------------------------------------------------------------------

-- SOCCER_SQL_001

SELECT COUNT (*) "테이블의 수" FROM TAB;

-- SOCCER_SQL_002

  SELECT TEAM_NAME     "전체 축구팀 목록"
    FROM TEAM
ORDER BY TEAM_NAME DESC;

-- SOCCER_SQL_003
-- 포지션 종류(중복제거,없으면 신입으로 기재)
-- NVL2()

SELECT DISTINCT NVL2 (POSITION, POSITION, '신입')     "포지션"
  FROM PLAYER;

-- SOCCER_SQL_004
-- 수원팀(ID: K02)골키퍼

  SELECT PLAYER_NAME     이름
    FROM PLAYER
   WHERE TEAM_ID = 'K02' AND POSITION = 'GK'
ORDER BY PLAYER_NAME;

-- SOCCER_SQL_005
-- 수원팀(ID: K02)키가 170 이상 선수
-- 이면서 성이 고씨인 선수

  SELECT POSITION 포지션, PLAYER_NAME 이름
    FROM PLAYER
   WHERE     HEIGHT >= 170
         AND TEAM_ID LIKE 'K02'
         AND SUBSTR (PLAYER_NAME, 0, 1) LIKE '고'
ORDER BY PLAYER_NAME;

-- SUBSTR('홍길동',2,2) 하면
-- 길동이 출력되는데
-- 앞2는 시작위치, 뒤2는 글자수를 뜻함

SELECT SUBSTR (PLAYER_NAME, 2, 2) 테스트값 FROM PLAYER;

-- 다른 풀이(권장)

  SELECT POSITION 포지션, PLAYER_NAME 이름
    FROM PLAYER
   WHERE HEIGHT >= 170 AND TEAM_ID LIKE 'K02' AND PLAYER_NAME LIKE '고%'
ORDER BY PLAYER_NAME;

-- SOCCER_SQL_006
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 CM 와 KG 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- 키 내림차순

  SELECT PLAYER_NAME || '선수'              이름,
         NVL2 (HEIGHT, HEIGHT, 0) || 'CM'     키,
         NVL2 (WEIGHT, WEIGHT, 0) || 'KG'     몸무게
    FROM PLAYER
   WHERE TEAM_ID LIKE 'K02'
ORDER BY HEIGHT DESC;

-- SOCCER_SQL_007
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 CM 와 KG 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- BMI지수
-- 키 내림차순

  SELECT PLAYER_NAME || '선수'
             이름,
         NVL2 (HEIGHT, HEIGHT, 0) || 'CM'
             키,
         NVL2 (WEIGHT, WEIGHT, 0) || 'KG'
             몸무게,
         ROUND (WEIGHT / ((HEIGHT / 100) * (HEIGHT / 100)), 2)
             "BMI 비만지수"
    FROM PLAYER
   WHERE TEAM_ID = 'K02'
ORDER BY HEIGHT DESC;

-- SOCCER_SQL_008
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- GK 포지션인 선수
-- 팀명, 사람명 오름차순

  SELECT T.TEAM_NAME, P.POSITION, P.PLAYER_NAME
    FROM PLAYER P, TEAM T
   WHERE     T.TEAM_ID = P.TEAM_ID
         AND T.TEAM_ID IN ('K02', 'K10')
         AND P.POSITION LIKE 'GK'
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;

-- ANSI JOIN 사용(권장)

  SELECT T.TEAM_NAME, P.POSITION, P.PLAYER_NAME
    FROM PLAYER P INNER JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
   WHERE T.TEAM_ID IN ('K02', 'K10') AND P.POSITION LIKE 'GK'
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;

-- SOCCER_SQL_009
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- 키가 180 이상 183 이하인 선수들
-- 키, 팀명, 사람명 오름차순

  SELECT P.HEIGHT || 'CM' 키, T.TEAM_NAME 팀명, P.PLAYER_NAME 이름
    FROM PLAYER P, TEAM T
   WHERE     T.TEAM_ID = P.TEAM_ID
         AND T.TEAM_ID IN ('K02', 'K10')
         AND P.HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT, T.TEAM_NAME, P.PLAYER_NAME;

-- ANSI JOIN 사용(권장)

  SELECT P.HEIGHT || 'CM' 키, T.TEAM_NAME 팀명, P.PLAYER_NAME 이름
    FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
   WHERE T.TEAM_ID IN ('K02', 'K10') AND P.HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT, T.TEAM_NAME, P.PLAYER_NAME;

-- SOCCER_SQL_010
--  모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순

  SELECT T.TEAM_NAME, P.PLAYER_NAME
    FROM PLAYER P, TEAM T
   WHERE P.POSITION IS NULL
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;

-- SOCCER_SQL_011
-- 팀이름, 스타디움 이름 출력

  SELECT T.TEAM_NAME 팀명, S.STADIUM_NAME 스타디움
    FROM STADIUM S JOIN TEAM T ON T.STADIUM_ID LIKE S.STADIUM_ID
ORDER BY T.TEAM_NAME;

-- SOCCER_SQL_012
-- 2012년 3월 17일에 열린 각 경기의
-- 팀이름, 스타디움, 어웨이팀 이름 출력



-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함),
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오

  SELECT P.PLAYER_NAME                            선수명,
         P.POSITION                               포지션,
         T.REGION_NAME || '  ' || T.TEAM_NAME     팀명,
         S.STADIUM_NAME                           스타디움,
         K.SCHE_DATE                              스케줄날짜
    FROM TEAM T
         JOIN STADIUM S ON T.STADIUM_ID LIKE S.STADIUM_ID
         JOIN PLAYER P ON T.TEAM_ID LIKE P.TEAM_ID
         JOIN SCHEDULE K ON S.STADIUM_ID LIKE K.STADIUM_ID
   WHERE     K.SCHE_DATE LIKE '20120317'
         AND P.POSITION LIKE 'GK'
         AND S.STADIUM_NAME LIKE '포항스틸야드'
ORDER BY P.PLAYER_NAME;

-- SOCCER_SQL_014
-- 홈팀이 3점이상 차이로 승리한 경기의
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오

  SELECT S.STADIUM_NAME                             스타디움,
         K.SCHE_DATE                                경기날짜,
         HT.REGION_NAME || '  ' || HT.TEAM_NAME     홈팀,
         AT.REGION_NAME || '  ' || AT.TEAM_NAME     원정팀,
         K.HOME_SCORE                               "홈팀 점수",
         K.AWAY_SCORE                               "원정팀 점수"
    FROM SCHEDULE K
         JOIN STADIUM S ON K.STADIUM_ID LIKE S.STADIUM_ID
         JOIN TEAM HT ON K.HOMETEAM_ID LIKE HT.TEAM_ID
         JOIN TEAM AT ON K.AWAYTEAM_ID LIKE AT.TEAM_ID
   WHERE K.HOME_SCORE >= K.AWAY_SCORE + 3
ORDER BY K.SCHE_DATE;

-- SOCCER_SQL_015
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록

  SELECT S.STADIUM_NAME,
         S.STADIUM_ID,
         S.SEAT_COUNT,
         S.HOMETEAM_ID,
         T.E_TEAM_NAME
    FROM STADIUM S LEFT JOIN TEAM T ON S.HOMETEAM_ID LIKE T.TEAM_ID
ORDER BY S.HOMETEAM_ID;

-- SOCCER_SQL_016
-- 소속이 삼성 블루윙즈 팀인 선수들과
-- 전남 드래곤즈팀인 선수들의 선수 정보
---- UNION VERSION

SELECT T.TEAM_NAME       팀명,
       P.PLAYER_NAME     선수명,
       P.POSITION        포지션,
       P.BACK_NO         백넘버,
       P.HEIGHT          키
  FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE T.TEAM_ID LIKE 'K02'
UNION
SELECT T.TEAM_NAME       팀명,
       P.PLAYER_NAME     선수명,
       P.POSITION        포지션,
       P.BACK_NO         백넘버,
       P.HEIGHT          키
  FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE T.TEAM_ID LIKE 'K07';

---- OR VERSION

SELECT T.TEAM_NAME       팀명,
       P.PLAYER_NAME     선수명,
       P.POSITION        포지션,
       P.BACK_NO         백넘버,
       P.HEIGHT          키
  FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE T.TEAM_ID LIKE 'K02' OR T.TEAM_ID LIKE 'K07';

---- IN VERSION

SELECT T.TEAM_NAME       팀명,
       P.PLAYER_NAME     선수명,
       P.POSITION        포지션,
       P.BACK_NO         백넘버,
       P.HEIGHT          키
  FROM PLAYER P JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
 WHERE T.TEAM_ID IN ('K02', 'K07');

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