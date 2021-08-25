package com.hellocat.vo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ShowCart implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "hellocat";
		String pw = "1234";
		int count = 1;
		DecimalFormat df = new DecimalFormat("###,###");
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
		ArrayList<LikePdVO> likeList = new ArrayList<LikePdVO>();
		String sql = "SELECT * FROM like_product WHERE user_id=?";
		PreparedStatement pstmt;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,userid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String user_id = rs.getString("user_id");
				String pdid = rs.getString("pd_id");
				int order_cnt = rs.getInt("order_cnt");
				String name = rs.getString("name");
				String explain = rs.getString("explain");
				String photo = rs.getString("photo");
				int order_price = rs.getInt("order_price");
				int price = order_price/order_cnt;
				String s_op = df.format(order_price);
				String s_price = df.format(price);
				likeList.add(new LikePdVO(user_id,pdid,order_cnt,name,explain,photo,order_price,price,s_op,s_price));
				count++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(count==1) {
			RequestDispatcher rd = request.getRequestDispatcher("cartList_empty.jsp");
			rd.forward(request, response);
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("cartList.jsp");
			request.setAttribute("likeList", likeList);
			rd.forward(request, response);
		}
	}
}
