package com.hellocat.vo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AfterPurchase implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "hellocat";
		String pw = "1234";
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
		} catch(ClassNotFoundException e) {
			System.out.println("JDBC드라이버 로딩 실패");			
		} catch(SQLException e) {
			System.out.println("Oracle 접속 실패");						
		}
		HttpSession session = request.getSession();
		String userid = (String)session.getAttribute("user_id");
		String rem = request.getParameter("rememberAdd");
		String add_num = request.getParameter("add_num");
		String add_short = request.getParameter("add_short1");
		add_short += "*";
		add_short += request.getParameter("add_short2");
		String add_long = request.getParameter("add_long");
		String sql = "UPDATE userdata SET add_num=?,add_long=?,add_short=? WHERE id=?";
		if(rem.equals("yes")) {
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, add_num);
				pstmt.setString(2, add_long);
				pstmt.setString(3, add_short);
				pstmt.setString(4, userid);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else {}
		String buynow = request.getParameter("buynow");
		if(buynow.equals("no")) {
			Enumeration<String> params = request.getParameterNames();
			while(params.hasMoreElements()) {
				String name = (String)params.nextElement();
				sql = "DELETE FROM like_product WHERE name=? AND user_id=?";
				PreparedStatement pstmt;
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,name);
					pstmt.setString(2,userid);
					pstmt.executeUpdate();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		} else {}
		Enumeration<String> params = request.getParameterNames();
		int addsale = 1;
		while(params.hasMoreElements()) {
			int sales = -1;
			sql = "SELECT sales FROM product WHERE name=?";
			String name = (String)params.nextElement();
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					sales = rs.getInt(1);
					addsale = Integer.parseInt(request.getParameter(name));
				}
				if(sales!=-1) {
					sql = "UPDATE product SET sales=? WHERE name=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, sales+addsale);
					pstmt.setString(2, name);
					pstmt.executeUpdate();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		RequestDispatcher rd = request.getRequestDispatcher("HCController?command=storemain");
		rd.forward(request, response);
	}
}