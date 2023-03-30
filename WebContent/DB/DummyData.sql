----------------------------- DUMMY DATA INSERT --------------------------------
------------------------------ MEMBER & ADMIN ----------------------------------
INSERT INTO ADMIN (adID, adPW, adNAME, adTEL)
    VALUES ('admin', '111', '관리자', '010-0000-0000');

INSERT INTO MEMBER (mID, mPW, mkNAME, meNAME, mTEL, mEMAIL, mBIRTH, mGENDER, mNATION)
    VALUES ('aaa', '111', '홍길동', 'HongGilDong', '010-1111-1111', 'hong@naver.com', '1998-02-21', 'F', '한국');
INSERT INTO MEMBER (mID, mPW, mkNAME, meNAME, mTEL, mEMAIL, mBIRTH, mGENDER, mNATION)
    VALUES ('bbb', '111', '임길동', 'LimGilDong', '010-2222-2222', 'lim@naver.com', '1998-01-18', 'M', '한국');
INSERT INTO MEMBER (mID, mPW, mkNAME, meNAME, mTEL, mEMAIL, mBIRTH, mGENDER, mNATION)
    VALUES ('ccc', '111', '정길동', 'JungGilDong', '010-3333-3333', 'jung@naver.com', '1995-11-12', 'F', '중국');
    
----------------------------------- CITY ---------------------------------------
INSERT INTO CITY (ctNAME, ctCODE)   
    VALUES ('인천', 'ICN');              
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('김포', 'GMP');
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('제주', 'CJU');
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('세부', 'CBE');
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('도쿄', 'TYO');
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('방콕', 'BKK');
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('런던', 'LON');
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('제네바', 'GVA');
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('로마', 'ROM');    
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('오사카', 'ITM');   
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('후쿠오카', 'FUK');   
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('베이징', 'BJS');   
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('뉴욕', 'NYC');   
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('LA', 'LAX');   
---------------------------------- AIRLINE -------------------------------------
INSERT INTO PLANE (pLNUM, pLCOM, pLCOMCODE, pLNAME, pLSEAT)
    VALUES (PL_SEQ.NEXTVAL, '루프트한자', 'LH', 'Airbus A380', 310);
INSERT INTO PLANE (pLNUM, pLCOM, pLCOMCODE, pLNAME, pLSEAT)
    VALUES (PL_SEQ.NEXTVAL, '제주항공', '7C', 'Airbus A320', 182);
INSERT INTO PLANE (pLNUM, pLCOM, pLCOMCODE, pLNAME, pLSEAT)
    VALUES (PL_SEQ.NEXTVAL, '아시아나항공', 'OZ', 'Boeing B737', 120);
INSERT INTO PLANE (pLNUM, pLCOM, pLCOMCODE, pLNAME, pLSEAT)
    VALUES (PL_SEQ.NEXTVAL, '대한항공', 'KE', 'Boeing B787', 245);
INSERT INTO PLANE (pLNUM, pLCOM, pLCOMCODE, pLNAME, pLSEAT)
    VALUES (PL_SEQ.NEXTVAL, '진에어', 'LJ', 'Boeing B737', 0);
INSERT INTO PLANE (pLNUM, pLCOM, pLCOMCODE, pLNAME, pLSEAT)
    VALUES (PL_SEQ.NEXTVAL, '에어서울', 'RS', 'Airbus A320', 3);
INSERT INTO PLANE (pLNUM, pLCOM, pLCOMCODE, pLNAME, pLSEAT)
    VALUES (PL_SEQ.NEXTVAL, '에어부산', 'BX', 'Airbus A320', 51);
INSERT INTO PLANE (pLNUM, pLCOM, pLCOMCODE, pLNAME, pLSEAT)
    VALUES (PL_SEQ.NEXTVAL, '대한항공', 'KE', 'Airbus A380', 4);
INSERT INTO PLANE (pLNUM, pLCOM, pLCOMCODE, pLNAME, pLSEAT)
    VALUES (PL_SEQ.NEXTVAL, '티웨이', 'TW', 'Airbus A330', 2);
    
------------------------------ AIRLINE TICKET ----------------------------------
INSERT INTO AIRLINE_TICKET (atID, aCTNAME, dCTNAME, pLNUM, atPRICE, atATIME, atDTIME)
    VALUES ('LH'||10||AT_SEQ.NEXTVAL, '인천', '로마', 10, 1532400, '2023-04-20 10:00', '2023-04-20 23:30');
INSERT INTO AIRLINE_TICKET (atID, aCTNAME, dCTNAME, pLNUM, atPRICE, atATIME, atDTIME)
    VALUES ('7C'||13||AT_SEQ.NEXTVAL, '김포', '방콕', 13, 326200, '2023-04-12 16:00', '2023-04-13 22:30');
