package com.lec.skyticket.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lec.skyticket.dto.MemberDto;

public class MemberDao {
	public static int SUCCESS = 1;
	public static int FAIL    = 0;
	public static int DUPLI         = 0;
	public static int NONE_DUPLI    = 1;
	private static MemberDao INSTANCE = new MemberDao();
	public static MemberDao getInstance() {
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
	// -- 1. id 중복 체크
	public int midConfirm(String mid) {
		int result = DUPLI;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT * FROM MEMBER WHERE mID=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();	
			if(rs.next()) {
				result = DUPLI;
			} else {
				result = NONE_DUPLI;
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// -- 2. 이메일 중복 체크
	public int memailConfirm(String memail) {
		int result = DUPLI;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT * FROM MEMBER WHERE mEMAIL=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memail);
			rs = pstmt.executeQuery();	
			if(rs.next()) {
				result = DUPLI;
			} else {
				result = NONE_DUPLI;
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// -- 3. 전화번호 중복 체크
	public int mtelConfirm(String mtel) {
		int result = DUPLI;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT * FROM MEMBER WHERE mTEL=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mtel);
			rs = pstmt.executeQuery();	
			if(rs.next()) {
				result = DUPLI;
			} else {
				result = NONE_DUPLI;
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// -- 4. 회원가입
	public int joinMember(MemberDto dto) {
		int result = FAIL;
		Connection        conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO MEMBER (mID, mPW, mkNAME, meNAME, mTEL, mEMAIL, mBIRTH, mGENDER, mNATION)\r\n" + 
					 "    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMid());
			pstmt.setString(2, dto.getMpw());
			pstmt.setString(3, dto.getMkname());
			pstmt.setString(4, dto.getMename());
			pstmt.setString(5, dto.getMtel());
			pstmt.setString(6, dto.getMemail());
			pstmt.setDate(7, dto.getMbirth());
			pstmt.setString(8, dto.getMgender());
			pstmt.setString(9, dto.getMnation());
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS ? "회원가입 성공" : "회원가입 실패");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			System.out.println("회원가입 실패 : " + dto);
		} finally {
			try {
				if(pstmt !=null) pstmt.close();
				if(conn  !=null) conn.close();
			} catch(Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// -- 5. login check
	public int loginChk(String mid, String mpw) {
		int result = FAIL;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT * FROM MEMBER WHERE mID=? AND mPW=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, mpw);
			rs = pstmt.executeQuery();	
			if(rs.next()) {
				result = SUCCESS;
				System.out.println("로그인 성공");
			} else {
				result = FAIL;
				System.out.println("로그인 실패");
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// -- 6. id로 MemberDto 가져오기
	public MemberDto getMember(String mid) {
		MemberDto dto = null;
		Connection        conn = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM MEMBER WHERE mID=?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs    = pstmt.executeQuery();
			if(rs.next()) {
				String mpw     = rs.getString("mpw");
				String mkname  = rs.getString("mkname");
				String mename  = rs.getString("mename");
				String mtel    = rs.getString("mtel");
				String memail  = rs.getString("memail");
				Date mbirth    = rs.getDate("mbirth");
				String mgender = rs.getString("mgender");
				String mnation = rs.getString("mnation");
				dto = new MemberDto(mid, mpw, mkname, mename, mtel, memail, mbirth, mgender, mnation);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}  finally {
			try {
				if(rs    !=null) rs.close();
				if(pstmt !=null) pstmt.close();
				if(conn  !=null) conn.close();
			} catch(Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return dto;
	}
	// -- 7. 회원정보 수정
	public int modifyMember(MemberDto dto) {
		int result = FAIL;
		Connection        conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE MEMBER SET mPW = ?, " + 
					 "                  mkNAME = ?, " + 
					 "                  meNAME = ?, " + 
					 "                  mTEL = ?, " + 
					 "                  mEMAIL = ?, " + 
					 "                  mNATION = ? " + 
					 "    WHERE mid = ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMpw());
			pstmt.setString(2, dto.getMkname());
			pstmt.setString(3, dto.getMename());
			pstmt.setString(4, dto.getMtel());
			pstmt.setString(5, dto.getMemail());
			pstmt.setString(6, dto.getMnation());
			pstmt.setString(7, dto.getMid());
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS ? "회원정보 수정 성공" : "회원정보 수정 실패");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			System.out.println("회원정보 수정 실패 : " + dto);
		} finally {
			try {
				if(pstmt !=null) pstmt.close();
				if(conn  !=null) conn.close();
			} catch(Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// -- 8. 회원탈퇴 하기전 회원이 예약한 티켓이 있나 확인
	public int mdeleteChk(String mid) {
		int result = FAIL;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT * FROM MEMBER_TICKET WHERE mID=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();	
			if(rs.next()) {
				result = FAIL;
			} else {
				result = SUCCESS;
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// -- 9. 회원탈퇴
	public int withdrawalMember(String mid) {
		int result = FAIL;
		Connection        conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM MEMBER WHERE mID=?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS ? "회원정보 삭제 성공" : "회원정보 삭제 실패");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			System.out.println("예외발생 : 회원정보 삭제 실패");
		} finally {
			try {
				if(pstmt !=null) pstmt.close();
				if(conn  !=null) conn.close();
			} catch(Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
}
































