package com.lec.skyticket.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lec.skyticket.dto.PlaneDto;

public class PlaneDao {
	public static int SUCCESS    = 1;
	public static int FAIL         = 0;
	private static PlaneDao INSTANCE = new PlaneDao();
	public static PlaneDao getInstance() {
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
	// -- 1. 항공사, 항공기 추가하기
	public int insertPlane(PlaneDto dto) {
		int result = FAIL;
		Connection        conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO PLANE (PLNUM, PLCOM, pLCOMCODE, PLNAME, PLSEAT) " + 
					 "    VALUES (PL_SEQ.NEXTVAL, ?, ?, ?, ?)";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getPlcom());
				pstmt.setString(2, dto.getPlcomcode());
				pstmt.setString(3, dto.getPlname());
				pstmt.setInt(4, dto.getPlseat());
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS ? "항공사 추가 성공" : "항공사 추가 실패");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			System.out.println("항공사 추가 실패 : " + dto);
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
	// -- 2. 항공사, 비행기 plcom으로 가져오기 
	public PlaneDto getPlane(String plcom) {
		PlaneDto dto = null;
		Connection        conn = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM PLANE WHERE pLCOM=?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, plcom);
			rs    = pstmt.executeQuery();
			if(rs.next()) {
				int plnum        = rs.getInt("plnum");
				String plname    = rs.getString("plname");
				String plcomcode = rs.getString("plcomcode");				
				int plseat       = rs.getInt("plseat");
				dto = new PlaneDto(plnum, plname, plcom, plcomcode, plseat);
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
	// -- 3. 항공권 정리
	public void deletePlane() {
		Connection         conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM PLANE " + 
					 "    WHERE pLNUM = (SELECT pLNUM " + 
					 "                    FROM PLANE " + 
					 "                    WHERE pLNUM NOT IN (SELECT AT.pLNUM " + 
					 "                                            FROM AIRLINE_TICKET AT, PLANE P " + 
					 "                                            WHERE AT.pLNUM = P.pLNUM))";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			int result = pstmt.executeUpdate();
			System.out.println(result != FAIL ? "항공사 삭제 성공" : "항공사 삭제 실패");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "항공사 삭제 실패");
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn !=null) conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		} 		
	}
	// -- 4. 예약 취소시 좌석 자리수 만큼 증가
	public int modifySeat(int rvnum, int plseat, int atid) {
		int result = FAIL;
		Connection        conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE PLANE " + 
					 "    SET pLSEAT = (SELECT P.pLSEAT FROM MEMBER_TICKET MT, AIRLINE_TICKET AT, PLANE P " + 
					 "                    WHERE MT.atID = AT.atID AND AT.pLNUM = P.pLNUM AND rVNUM = ?) + ? " + 
					 "    WHERE pLNUM = (SELECT P.pLNUM FROM AIRLINE_TICKET AT, PLANE P\r\n" + 
					 "                    WHERE AT.pLNUM = P.pLNUM AND atID = ?)";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rvnum);
			pstmt.setInt(2, plseat);
			pstmt.setInt(3, atid);
			result = pstmt.executeUpdate();
			System.out.println(result==SUCCESS ? "좌석 수정 성공" : "좌석 수정 실패");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			System.out.println("회원정보 수정 실패");
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























