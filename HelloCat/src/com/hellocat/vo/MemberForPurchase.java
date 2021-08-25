package com.hellocat.vo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/MemberForPurchase")
public class MemberForPurchase implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "hellocat";
		String pw = "1234";
		String phone = "";
		String mail = "";
		String name = "";
		String add_num = "";
		String add_short = "";
		String add_long = "";
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
		String sql = "SELECT * FROM userdata WHERE id=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				phone = rs.getString("phone");
				mail = rs.getString("email");
				name = rs.getString("name");
				if(rs.getString("add_num")==null) {}
				else {
				add_num += rs.getString("add_num");
				add_short += rs.getString("add_short");
				add_long += rs.getString("add_long");
				}
				String phone1 = phone.substring(0,3);
				String phone2 = phone.substring(3,7);
				String phone3 = phone.substring(7);
				RequestDispatcher rd = request.getRequestDispatcher("buyproduct.jsp");
				request.setAttribute("phone1", phone1);
				request.setAttribute("phone2", phone2);
				request.setAttribute("phone3", phone3);
				request.setAttribute("mail", mail);
				request.setAttribute("name", name);
				request.setAttribute("add_num", add_num);
				request.setAttribute("add_short", add_short);
				request.setAttribute("add_long", add_long);
				rd.forward(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
