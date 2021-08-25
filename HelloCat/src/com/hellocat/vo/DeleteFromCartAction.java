package com.hellocat.vo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
@WebServlet("/DeleteFromCartAction")
public class DeleteFromCartAction extends HttpServlet implements Action {

	private static final long serialVersionUID = 1L;

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
		Enumeration<String> params = request.getParameterNames();
		while(params.hasMoreElements()) {
			String name = (String)params.nextElement();
			String sql = "DELETE FROM like_product WHERE name=? AND user_id=?";
			PreparedStatement pstmt;
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,name);
				pstmt.setString(2,userId);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		out.print(obj);
	}
}
