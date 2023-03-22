------------------------------------ ADMIN -------------------------------------
-- 1. 로그인 체크 
SELECT * FROM ADMIN WHERE ADID = 'admin' AND ADPW = '111';

-- 2. 세션에 넣을 용도
SELECT * FROM ADMIN WHERE ADID = 'admin';
------------------------------------ MEMBER ------------------------------------
-- 1. id 중복체크
SELECT * FROM MEMBER WHERE mID='aaa';

-- 2. 회원 EMAIL 중복체크
SELECT * FROM MEMBER WHERE mEMAIL='hong@hong.com';

-- 3. 회원 tel 중복체크
SELECT * FROM MEMBER WHERE mTEL='010-2222-2222';

-- 4. MEMBER 회원가입
INSERT INTO MEMBER (mID, mPW, mkNAME, meNAME, mTEL, mEMAIL, mBIRTH, mGENDER, mNATION)
    VALUES ('ddd', '111', '김길동', 'KimGilDong', '010-9999-9999', 'kim@naver.com', '1998-02-12', 'M', '미국');
    
-- 5. 로그인 체크
SELECT * FROM MEMBER WHERE mID='aaa' AND mPW='111';

-- 6. id로 Dto 가져오기
SELECT * FROM MEMBER WHERE mID='aaa';
    
-- 7. 회원수정
UPDATE MEMBER SET mPW = '111',
                  mkNAME = '왕길동',
                  meNAME = 'WANG',
                  mTEL = '010-2222-2222',
                  mEMAIL = 'wang@wang.com',
                  mNATION = '한국'
    WHERE mid = 'aaa';

--8. 회원탈퇴 하기전 회원이 예약한 티켓이 있나 확인
SELECT * FROM MEMBER_TICKET WHERE mID='aaa';

-- 9. 회원탈퇴
DELETE FROM MEMBER WHERE mID='aaa';

---------------------------------- BOARD ---------------------------------------
-- 1. 글 목록(startRow ~ endRow)
SELECT * 
    FROM (SELECT ROWNUM RW, A.* FROM (SELECT B.*, MkNAME 
                                        FROM BOARD B, MEMBER M
                                        WHERE B.mID = M.mID
                                        ORDER BY BGROUP DESC, BSTEP) A)
    WHERE RW BETWEEN 1 AND 7;

-- 2. 등록된 글 갯수
SELECT COUNT(*) FROM BOARD;

-- 3. 원글 쓰기
INSERT INTO BOARD (bID, mID, bSUBJECT, bCONTENT, bFILE, bIP, bGROUP, bSTEP, bINDENT)
    VALUES (BOARD_SEQ.NEXTVAL, 'aaa', '제목이야', '본문이야', 'NOIMAGE.JPG', '192-222-12', BOARD_SEQ.CURRVAL, 0, 0);
    
-- 4. 글 번호 (bID)로 글 전체 내용 가져오기
SELECT B.*, mkNAME 
    FROM BOARD B, MEMBER M
    WHERE B.mID = M.mID AND bID = 1;
    
-- 5. 글 수정하기
UPDATE BOARD SET bSUBJECT = '수정된 제목이야',
                 bCONTENT = '수정된 본문이야',
                 bFILE    = 'NOIMAGE.JPG'
    WHERE bID = 1;
    
-- 6. 답변글 쓰기 전 작업
UPDATE BOARD
    SET bSTEP = bSTEP + 1
    WHERE bGROUP = '2' AND bSTEP > 0;

-- 7. 답변글 쓰기
INSERT INTO BOARD (bID, mID, bSUBJECT, bCONTENT, bFILE, bIP, bGROUP, bSTEP, bINDENT, bRDATE)
    VALUES (BOARD_SEQ.NEXTVAL, 'aaa', '답변이야', '답변본문이야', 'NOIMAGE.JPG', '202-221-22-2', 1, 1, 1, '2020-02-28');

-- 8. 글 삭제하기
DELETE FROM BOARD WHERE bID = '1';

-- 9. 회원탈퇴시 탈퇴하는 회원이 쓴 글 모두 삭제하기
DELETE FROM BOARD
    WHERE mID = 'aaa';

-- 10. 글 검색기능
SELECT * 
    FROM BOARD 
    WHERE bSUBJECT LIKE '%'||'이야'||'%' AND bSTEP = 0;
    
SELECT * 
    FROM (SELECT ROWNUM RW, A.*
            FROM (SELECT * 
                    FROM BOARD
                    WHERE bSUBJECT LIKE '%'||'이야'||'%' AND bSTEP = 0
                    ORDER BY BGROUP DESC, BSTEP) A)
    WHERE RW BETWEEN 1 AND 1;




















