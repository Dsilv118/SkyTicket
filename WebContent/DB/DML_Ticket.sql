-------------------------------- CITY QUERY ------------------------------------
-- 1. 도시와 도시코드 정보 맞는지 확인
SELECT * FROM CITY WHERE ctNAME = '인천' AND ctCODE = 'ICN';

--------------------------------- PLANE QUERY ----------------------------------
-- 1. 항공사, 비행기 추가하기 
INSERT INTO PLANE (PLNUM, PLCOM, pLCOMCODE, PLNAME, PLSEAT) 
    VALUES (PL_SEQ.NEXTVAL, '이스타항공', 'ZE', 'B-737', 150);
    
-- 2. 항공사, 비행기 plcom으로 가져오기
SELECT * FROM PLANE WHERE pLCOM='이스타항공';
-------------------------------- AIRLINE QUERY ---------------------------------
-- 1. 같은 날짜에 같은 출발도시 같은 도착도시 같은 가격 있는지 확인
SELECT * FROM AIRLINE_TICKET 
    WHERE TRUNC(TO_CHAR(atATIME, 'YYYYMMDD')) = TRUNC(TO_CHAR(atATIME, 'YYYYMMDD'))
          AND ACTNAME = '인천' AND DCTNAME = '제주' AND atPRICE = 55000;
          
-- 2. 항공권 추가
INSERT INTO AIRLINE_TICKET (atID, ACTNAME, DCTNAME, pLNUM, atPRICE, atATIME, atDTIME, atPHOTO)
    VALUES (AT_SEQ.NEXTVAL, '인천', '런던', 301, 1200000, '2020-03-20 10:00', '2020-03-21 11:30', 'NOIMAGE.JPG');

-- 3. 항공권 수정
UPDATE AIRLINE_TICKET SET atPRICE = 40000, atPHOTO = 'NOIMAGE.PNG'
    WHERE atID = 1;
-- 4. 항공권 정리 (시간이 지난 항공권들 삭제, 항공사 등록하고 티켓 등록은 안한 항공사들 삭제) --> 메인페이지 갈때마다 실행
    -- 4-1. 맴버티켓 테이블에서 현재 시간이 지난 티켓들 삭제
DELETE FROM MEMBER_TICKET MT
    WHERE MT.atID IN (SELECT atID FROM AIRLINE_TICKET 
                        WHERE TRUNC(TO_CHAR(SYSDATE, 'YYYYMMDD')) > TRUNC(TO_CHAR(atATIME, 'YYYYMMDD')));
    -- 4-2. 항공기 테이블에서 항공권 티켓 테이블로 못넘어간 자료들 삭제
DELETE FROM PLANE 
    WHERE pLNUM = (SELECT pLNUM 
                    FROM PLANE 
                    WHERE pLNUM NOT IN (SELECT AT.pLNUM 
                                            FROM AIRLINE_TICKET AT, PLANE P 
                                            WHERE AT.pLNUM = P.pLNUM));
    -- 4-3. 항공권 티켓 테이블에서 시간이 지난 티켓들 삭제
DELETE FROM AIRLINE_TICKET 
    WHERE TRUNC(TO_CHAR(SYSDATE, 'YYYYMMDD')) > TRUNC(TO_CHAR(atATIME, 'YYYYMMDD'));
    
-- 5. 항공권 삭제 (admin 계정에서 항공권 삭제 / 수정 --> 하나라도 예약이 되어있으면 삭제 / 수정 불가능)
DELETE FROM AIRLINE_TICKET 
    WHERE (1 > (SELECT COUNT(*) FROM AIRLINE_TICKET AT, MEMBER_TICKET MT WHERE AT.atID = MT.atID))
          AND atID = 1;
          
-- 6. 항공권 리스트 뿌리기 (DTO)
SELECT *, C1.ctNAME actNAME, C1.ctCODE actCODE, C2.ctNAME dctNAME, C2.ctCODE dctCODE 
    FROM AIRLINE_TICKET AT, CITY C1, CITY C2, PLANE P
    WHERE AT.actNAME = C1.ctNAME AND AT.dctNAME = C2.ctNAME AND AT.pLNUM = P.pLNUM AND atID = 1;
    
-- 7. 예약 성공
    -- 예약한 자리 차감 
UPDATE PLANE SET pLSEAT = pLSEAT - 1
    WHERE pLSEAT > 0 AND pLNUM = 303;
    -- 예약성공하면 멤버티켓 테이블로 예약 내역 추가
INSERT INTO MEMBER_TICKET (rvNUM, atID, mID, mtSERVICE)
    VALUES (MEMBER_SEQ.NEXTVAL || TO_CHAR(SYSDATE, 'MMDD') || (SELECT pLCODE FROM AIRLINE_TICKET WHERE atID=1),
            1, 'aaa', '이유식');
-------------------------------- AIRLINE QUERY ---------------------------------
-- 1. 예약 취소
    -- 1-1 예약 테이블에서 티켓 삭제 (MemberTicket)
DELETE FROM MEMBER_TICKET 
    WHERE rvNUM = 10320485;
    -- 1-2 비행기 테이블에서 삭제된 티켓 좌석 증가
UPDATE PLANE
    SET pLSEAT = (SELECT P.pLSEAT FROM MEMBER_TICKET MT, AIRLINE_TICKET AT, PLANE P 
                    WHERE MT.atID = AT.atID AND AT.pLNUM = P.pLNUM AND rVNUM = 10320) + 1
    WHERE pLNUM = (SELECT P.pLNUM FROM AIRLINE_TICKET AT, PLANE P
                    WHERE AT.pLNUM = P.pLNUM AND atID = 2);

-- 2. 예약 리스트 뿌려주기
SELECT * FROM MEMBER_TICKET MT, AIRLINE_TICKET AT
    WHERE MT.atID = AT.atID AND mID = 'aaa';
    
-- 3. 예약 내역 상세보기
SELECT * FROM MEMBER_TICKET MT, AIRLINE_TICKET AT, CITY C1, CITY C2, PLANE P
    WHERE MT.atID = AT.atID AND AT.pLNUM = P.pLNUM AND AT.actNAME = C1.ctNAME AND AT.dctNAME = C2.ctNAME;
       
       
ROLLBACK;
COMMIT;

    
    














