package com.lec.skyticket.dao;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ATicketDao {
	public static int SUCCESS = 1;
	public static int FAIL    = 0;
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
}
