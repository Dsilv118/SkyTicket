package com.lec.skyticket.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lec.skyticket.dto.MTicketDto;

public class MTicketDao {
	public static int SUCCESS    = 1;
	public static int FAIL         = 0;
	private static MTicketDao INSTANCE = new MTicketDao();
	public static MTicketDao getInstance() {
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
	// -- 1. 예약성공 시 예약내역 추가
	public int write(MTicketDto mtDto) {
		int result = FAIL;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO MEMBER_TICKET (rvNUM, atID, mID, mtSERVICE) " + 
					 "    VALUES (MEMBER_SEQ.NEXTVAL || TO_CHAR(SYSDATE, 'MMDD'), " + 
					 "            ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mtDto.getAtid());
			pstmt.setString(2, mtDto.getMid());
			pstmt.setString(3, mtDto.getMtservice());
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("예약 추가 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "예약 추가 실패");
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
	// --2. 예약 테이블에서 티켓 삭제
	public int deleteMemberTicket(int rvnum) {
		int result = FAIL;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM MEMBER_TICKET " + 
					 "    WHERE rvNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rvnum);
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "예약 내역 삭제 성공" : "예약 내역 삭제 실패");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "예약 내역 삭제 실패");
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
	// -- 3. atID로 예약 내역 불러오기
	public int getMTicketCnt(int atid) {
		int cnt = 0;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT COUNT(*) FROM MEMBER_TICKET WHERE atID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, atid);
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1);
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
		return cnt;
	}
	// -- 4. 예약 리스트 뿌려주기
	public ArrayList<MTicketDto> memberTicketList(int startRow, int endRow, String mid) {
		ArrayList<MTicketDto> mtdto = new ArrayList<MTicketDto>();
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT *\r\n" + 
					 "    FROM (SELECT ROWNUM RW, A.* FROM (SELECT MT.*, aCTNAME, dCTNAME, ATATIME, ATDTIME " + 
					 "                                        FROM MEMBER_TICKET MT, AIRLINE_TICKET AT " + 
					 "                                        WHERE MT.atID = AT.atID AND mID = ? " + 
					 "                                        ORDER BY AT.atATIME) A) " + 
					 "    WHERE RW BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int rvnum = rs.getInt("rvnum");
				int atid  = rs.getInt("atid");
				String mtservice = rs.getString("mtservice");
				String actname = rs.getString("actname");
				String dctname = rs.getString("dctname");
				int plnum = rs.getInt("plnum");
				String atprice = rs.getString("atprice");
				Timestamp atatime = rs.getTimestamp("atatime");
				Timestamp atdtime = rs.getTimestamp("atdtime");
				String atphoto = rs.getString("atphoto");
				mtdto.add(new MTicketDto(rvnum, atid, mid, mtservice, actname, dctname, plnum, atprice, atatime, atdtime, atphoto));
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
		return mtdto;
	}
	// -- 5. 예약 내역 상세보기
	public MTicketDto memberTicketContent(int rvnum) {
		MTicketDto mtdto = null;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT MT.*, AT.*, C1.ctCODE actCODE, C2.ctCODE dctCODE, P.* " + 
					 "    FROM MEMBER_TICKET MT, AIRLINE_TICKET AT, CITY C1, CITY C2, PLANE P " + 
					 "    WHERE MT.atID = AT.atID AND AT.pLNUM = P.pLNUM AND AT.actNAME = C1.ctNAME " + 
					 "    AND AT.dctNAME = C2.ctNAME AND RVNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rvnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int atid = rs.getInt("atid");
				String mid = rs.getString("mid");
				String mtservice = rs.getString("mtservice");
				String actname = rs.getString("actname");
				String dctname = rs.getString("dctname");
				int plnum = rs.getInt("plnum");
				String atprice = rs.getString("atprice");
				Timestamp atatime = rs.getTimestamp("atatime");
				Timestamp atdtime = rs.getTimestamp("atdtime");
				String atphoto = rs.getString("atphoto");
				String actcode = rs.getString("actcode");
				String dctcode = rs.getString("dctcode");
				String plcom = rs.getString("plcom");
				String plcomcode = rs.getString("plcomcode");
				String plname = rs.getString("plname");
				mtdto = new MTicketDto(rvnum, atid, mid, mtservice, actname, dctname, plnum, atprice, 
									   atatime, atdtime, atphoto, actcode, dctcode, plcom, plcomcode, plname);
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
		return mtdto;
	}
}






















