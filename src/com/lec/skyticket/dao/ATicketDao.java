package com.lec.skyticket.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lec.skyticket.dto.ATicketDto;

public class ATicketDao {
	public static int SUCCESS   = 1;
	public static int FAIL      = 0;
	public static int NONE_DUPLI    = 1;
	public static int DUPLI         = 0;
	private static ATicketDao INSTANCE = new ATicketDao();
	public static ATicketDao getInstance() {
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
	// -- 1. 항공권 추가
	public int insertTicket(ATicketDto atDto) {
		int result = FAIL;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT ALL " + 
						"INTO PLANE (PLNUM, PLCOM, pLCOMCODE, PLNAME, PLSEAT) " + 
						"    VALUES (PL_SEQ.NEXTVAL, ?, ?, ?, ?) " + 
						"INTO AIRLINE_TICKET (atID, ACTNAME, DCTNAME, pLNUM, atPRICE, atATIME, atDTIME, atPHOTO) " + 
						"    VALUES (AT_SEQ.NEXTVAL, ?, ?, PL_SEQ.CURRVAL, ?, ?, ?, ?) " + 
					 "SELECT * FROM DUAL";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, atDto.getPlcom());
			pstmt.setString(2, atDto.getPlcomcode());
			pstmt.setString(3, atDto.getPlname());
			pstmt.setInt(4, atDto.getPlseat());
			pstmt.setString(5, atDto.getActname());
			pstmt.setString(6, atDto.getDctname());
			pstmt.setInt(7, atDto.getAtprice());
			pstmt.setTimestamp(8, atDto.getAtatime());
			pstmt.setTimestamp(9, atDto.getAtdtime());
			pstmt.setString(10, atDto.getAtphoto());
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("항공권 등록 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "항공권 등록 실패");
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
	// -- 2. 도시와 도시코드 정보 맞는지 확인
	public int cityConfirm(String ctname, String ctcode) {
		int result = DUPLI;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT * FROM CITY WHERE ctNAME = ? AND ctCODE = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ctname);
			pstmt.setString(2, ctcode);
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
	// -- 3-1. 항공권 정리 (시간이 지난 예약 티켓 삭제)
	public void cleanMemberTicket() {
		Connection         conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM MEMBER_TICKET MT " + 
					 "    WHERE MT.atID IN (SELECT atID FROM AIRLINE_TICKET " + 
					 "                        WHERE (TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHHMI') > TO_CHAR(atATIME, 'YYYYMMDDHHMI')))";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			int result = pstmt.executeUpdate();
			System.out.println(result + "개 삭제 완료");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "예약 티켓 정리 실패");
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		} 		
	}
	// -- 3-2. 항공권 정리 (시간이 지난 항공권 삭제)
	public void cleanAirlineTicket() {
		Connection         conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM AIRLINE_TICKET " + 
					 "    WHERE (TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHHMI') > TO_CHAR(atATIME, 'YYYYMMDDHHMI'))";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			int result = pstmt.executeUpdate();
			System.out.println(result + "개 삭제 완료");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "항공권 정리 실패");
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		} 		
	}
	// -- 4. 항공권 삭제 (admin 계정에서 항공권 삭제 / 수정 --> 하나라도 예약이 되어있으면 삭제 / 수정 불가능)
	public void deleteTicket(int atid) {
		Connection         conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM AIRLINE_TICKET " + 
					 "    WHERE atID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, atid);
			int result = pstmt.executeUpdate();
			System.out.println(result != FAIL ? "항공권 삭제 성공" : "항공권 삭제 실패");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "항공권 삭제 실패");
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		} 		
	}
	// -- 5. 항공권 갯수 파악 
	public int getATicketCnt(Timestamp atatime, String actname, String dctname) {
		int totCnt = 0;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT COUNT(*) " + 
					 "    FROM AIRLINE_TICKET AT, CITY C1, CITY C2 " + 
					 "    WHERE AT.actNAME = C1.ctNAME AND AT.dctNAME = C2.ctNAME AND " + 
					 "         (TO_CHAR(AT.atATIME, 'YYYYMMDD') LIKE '%'||(TO_CHAR(?, 'YYYYMMDD'))||'%') AND " + 
					 "         AT.ACTNAME LIKE '%'||?||'%' AND AT.DCTNAME LIKE '%'||?||'%'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setTimestamp(1, atatime);
			pstmt.setString(2, actname);
			pstmt.setString(3, dctname);
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
	// -- 6. 항공권 검색 후 리스트 뿌리기 (startRow ~ endRow)
	public ArrayList<ATicketDto> list(int startRow, int endRow, Timestamp atatime, String actname, String dctname) {
		ArrayList<ATicketDto> atdto = new ArrayList<ATicketDto>();
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT *    " + 
					 "    FROM (SELECT ROWNUM RW, A.* FROM (SELECT AT.*, C1.ctCODE actCODE, C2.ctCODE dctCODE, pLCOM, pLCOMCODE, pLNAME, pLSEAT " + 
					 "                                        FROM AIRLINE_TICKET AT, CITY C1, CITY C2, PLANE P " + 
					 "                                        WHERE AT.actNAME = C1.ctNAME AND AT.dctNAME = C2.ctNAME AND AT.pLNUM = P.pLNUM AND " + 
					 "                                             (TO_CHAR(AT.atATIME, 'YYYYMMDD') LIKE '%'||(TO_CHAR(?, 'YYYYMMDD'))||'%') AND " + 
					 "                                              AT.ACTNAME LIKE '%'||?||'%' AND AT.DCTNAME LIKE '%'||?||'%' " + 
					 "                                        ORDER BY AT.atATIME) A) " + 
					 "    WHERE RW BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setTimestamp(1, atatime);
			pstmt.setString(2, actname);
			pstmt.setString(3, dctname);
			pstmt.setInt(4, startRow);
			pstmt.setInt(5, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int atid          = rs.getInt("atid");
				int plnum         = rs.getInt("plnum");
				int atprice       = rs.getInt("atprice");
				Timestamp atdtime = rs.getTimestamp("atdtime");
				String atphoto    = rs.getString("atphoto");
				String actcode    = rs.getString("actcode");
				String dctcode    = rs.getString("dctcode");
				String plcom      = rs.getString("plcom");
				String plcomcode  = rs.getString("plcomcode");
				String plname     = rs.getString("plname");
				int plseat        = rs.getInt("plseat");
				atdto.add(new ATicketDto(atid, actname, dctname, plnum, atprice, atatime, atdtime, atphoto, actcode, dctcode, plcom, plcomcode, plname, plseat));
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
		return atdto;
	}
	// -- 7. 항공권 상세보기
	public ATicketDto getMember(int atid) {
		ATicketDto dto = null;
		Connection        conn = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT AT.*, C1.ctCODE actCODE, C2.ctCODE dctCODE, pLCOM, pLCOMCODE, pLNAME, pLSEAT " + 
					 "    FROM AIRLINE_TICKET AT, CITY C1, CITY C2, PLANE P " + 
					 "    WHERE AT.actNAME = C1.ctNAME AND AT.dctNAME = C2.ctNAME AND AT.pLNUM = P.pLNUM AND atID = ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, atid);
			rs    = pstmt.executeQuery();
			if(rs.next()) {
				String actname    = rs.getString("actname");
				String dctname    = rs.getString("dctname");
				int plnum         = rs.getInt("plnum");
				int atprice       = rs.getInt("atprice");
				Timestamp atatime = rs.getTimestamp("atatime");
				Timestamp atdtime = rs.getTimestamp("atdtime");
				String atphoto    = rs.getString("atphoto");
				String actcode    = rs.getString("actcode");
				String dctcode    = rs.getString("dctcode");
				String plcom      = rs.getString("plcom");
				String plcomcode  = rs.getString("plcomcode");
				String plname     = rs.getString("plname");
				int plseat        = rs.getInt("plseat");
				dto = new ATicketDto(atid, actname, dctname, plnum, atprice, atatime, atdtime, atphoto, plcom, plcomcode, plname, plseat);
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
	// -- 8. 좌석이 매진된 항공권은 매진 표시 (pLNUM으로 자리 가져오기)
	public int seatChk(int plnum) {
		int totSeat = 0;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT pLSEAT FROM PLANE WHERE pLNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, plnum);
			rs = pstmt.executeQuery();	
			totSeat = rs.getInt(1);
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
		return totSeat;
	}
}

