INSERT INTO AIRLINE_TICKET (atID, aCTNAME, dCTNAME, pLNUM, atPRICE, atATIME, atDTIME)
    VALUES ('OZ'||16||AT_SEQ.NEXTVAL, '인천', '세부', 16, 469800, '2023-05-21 10:00', '2023-05-21 14:30');
INSERT INTO AIRLINE_TICKET (atID, aCTNAME, dCTNAME, pLNUM, atPRICE, atATIME, atDTIME)
    VALUES ('KE'||19||AT_SEQ.NEXTVAL, '인천', '제네바', 19, 1149800, '2023-04-30 23:00', '2023-05-01 16:30');
INSERT INTO AIRLINE_TICKET (atID, aCTNAME, dCTNAME, pLNUM, atPRICE, atATIME, atDTIME)
    VALUES ('LJ'||22||AT_SEQ.NEXTVAL, '인천', '오사카', 22, 321900, '2023-05-12 15:00', '2023-05-12 17:30');
INSERT INTO AIRLINE_TICKET (atID, aCTNAME, dCTNAME, pLNUM, atPRICE, atATIME, atDTIME)
    VALUES ('RS'||25||AT_SEQ.NEXTVAL, '김포', '후쿠오카', 25, 209800, '2023-05-20 11:00', '2023-05-20 13:00');
INSERT INTO AIRLINE_TICKET (atID, aCTNAME, dCTNAME, pLNUM, atPRICE, atATIME, atDTIME)
    VALUES ('BX'||28||AT_SEQ.NEXTVAL, '인천', '도쿄', 28, 129800, '2023-05-20 11:00', '2023-05-20 14:00');
INSERT INTO AIRLINE_TICKET (atID, aCTNAME, dCTNAME, pLNUM, atPRICE, atATIME, atDTIME)
    VALUES ('KE'||31||AT_SEQ.NEXTVAL, '인천', '뉴욕', 31, 109800, '2023-04-01 11:20', '2023-04-02 04:30');
INSERT INTO AIRLINE_TICKET (atID, aCTNAME, dCTNAME, pLNUM, atPRICE, atATIME, atDTIME)
    VALUES ('TW'||34||AT_SEQ.NEXTVAL, '김포', '오사카', 34, 382000, '2023-04-04 09:50', '2023-04-04 12:30');
    
------------------------------- MEMBER TICKET ----------------------------------    
INSERT INTO MEMBER_TICKET (rvNUM, atID, mID, mtSEAT, mtSERVICE)
    VALUES (MEMBER_SEQ.NEXTVAL || TO_CHAR(SYSDATE, 'MMDD'), 'LH101', 'aaa', 1, '이유식');
INSERT INTO MEMBER_TICKET (rvNUM, atID, mID, mtSEAT, mtSERVICE)
    VALUES (MEMBER_SEQ.NEXTVAL || TO_CHAR(SYSDATE, 'MMDD'), '7C132', 'bbb', 2, '특별식');
INSERT INTO MEMBER_TICKET (rvNUM, atID, mID, mtSEAT, mtSERVICE)
    VALUES (MEMBER_SEQ.NEXTVAL || TO_CHAR(SYSDATE, 'MMDD'), 'OZ163', 'ccc', 1, null);
    
----------------------------------- BOARD --------------------------------------    
INSERT INTO BOARD (bID, mID, bSUBJECT, bCONTENT, bFILE, bIP, bGROUP, bSTEP, bINDENT)
    VALUES (BOARD_SEQ.NEXTVAL, 'aaa', '제목이야1', '본문이야1', null, '192-222-12', BOARD_SEQ.CURRVAL, 0, 0);
INSERT INTO BOARD (bID, mID, bSUBJECT, bCONTENT, bFILE, bIP, bGROUP, bSTEP, bINDENT)
    VALUES (BOARD_SEQ.NEXTVAL, 'bbb', '제목이야2', '본문이야2', null, '953-522-0', BOARD_SEQ.CURRVAL, 0, 0);
INSERT INTO BOARD (bID, mID, bSUBJECT, bCONTENT, bFILE, bIP, bGROUP, bSTEP, bINDENT)
    VALUES (BOARD_SEQ.NEXTVAL, 'aaa', '제목1의 답변입니다', '본문1의 답변이야', 'NOIMAGE.JPG', '342-202-10', 1, 1, 1);

SELECT * FROM CITY;
SELECT * FROM PLANE;
SELECT * FROM AIRLINE_TICKET;  
SELECT * FROM MEMBER_TICKET;
SELECT * FROM ADMIN;
SELECT * FROM MEMBER;
SELECT * FROM BOARD;
            
ROLLBACK;
COMMIT;









    