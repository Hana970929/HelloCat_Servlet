<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
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
	String user_id = "coke1316";
	if(request.getParameter("userid")!=null) {
		user_id = request.getParameter("userid");
	}
	String pdid = request.getParameter("pdid");
	int order_cnt = Integer.parseInt(request.getParameter("quantity"));
	String name = "";
	String explain = "";
	String photo = "";
	int order_price = 0;
	int price = 0;
	String sql = "SELECT * FROM product WHERE id=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
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
	pstmt.setString(1,user_id);
	pstmt.setString(2,pdid);
	pstmt.setInt(3,order_cnt);
	pstmt.setString(4,name);
	pstmt.setString(5,explain);
	pstmt.setString(6,photo);
	pstmt.setInt(7,order_price);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<% try {
	pstmt.executeUpdate(); %>
	<script>
	
		alert("장바구니에 추가되었습니다.");
		location.href="store_mainServlet";
	</script>
	<%} catch(SQLIntegrityConstraintViolationException e) {%>
	<script>
		alert("이미 장바구니에 넣은 상품입니다.");
		location.href=history.back();
	</script>
	<%}%>
</body>
</html>