package com.lec.skyticket.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.*;
import javax.sql.DataSource;

import com.lec.skyticket.dto.AdminDto;

public class AdminDao {
	public static int SUCCESS = 1;
	public static int FAIL    = 0;
	private static AdminDao INSTANCE = new AdminDao();
	public static AdminDao getInstance() {
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
	
	// -- 1. admin 로그인
	public int loginChk(String adid, String adpw) {
		int result = FAIL;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT * FROM ADMIN WHERE ADID = ? AND ADPW = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, adid);
			pstmt.setString(2, adpw);
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
	// -- 2. 로그인 후 세션에 넣을 용도 admin aid로 AdminDto
	public AdminDto getAdmin(String adid) {
		AdminDto dto = null;
		Connection         conn = null;
		PreparedStatement pstmt = null;
		ResultSet            rs = null;
		String sql = "SELECT * FROM ADMIN WHERE ADID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, adid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String adpw   = rs.getString("adpw");
				String adname = rs.getString("adname");
				String adtel  = rs.getString("adtel");
				dto = new AdminDto(adid, adpw, adname, adtel);
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
}
