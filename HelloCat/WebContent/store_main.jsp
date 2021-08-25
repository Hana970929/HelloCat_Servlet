<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hellocat.vo.ProductVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어 홈</title>
<link href="CSS/HC.css" rel="stylesheet" type="text/css"/>
<%String id = (String)session.getAttribute("user_id");%>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script>
$(function(){
	$(".logout_text").click(function(){
		location.href = "LogOut.jsp";
		<%
			if(id!=null){%>
				alert('로그아웃 되었습니다! 다음에 또 오세요!')
				location.href = "HCController?command=storemain";
			<%}else{%>
				alert('뭐가 문제지...')
			<%}%>
	});
	
});
</script>
</head>
<body bgcolor="#f1e6d3">
	<div class="basic">
		<div class="textCenter divCenter firstline">
			<div class="logo">
				<a href="HCController?command=storemain">
					<img src="Images/logo.png" width="270px"/>
				</a>
			</div>
			<div class="fl comSt">
				<a href="HCController?command=Board_Main"><img src="Images/community.png" class="menuImg"/></a>
			</div>
			<div class="fl comSt">
				<a href="HCController?command=storemain"><img src="Images/store.png" class="menuImg"/></a>
			</div>
			<div class="fl searchbar">
				<form action="">
					<label for="input1">
					</label><input type="text" id="input1" name="search" class="search" placeholder=" 통합검색"/>
					<input type="submit" class="btn_search" alt="search" value=""/>
				</form>
			</div>
			<div class="fl cart">
				<a href="HCController?command=showcart"><img src="Images/cart.png" class="cartImg"/></a>
			</div>
			<%if(id!=null){%>
				<div class="fl comStId">
					<div class = "comStId2">
						<a class = "logout_text"><img href = "logout.jsp" class = "shit" src = "Images/logout.png"></a>
					</div>	
				</div>
			<%}else{ %>	
				<div class="fl comSt">
					<a href="HCController?command=Login"><img src="Images/login.png" class="menuImg"/></a>
				</div>
				<div class="fl comSt">
					<a href="HCController?command=Join"><img src="Images/join.png" class="menuImg"/></a>
				</div>
			<%} %>
		</div>
		<div class="bgDark secondLine">
			<div class="fl storeHome">
				<a href="HCController?command=storemain"><img src="Images/storehome.png" class="storeMenuImg"/></a>
			</div>
			<div class="fl storeMenu">
				<a href="HCController?command=storefood"><img src="Images/yumyum.png" class="storeMenuImg"/></a>
			</div>
			<div class="fl storeMenu">
				<a href="HCController?command=storetoy"><img src="Images/play.png" class="storeMenuImg"/></a>
			</div>
			<div class="fl storeMenu">
				<a href="HCController?command=storegoods"><img src="Images/good.png" class="storeMenuImg"/></a>
			</div>
			<div class="footprint">
				<img src="Images/footprint.png" class="footPrintImg">
			</div>
		</div>
	</div>
	<!-- 여기까지가 기본 -->
	<div class="bestPd">
		<div class="fl showOrderbyPd">
			<b>고양이선생 베스트 상품!</b>
		</div>
	</div>
	<div class="showThreePd divCenter">
		<%
			ArrayList<ProductVO> pdList = (ArrayList<ProductVO>)(request.getAttribute("pdList"));
			for(ProductVO vo:pdList) {
				String arr[] = vo.getPhoto().split("\\*");
		%>
			<div class="showOnePd fl">
			<div class="pdImgDiv">
				<a href="HCController?command=showOnePd&id=<%=vo.getId()%>"><img src="Images/<%=arr[0]%>.jpg" class="scale pdPicImg"/></a>
			</div>
				<h2><span class="textDark"><% 
					if(vo.getId().contains("food")) {
						out.println("맛있겠냥");
					} else if(vo.getId().contains("toy")) {
						out.println("재밌겠냥");
					} else {
						out.println("갖고싶냥");						
					}
				%></span></h2>
				<h1><a href="HCController?command=showOnePd&id=<%=vo.getId()%>"><%=vo.getName()%> </a>
				</h1><h3><%=vo.getExplain()%></h3>
				<h2 class="fl" style="margin-top: 10px;"><%=vo.getS_price()%>원</h2>
				<div class="showStars" style="float:right;">
				<%for(int i=1; i<=5; i++) { 
					if(i<=vo.getScore()) {%>
					<a href="HCController?command=showReview&id=<%=vo.getId()%>"><img src="Images/rvStar.png" class="fl starImg"/></a>
				<%}	else {%>
					<a href="HCController?command=showReview&id=<%=vo.getId()%>"><img src="Images/rvstar2.png" class="fl starImg"/></a>				
					<%}
				}%> <a href="HCController?command=showReview&id=<%=vo.getId()%>" style="line-height: 49px;"> (<%=vo.getReviewcnt()%>)</a>	
				</div>
			</div>
		<%
			}		
		%>
	</div>
</body>
</html>