package com.hellocat.vo;

import java.io.IOException;
import java.io.PrintWriter;
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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class InfiniteScroll_T_n implements Action{

	@SuppressWarnings({ "unchecked" })
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "hellocat";
		String pw = "1234";
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
		
		String sql = "SELECT rownum,p2.* FROM (SELECT rownum rnum,p.* FROM (SELECT * FROM product WHERE id LIKE '%toy%' ORDER BY id DESC)p)p2"
				+" WHERE rnum>=? AND rnum<=?";
		
		PreparedStatement pstmt;
		JSONArray jsonArr_t = new JSONArray();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startpage);
			pstmt.setInt(2, endpage);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				double d = 0;
				double sum = 0;
				JSONObject obj = new JSONObject();
				String pdid = rs.getString("id");
				String name = rs.getString("name");
				int price = rs.getInt("price");
				int sales = rs.getInt("sales");
				String explain = rs.getString("explain");
				String photo = rs.getString("photo");
				String arr[] = photo.split("\\*");
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
				obj.put("pdid", pdid);
				obj.put("name", name);
				obj.put("price", price);
				obj.put("sales", sales);
				obj.put("explain", explain);
				obj.put("photo", arr[0]);
				obj.put("s_price", s_price);
				obj.put("score",avr);
				obj.put("rvcnt", rvcnt);
				jsonArr_t.add(obj);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		response.setContentType("application/json; charset=UTF-8;");
		PrintWriter out = response.getWriter();
		JSONObject obj2 = new JSONObject();
		obj2.put("jsonArr_t", jsonArr_t);
		out.print(obj2);
	}
}