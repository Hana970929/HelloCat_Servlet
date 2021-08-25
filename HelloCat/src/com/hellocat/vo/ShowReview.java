package com.hellocat.vo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShowReview implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "hellocat";
		String pw = "1234";
		String writer = "";
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
		} catch(ClassNotFoundException e) {
			System.out.println("JDBC드라이버 로딩 실패");			
		} catch(SQLException e) {
			System.out.println("Oracle 접속 실패");						
		}
		ArrayList<ReviewVO> rvList = new ArrayList<ReviewVO>();
		ArrayList<ForRvVO> numList = new ArrayList<ForRvVO>();
		int pagenum = 1;
		if(request.getParameter("page")!=null) {
			pagenum = Integer.parseInt(request.getParameter("page"));
		}
		int startpage = (pagenum-1)*5+1;
		int endpage = startpage+4;
		String productId = request.getParameter("id");
		String sql = "SELECT rownum,p2.* FROM (SELECT rownum rnum,p.* FROM " +
				"(SELECT * FROM review WHERE pd_id=? ORDER BY bno DESC)p)p2 " +
				"WHERE rnum>=? AND rnum<=?";
		PreparedStatement pstmt;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,productId);
			pstmt.setInt(2,startpage);
			pstmt.setInt(3,endpage);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String pdid = rs.getString("pd_id");
				String writer_id = rs.getString("writer");
				String sql2 = "SELECT nickname FROM userdata WHERE id=?";
				PreparedStatement pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setString(1, writer_id);
				ResultSet rs2 = pstmt2.executeQuery();
				if(rs2.next()) {
					writer = rs2.getString(1);
				}
				String writedate = rs.getString("writedate");
				String content = rs.getString("content");
				int bno = rs.getInt("bno");
				int score = rs.getInt("score");
				rvList.add(new ReviewVO(pdid,writer,writedate,content,bno,score));
			}
			startpage = ((pagenum-1)/5)*5+1;
			endpage = startpage+4;
			sql = "SELECT count(*) FROM review WHERE pd_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,productId);
			rs = pstmt.executeQuery();
			int num = 0;
			if(rs.next()) {
				num = rs.getInt(1);
			}
			int allpage = 0;
			if(num%5==0) {
				allpage = num/5;
			} else {
				allpage = num/5+1;
			}
			String pdname = "";
			sql = "SELECT name FROM product WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pdname = rs.getString(1);
			}
			numList.add(new ForRvVO(pagenum,allpage,startpage,endpage,productId));
			RequestDispatcher rd = request.getRequestDispatcher("reviewBoard.jsp");
			request.setAttribute("rvList", rvList);
			request.setAttribute("numList", numList);
			request.setAttribute("pdid", productId);
			request.setAttribute("pdname", pdname);
			rd.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
