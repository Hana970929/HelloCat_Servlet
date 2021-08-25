package com.hellocat.vo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class InsertReviewAction implements Action{

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
		String pdid = request.getParameter("pdid");
		int score = Integer.parseInt(request.getParameter("score"));
		String content = request.getParameter("rvcontent");
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("user_id");
		String sql = "INSERT INTO review(pd_id, writer, content, bno, score)" + 
				"VALUES(?,?,?,REVIEW_BNO.nextval,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pdid);
			pstmt.setString(2, userId);
			pstmt.setString(3, content);
			pstmt.setInt(4,score);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		RequestDispatcher rd = request.getRequestDispatcher("HCController?command=storemain");
		rd.forward(request, response);
	}

}
