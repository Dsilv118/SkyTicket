-------------------------------- AIRLINE QUERY ---------------------------------
-- 1. 항공권 추가
INSERT ALL 
INTO PLANE (PLNUM, PLCOM, pLCOMCODE, PLNAME, PLSEAT) 
    VALUES (PL_SEQ.NEXTVAL, '이스타항공', 'ZE', 'B-737', 150)
INTO AIRLINE_TICKET (atID, ACTNAME, DCTNAME, pLNUM, atPRICE, atATIME, atDTIME)
    VALUES ('ZE'||PL_SEQ.CURRVAL||AT_SEQ.NEXTVAL, '인천', '런던', PL_SEQ.CURRVAL, 1200000, '2020-03-20 10:00', '2020-03-21 11:30')
SELECT * FROM DUAL;

-- 2. 도시와 도시코드 정보 맞는지 확인
SELECT * FROM CITY WHERE ctNAME = '인천';

    
-- 3. 항공권 정리 (시간이 지난 항공권들 삭제, 항공사 등록하고 티켓 등록은 안한 항공사들 삭제) --> 리스트 검색마다 실행
    -- 3-1. 맴버티켓 테이블에서 현재 시간이 지난 티켓들 삭제
DELETE FROM MEMBER_TICKET MT
    WHERE MT.atID IN (SELECT atID FROM AIRLINE_TICKET 
                        WHERE (TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHHMI') > TO_CHAR(atATIME, 'YYYYMMDDHHMI')));
                            
    -- 3-2. 항공권 티켓 테이블에서 시간이 지난 티켓들 삭제
DELETE FROM AIRLINE_TICKET 
    WHERE (TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHHMI') > TO_CHAR(atATIME, 'YYYYMMDDHHMI'));

    -- 3-3. 항공권에서 삭제된 티켓의 비행기 삭제
DELETE FROM PLANE
    WHERE pLNUM NOT IN (SELECT P.pLNUM FROM AIRLINE_TICKET AT, PLANE P 
                            WHERE AT.pLNUM = P.pLNUM);
    
-- 4. 항공권 삭제 (admin 계정에서 항공권 삭제 / 수정 --> 하나라도 예약이 되어있으면 삭제 / 수정 불가능)
DELETE FROM AIRLINE_TICKET 
    WHERE (0 = (SELECT COUNT(*) FROM MEMBER_TICKET WHERE atID = 'OZ8'))
    AND atID = 'OZ8';

-- 5. 항공권 총 갯수 파악
SELECT COUNT(*) 
    FROM AIRLINE_TICKET AT, CITY C1, CITY C2
    WHERE AT.actNAME = C1.ctNAME AND AT.dctNAME = C2.ctNAME AND
         (TO_CHAR(AT.atATIME, 'YYYYMMDD') LIKE '%'||(TO_CHAR(null, 'YYYYMMDD'))||'%') AND
         AT.ACTNAME LIKE '%'||''||'%' AND AT.DCTNAME LIKE '%'||''||'%';

-- 6. 항공권 검색 후 리스트 뿌리기 (DTO)    
SELECT *    
    FROM (SELECT ROWNUM RW, A.* FROM (SELECT AT.*, C1.ctCODE actCODE, C2.ctCODE dctCODE, pLCOM, pLCOMCODE, pLNAME, pLSEAT
                                        FROM AIRLINE_TICKET AT, CITY C1, CITY C2, PLANE P
                                        WHERE AT.actNAME = C1.ctNAME AND AT.dctNAME = C2.ctNAME AND AT.pLNUM = P.pLNUM AND 
                                             (TO_CHAR(AT.atATIME, 'YYYYMMDD') LIKE '%'||(TO_CHAR(null, 'YYYYMMDD'))||'%') AND
                                              AT.ACTNAME LIKE '%'||''||'%' AND AT.DCTNAME LIKE '%'||''||'%'
                                        ORDER BY AT.atATIME) A)
    WHERE RW BETWEEN 1 AND 5;

-- 7. 항공권 상세보기
SELECT AT.*, C1.ctCODE actCODE, C2.ctCODE dctCODE, pLCOM, pLCOMCODE, pLNAME, pLSEAT
    FROM AIRLINE_TICKET AT, CITY C1, CITY C2, PLANE P
    WHERE AT.actNAME = C1.ctNAME AND AT.dctNAME = C2.ctNAME AND AT.pLNUM = P.pLNUM AND atID = 'LH101';
    
-- 8. 좌석이 매진된 항공권은 매진 표시
SELECT pLSEAT FROM PLANE WHERE pLNUM = 300;
    
-------------------------------- AIRLINE QUERY ---------------------------------
-- 1. 예약 성공
    -- 예약성공하면 멤버티켓 테이블로 예약 내역 추가
INSERT INTO MEMBER_TICKET (rvNUM, atID, mID, mtSEAT, mtSERVICE)
    VALUES (MEMBER_SEQ.NEXTVAL || TO_CHAR(SYSDATE, 'MMDD'),
            1, 'aaa', 1, '이유식');
    -- 예약한 자리 차감 
UPDATE PLANE SET pLSEAT = pLSEAT - 1
    WHERE pLSEAT > 0 AND pLNUM = (SELECT AT.pLNUM FROM AIRLINE_TICKET AT, PLANE P
                                     WHERE AT.pLNUM = P.pLNUM AND AT.atID = 2);

-- 1. 예약 취소
    -- 1-1 예약 테이블에서 티켓 삭제 (MemberTicket)
DELETE FROM MEMBER_TICKET 
    WHERE rvNUM = 10320485;
    
    -- 1-2 비행기 테이블에서 삭제된 티켓 좌석 증가
UPDATE PLANE
    SET pLSEAT = (SELECT P.pLSEAT FROM MEMBER_TICKET MT, AIRLINE_TICKET AT, PLANE P 
                    WHERE MT.atID = AT.atID AND AT.pLNUM = P.pLNUM AND rVNUM = 10330) + 1
    WHERE pLNUM = (SELECT P.pLNUM FROM AIRLINE_TICKET AT, PLANE P
                    WHERE AT.pLNUM = P.pLNUM AND atID = 'LH101');

-- 2. 예약 리스트 뿌려주기
SELECT *
    FROM (SELECT ROWNUM RW, A.* FROM (SELECT MT.*, aCTNAME, dCTNAME, ATATIME, ATDTIME, ATPRICE
                                        FROM MEMBER_TICKET MT, AIRLINE_TICKET AT
                                        WHERE MT.atID = AT.atID AND mID = 'aaa'
                                        ORDER BY AT.atATIME) A)
    WHERE RW BETWEEN 1 AND 1;
    
-- 3. 예약 내역 상세보기
SELECT MT.*, M.MKNAME, AT.*, C1.ctCODE actCODE, C2.ctCODE dctCODE, P.* 
    FROM MEMBER_TICKET MT, MEMBER M, AIRLINE_TICKET AT, CITY C1, CITY C2, PLANE P
    WHERE MT.mID = M.mID AND MT.atID = AT.atID AND AT.pLNUM = P.pLNUM AND AT.actNAME = C1.ctNAME 
    AND AT.dctNAME = C2.ctNAME AND RVNUM = 10330;

-- 4. 항공권 삭제할때 atid로 예약된 내역 있는지 확인
SELECT COUNT(*) FROM MEMBER_TICKET WHERE mID = 'aaa';
       
            
ROLLBACK;
COMMIT;
















