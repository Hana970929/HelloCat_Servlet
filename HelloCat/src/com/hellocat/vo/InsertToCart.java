package com.hellocat.vo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class InsertToCart implements Action {

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
		String userId = (String)session.getAttribute("user_id");
		String pdid = request.getParameter("pdid");
		int order_cnt = Integer.parseInt(request.getParameter("quantity"));
		String name = "";
		String explain = "";
		String photo = "";
		int order_price = 0;
		int price = 0;
		String sql = "SELECT * FROM product WHERE id=?";
		PreparedStatement pstmt;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,pdid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				name = rs.getString("name");
				explain = rs.getString("explain");
				photo = rs.getString("photo");
				price = rs.getInt("price");
			}
			order_price = price*order_cnt;
			sql = "INSERT INTO like_product(user_id,pd_id,order_cnt,name,explain,photo,order_price)"+ 
					"VALUES(?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,userId);
			pstmt.setString(2,pdid);
			pstmt.setInt(3,order_cnt);
			pstmt.setString(4,name);
			pstmt.setString(5,explain);
			pstmt.setString(6,photo);
			pstmt.setInt(7,order_price);
			pstmt.execute();
			RequestDispatcher rd = request.getRequestDispatcher("store_mainServlet");
			rd.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
