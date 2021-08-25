<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.hellocat.vo.LikePdVO"%>
<%String id = (String)session.getAttribute("user_id");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link href="CSS/HC.css" rel="stylesheet" type="text/css"/>
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
			<div class="logo dib">
				<a href="store_main.html">
					<img src="Images/logo.png" width="270px"/>
				</a>
			</div>
			<div class="fl comSt">
				<a href="https://shop.witkorea.kr/"><img src="Images/community.png" class="menuImg"/></a>
			</div>
			<div class="fl comSt">
				<a href="store_main.html"><img src="Images/store.png" class="menuImg"/></a>
			</div>
			<div class="fl searchbar">
				<form action="">
					<label for="input1">
					</label><input type="text" id="input1" name="search" class="search" placeholder=" 통합검색"/>
					<input type="submit" class="btn_search" name="submit" alt="search" value="">
				</form>
			</div>
			<div class="fl cart">
				<a href="cartList.html"><img src="Images/cart.png" class="cartImg"/></a>
			</div>
			<%if(id!=null){%>
				<div class="fl comStId">
					<div class = "comStId2">
						<a class = "logout_text"><img class = "shit" src = "Images/logout.png"></a>
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
				<a href="store_main.html"><img src="Images/storehome.png" class="storeMenuImg"/></a>
			</div>
			<div class="fl storeMenu">
				<a href="store_food.html"><img src="Images/yumyum.png" class="storeMenuImg"/></a>
			</div>
			<div class="fl storeMenu">
				<a href="store_toy.html"><img src="Images/play.png" class="storeMenuImg"/></a>
			</div>
			<div class="fl storeMenu">
				<a href="store_goods.html"><img src="Images/good.png" class="storeMenuImg"/></a>
			</div>
			<div class="footprint">
				<img src="Images/footprint.png" class="footPrintImg">
			</div>
		</div>
	</div>
	<div style="text-align: center; padding-top: 50px;">
		<h1>장바구니에 상품이 없습니다.</h1>
		<a href="HCController?command=storemain">상품을 둘러보러 갈까요?</a>
	</div>
</body>
</html>











