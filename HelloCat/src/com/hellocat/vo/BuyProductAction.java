package com.hellocat.vo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BuyProductAction implements Action{
	
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
		Enumeration<String> params = request.getParameterNames();
		ArrayList<BuyPdVO> pdList = new ArrayList<BuyPdVO>();
		DecimalFormat df = new DecimalFormat("###,###");
		String buynow = request.getParameter("buyNow");
		if(buynow.equals("yes")) {
			while(params.hasMoreElements()) {
				String pdid = (String)params.nextElement();
				String sql = "SELECT * FROM product WHERE id=?";				
				try {
					PreparedStatement pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, pdid);
					ResultSet rs = pstmt.executeQuery();
					while(rs.next()) {
						String pdid2 = rs.getString("id");
						String name = rs.getString("name");
						int price = rs.getInt("price");
						String thePrice = df.format(price);
						int quantity = Integer.parseInt(request.getParameter(pdid2));
						String photo = rs.getString("photo");
						pdList.add(new BuyPdVO(name,thePrice,price,quantity,photo));
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		} else {
			while(params.hasMoreElements()) {
				String pdname = (String)params.nextElement();
				String sql = "SELECT * FROM product WHERE name=?";				
				try {
					PreparedStatement pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, pdname);
					ResultSet rs = pstmt.executeQuery();
					while(rs.next()) {
						String pdid2 = rs.getString("id");
						String name = rs.getString("name");
						int price = rs.getInt("price");
						String thePrice = df.format(price);
						int quantity = Integer.parseInt(request.getParameter(name))/price;
						String photo = rs.getString("photo");
						pdList.add(new BuyPdVO(name,thePrice,price,quantity,photo));
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
//		for(ProductVO vo:pdList) {
//			System.out.println(vo.getName());
//			System.out.println(1);
//		}
		RequestDispatcher rd = request.getRequestDispatcher("HCController?command=memberForPurchase");
		request.setAttribute("pdList", pdList);
		rd.forward(request, response);
	}
}
