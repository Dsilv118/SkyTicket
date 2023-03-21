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
    VALUES ('LA', 'LAX');
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('도쿄', 'TYO');
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('베이징', 'BJS');
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('런던', 'LON');
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('파리', 'PAR');
INSERT INTO CITY (ctNAME, ctCODE) 
    VALUES ('로마', 'ROM');    
---------------------------------- AIRLINE -------------------------------------
INSERT INTO PLANE (pLNUM, pLCOM, pLCOMCODE, pLNAME, pLSEAT)
    VALUES (PL_SEQ.NEXTVAL, '대한항공', 'KE', 'B787', 245);
INSERT INTO PLANE (pLNUM, pLCOM, pLCOMCODE, pLNAME, pLSEAT)
    VALUES (PL_SEQ.NEXTVAL, '아시아나항공', 'OZ', 'B777', 225);
INSERT INTO PLANE (pLNUM, pLCOM, pLCOMCODE, pLNAME, pLSEAT)
    VALUES (PL_SEQ.NEXTVAL, '제주항공', '7C', 'A320', 182);
INSERT INTO PLANE (pLNUM, pLCOM, pLCOMCODE, pLNAME, pLSEAT)
    VALUES (PL_SEQ.NEXTVAL, '진에어', 'LJ', 'B737', 0);

INSERT INTO AIRLINE_TICKET (atID, aCTNAME, dCTNAME, pLNUM, atPRICE, atATIME, atDTIME, atPHOTO)
    VALUES (AT_SEQ.NEXTVAL, '인천', '제주', 300, 55000, '2023-04-20 10:00', '2023-04-20 11:30', 'NOIMAGE.JPG');
INSERT INTO AIRLINE_TICKET (atID, aCTNAME, dCTNAME, pLNUM, atPRICE, atATIME, atDTIME, atPHOTO)
    VALUES (AT_SEQ.NEXTVAL, '인천', 'LA', 301, 890000, '2023-03-12 16:00', '2023-03-13 11:30', 'NOIMAGE.JPG');
INSERT INTO AIRLINE_TICKET (atID, aCTNAME, dCTNAME, pLNUM, atPRICE, atATIME, atDTIME, atPHOTO)
    VALUES (AT_SEQ.NEXTVAL, '김포', '런던', 302, 1200000, '2023-03-21 10:00', '2023-03-22 11:30', 'NOIMAGE.JPG');
INSERT INTO AIRLINE_TICKET (atID, aCTNAME, dCTNAME, pLNUM, atPRICE, atATIME, atDTIME, atPHOTO)
    VALUES (AT_SEQ.NEXTVAL, '베이징', '인천', 303, 500000, '2023-04-30 23:00', '2023-05-01 11:30', 'NOIMAGE.JPG');
    
INSERT INTO MEMBER_TICKET (rvNUM, atID, mID, mtSERVICE)
    VALUES (MEMBER_SEQ.NEXTVAL || TO_CHAR(SYSDATE, 'MMDD'), 2, 'aaa', '이유식');
INSERT INTO MEMBER_TICKET (rvNUM, atID, mID, mtSERVICE)
    VALUES (MEMBER_SEQ.NEXTVAL || TO_CHAR(SYSDATE, 'MMDD'), 3, 'bbb', '특별식');
INSERT INTO MEMBER_TICKET (rvNUM, atID, mID, mtSERVICE)
    VALUES (MEMBER_SEQ.NEXTVAL || TO_CHAR(SYSDATE, 'MMDD'), 4, 'ccc', null);
    
----------------------------------- BOARD --------------------------------------    
INSERT INTO BOARD (bID, mID, bSUBJECT, bCONTENT, bFILE, bIP, bGROUP, bSTEP, bINDENT)
    VALUES (BOARD_SEQ.NEXTVAL, 'aaa', '제목이야1', '본문이야1', 'NOIMAGE.JPG', '192-222-12', BOARD_SEQ.CURRVAL, 0, 0);
INSERT INTO BOARD (bID, mID, bSUBJECT, bCONTENT, bFILE, bIP, bGROUP, bSTEP, bINDENT)
    VALUES (BOARD_SEQ.NEXTVAL, 'bbb', '제목이야2', '본문이야2', 'NOIMAGE.JPG', '953-522-0', BOARD_SEQ.CURRVAL, 0, 0);
INSERT INTO BOARD (bID, mID, bSUBJECT, bCONTENT, bFILE, bIP, bGROUP, bSTEP, bINDENT)
    VALUES (BOARD_SEQ.NEXTVAL, 'bbb', '제목1의 답변이야', '본문1의 답변이야', 'NOIMAGE.JPG', '342-202-10', 1, 1, 1);

SELECT * FROM CITY;
SELECT * FROM PLANE;
SELECT * FROM AIRLINE_TICKET;  
SELECT * FROM MEMBER_TICKET;
SELECT * FROM MEMBER;
SELECT * FROM BOARD;
            
ROLLBACK;
COMMIT;










    