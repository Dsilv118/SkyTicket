package com.lec.skyticket.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lec.skyticket.dto.BoardDto;

public class BoardDao {
	public static int SUCCESS = 1;
	public static int FAIL    = 0;
	private static BoardDao INSTANCE = new BoardDao();
	public static BoardDao getInstance() {
		return INSTANCE;
	}
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		Context ctx;
		try {
			ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle11g");
			conn = ds.getConnection();
		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}
	// -- 1. 글 목록 (startRow ~ endRow)
	public ArrayList<BoardDto> list(int startRow, int endRow) {
		ArrayList<BoardDto> bdto = new ArrayList<BoardDto>();
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT * " + 
					 "    FROM (SELECT ROWNUM RW, A.* FROM (SELECT B.*, MkNAME " + 
					 "                                        FROM BOARD B, MEMBER M " + 
					 "                                        WHERE B.mID = M.mID " + 
					 "                                        ORDER BY BGROUP DESC, BSTEP) A) " + 
					 "    WHERE RW BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int bid         = rs.getInt("bid");
				String mid      = rs.getString("mid");
				String bsubject = rs.getString("bsubject");
				String bcontent = rs.getString("bcontent");
				String bfile    = rs.getString("bfile");
				String bip      = rs.getString("bip");
				int bgroup      = rs.getInt("bgroup");
				int bstep       = rs.getInt("bstep");
				int bindent     = rs.getInt("bindent");
				Date brdate     = rs.getDate("brdate");
				String mkname    = rs.getString("mkname");
				bdto.add(new BoardDto(bid, mid, bsubject, bcontent, bfile, bip, bgroup, bstep, bindent, brdate, mkname));
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "list 오류");
		} finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return bdto;
	}
	// -- 2. 등록된 글 갯수  
	public int getBoardTotCnt() {
		int totCnt = 0;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT COUNT(*) FROM BOARD";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "totCnt 오류");
		} finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return totCnt;
	}
	// -- 3. 원글쓰기
	public int write(BoardDto bDto) {
		int result = FAIL;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO BOARD (bID, mID, bSUBJECT, bCONTENT, bFILE, bIP, bGROUP, bSTEP, bINDENT) " + 
					 "    VALUES (BOARD_SEQ.NEXTVAL, ?, ?, ?, ?, ?, BOARD_SEQ.CURRVAL, 0, 0)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bDto.getMid());
			pstmt.setString(2, bDto.getBsubject());
			pstmt.setString(3, bDto.getBcontent());
			pstmt.setString(4, bDto.getBfile());
			pstmt.setString(5, bDto.getBip());
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("원글쓰기 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "원글쓰기 실패");
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		} 
		return result;
	}
	// -- 4. 글번호로 글 전체 내용(BoardDto) 가져오기 (글 상세보기)
	public BoardDto content(int bid) {
		BoardDto dto = null;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT B.*, mkNAME " + 
					 "    FROM BOARD B, MEMBER M " + 
					 "    WHERE B.mID = M.mID AND bID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String mid = rs.getString("mid");
				String bsubject = rs.getString("bsubject");
				String bcontent = rs.getString("bcontent");
				String bfile = rs.getString("bfile");
				String bip = rs.getString("bip");
				int bgroup = rs.getInt("bgroup");
				int bstep = rs.getInt("bstep");
				int bindent = rs.getInt("bindent");
				Date brdate = rs.getDate("brdate");
				String mkname = rs.getString("mkname");
				dto = new BoardDto(bid, mid, bsubject, bcontent, bfile, bip, bgroup, bstep, bindent, brdate, mkname);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return dto;
	}
	// -- 5. 답변글 쓰기 전 작업 
	private void preReplyStep(int bgroup, int bstep) {
		Connection         conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE BOARD " + 
					 "    SET bSTEP = bSTEP + 1 " + 
					 "    WHERE bGROUP = ? AND bSTEP > ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bgroup);
			pstmt.setInt(2, bstep);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "preReplyStep에서 오류");
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		} 
	}
	// -- 6. 답변글 쓰기
	public int replyBoard(BoardDto bDto) {
		int result = FAIL;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO BOARD (bID, mID, bSUBJECT, bCONTENT, bFILE, bIP, bGROUP, bSTEP, bINDENT) " + 
					 "    VALUES (BOARD_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bDto.getMid());
			pstmt.setString(2, bDto.getBsubject());
			pstmt.setString(3, bDto.getBcontent());
			pstmt.setString(4, bDto.getBfile());
			pstmt.setString(5, bDto.getBip());
			pstmt.setInt(6, bDto.getBgroup());
			pstmt.setInt(7, bDto.getBstep()+1);
			pstmt.setInt(8, bDto.getBindent()+1);
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("원글쓰기 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "원글쓰기 실패");
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		} 
		return result;
	}
	// -- 7. 글 삭제하기
	public int deleteBoard(int bid) {
		int result = FAIL;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM BOARD WHERE bID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bid);
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "글 삭제 성공" : "글 삭제 실패");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "글 삭제 실패");
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		} 
		return result;		
	}
	// -- 8. 회원탈퇴시 탈퇴하는 회원(mid)이 쓴 글 모두 삭제하기 (return값 void)
	public void deleteAllBoard(String mid) {
		Connection         conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM BOARD\r\n" + 
				"    WHERE mID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			int result = pstmt.executeUpdate();
			System.out.println(result != FAIL ? "글 삭제 성공" : "글 삭제 실패");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "글 삭제 실패");
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		} 		
	}
	// -- 9. 특정 아이디 전체 글 갯수
	public int getMsBoardTotCnt(String mid) {
		int totCnt = 0;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT COUNT(*) FROM BOARD WHERE MID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			rs.next();
			totCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "totCnt 오류");
		} finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return totCnt;
	}
	// -- 10. 특정 아이디 문의 게시글 리스트 출력
	public ArrayList<BoardDto> list(int startRow, int endRow, String mid) {
		ArrayList<BoardDto> bdto = new ArrayList<BoardDto>();
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT * " + 
					 "    FROM (SELECT ROWNUM RW, A.* FROM (SELECT B.*, MkNAME " + 
					 "                                        FROM BOARD B, MEMBER M " + 
					 "                                        WHERE B.mID = M.mID AND M.mID = ? " + 
					 "                                        ORDER BY BGROUP DESC, BSTEP) A) " + 
					 "    WHERE RW BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int bid         = rs.getInt("bid");
				String bsubject = rs.getString("bsubject");
				String bcontent = rs.getString("bcontent");
				String bfile    = rs.getString("bfile");
				String bip      = rs.getString("bip");
				int bgroup      = rs.getInt("bgroup");
				int bstep       = rs.getInt("bstep");
				int bindent     = rs.getInt("bindent");
				Date brdate     = rs.getDate("brdate");
				String mkname   = rs.getString("mkname");
				bdto.add(new BoardDto(bid, mid, bsubject, bcontent, bfile, bip, bgroup, bstep, bindent, brdate, mkname));
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "list 오류");
		} finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return bdto;
	}
	// -- 11. 글 수정하기
	public int modify(int bid, String bsubject, String bcontent, String bfile, String bip, Date brdate) {
		int result = FAIL;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE BOARD SET BSUBJECT = ?, " + 
					 "                 BCONTENT = ?, " + 
					 "                 BFILE = ?, " + 
					 "                 BIP = ?, " + 
					 "                 BRDATE = ? " + 
					 "    WHERE BID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bsubject);
			pstmt.setString(2, bcontent);
			pstmt.setString(3, bfile);
			pstmt.setString(4, bip);
			pstmt.setDate(5, brdate);
			pstmt.setInt(6, bid);
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "글 수정 성공" : "글 번호(BID) 오류");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "글 수정 실패");
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		} 
		return result;
	}
}

















