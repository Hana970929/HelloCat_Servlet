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

public class StoreToyAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "hellocat";
		String pw = "1234";
		String pdid = "";
		DecimalFormat df = new DecimalFormat("###,###");
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
		} catch(ClassNotFoundException e) {
			System.out.println("JDBC드라이버 로딩 실패");			
		} catch(SQLException e) {
			System.out.println("Oracle 접속 실패");						
		}
		int pagenum = 1;
		if(request.getParameter("page")!=null) {
			pagenum = Integer.parseInt(request.getParameter("page"));
		}
		int startpage = (pagenum-1)*6+1;
		int endpage = startpage+5;
		ArrayList<ProductVO> pdList = new ArrayList<ProductVO>();
		String sql = "SELECT rownum,p2.* FROM (SELECT rownum rnum,p.* FROM (SELECT * FROM product WHERE id LIKE '%toy%' ORDER BY sales DESC)p)p2"
				+" WHERE rnum>=1 AND rnum<=6";
		
		PreparedStatement pstmt;
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				double d = 0;
				double sum = 0;
				pdid = rs.getString("id");
				String name = rs.getString("name");
				int price = rs.getInt("price");
				int sales = rs.getInt("sales");
				String explain = rs.getString("explain");
				String photo = rs.getString("photo");
				String s_price = df.format(price);
				String sql2 = "SELECT * FROM review WHERE pd_id = ?";
				PreparedStatement pstmt2;
				pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setString(1, pdid);
				ResultSet rs2;
				rs2 = pstmt2.executeQuery();
				while (rs2.next()) {
					int a = rs2.getInt("score");
					sum += a;
					d++;
				}
				double avr = Math.round((sum / d) * 100.0) / 100.0;
				int rvcnt = (int)d;
				pdList.add(new ProductVO(pdid,name,price,sales,explain,photo,s_price,avr,rvcnt));
			}
			RequestDispatcher rd = request.getRequestDispatcher("store_toy.jsp");
			request.setAttribute("pagenum", pagenum);
			request.setAttribute("pdList", pdList);
			rd.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
