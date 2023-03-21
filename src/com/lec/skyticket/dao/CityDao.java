package com.lec.skyticket.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CityDao {
	public static int NONE_DUPLI    = 1;
	public static int DUPLI         = 0;
	private static CityDao INSTANCE = new CityDao();
	public static CityDao getInstance() {
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
	// -- 1. 도시와 도시코드 정보 맞는지 확인
	public int cityConfirm(String ctname) {
		int result = DUPLI;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT * FROM CITY WHERE ctNAME = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ctname);
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
}
