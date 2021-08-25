package com.hellocat.vo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ShowOnePd implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "hellocat";
		String pw = "1234";
		double sum = 0;
		double d = 0;
		DecimalFormat df = new DecimalFormat("###,###");
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("user_id");
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
		} catch(ClassNotFoundException e) {
			System.out.println("JDBC드라이버 로딩 실패");			
		} catch(SQLException e) {
			System.out.println("Oracle 접속 실패");						
		}
		String pdid = request.getParameter("id");
		String sql = "SELECT * FROM product WHERE id=?";
		PreparedStatement pstmt;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,pdid);
			ResultSet rs = pstmt.executeQuery();
			String name = null;
			int price = 0;
			int sales = 0;
			String explain = null;
			String photo = null;
			while(rs.next()) {
				name = rs.getString("name");
				price = rs.getInt("price");
				sales = rs.getInt("sales");
				explain = rs.getString("explain");
				photo = rs.getString("photo");
			}
			sql = "SELECT * FROM review WHERE pd_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pdid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int a = rs.getInt("score");
				sum += a;
				d++;
			}
			int cart = 0;
			sql = "SELECT count(*) FROM like_product WHERE user_id=? AND pd_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, pdid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				cart = rs.getInt(1);
			}
			String s_price = df.format(price);
			double avr = Math.round((sum / d) * 100.0) / 100.0;
			RequestDispatcher rd = request.getRequestDispatcher("goods_view.jsp");
			request.setAttribute("cart", cart);
			request.setAttribute("pdid", pdid);
			request.setAttribute("name", name);
			request.setAttribute("price", price);
			request.setAttribute("sales", sales);
			request.setAttribute("explain", explain);
			request.setAttribute("photo", photo);
			request.setAttribute("score", avr);
			request.setAttribute("s_price", s_price);
			rd.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
