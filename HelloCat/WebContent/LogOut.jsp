<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
 request.setCharacterEncoding("UTF-8"); 
	session.invalidate();
%>
</body>
<script type="text/javascript">
	location.href = "HCController?command=Board_Main";
</script>
</html>