<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
<link href="CSS/HC.css" rel="stylesheet" type="text/css"/>
</head>
<%String id = (String)session.getAttribute("user_id");%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
	$(".logout_text").click(function(){
		location.href = "LogOut.jsp";
		<%
			if(id!=null){%>
				alert('로그아웃 되었습니다! 다음에 또 오세요!')
				location.href = "HCController?command=Board_Main";
			<%}else{%>
				alert('뭐가 문제지...')
			<%}%>
	});
	
});
	$(document).ready(function() {
	    $('#writingRv').on('keyup', function() {
	        $('#cntSPAN').html("("+$(this).val().length+" / 100)");
	        if($(this).val().length > 100) {
	            $(this).val($(this).val().substring(0, 100));
	            $('#cntSPAN').html("(100 / 100)");
	        }
	    });
	});
	function checkRv() {
		var content = $('#writingRv').val();
		if (content.length<11){
			alert("10자 이상 입력해주세요.");
			return false;
		}
		else{
			return true;
		}
	}
</script>
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
	<div class="rv_write divCenter">
		<div class="inner_rvWrite divCenter">
			<p><b>리뷰 작성</b></p>
		</div>
	</div>
	<form action="HCController">
		<div style="width:900px; margin-left: 150px; margin:0 auto; margin-top: 30px; height:1px;">
			<div style="float:left; width:450px; font-size:20px;">
				${pdname}
			</div>
			<div style="text-align: right; float:left; width:449px;">
				받아보신 상품은 어땠나요?&nbsp;&nbsp;
				<select style="height:30px; font-size:20px;" name="score">
					<option value="5">★★★★★</option>
					<option value="4">★★★★☆</option>
					<option value="3">★★★☆☆</option>
					<option value="2">★★☆☆☆</option>
					<option value="1">★☆☆☆☆</option>
				</select>
			</div>
		</div>
		<div class="rv_writeIt divCenter">
			<textarea id="writingRv" 
			class="writingRv divCenter" 
			placeholder="리뷰 내용을 입력해주세요 (10자 이상, 100자 이하 입력 가능합니다)"
			name="rvcontent" required></textarea>
			<span id="cntSPAN" >(0 / 100)</span>&nbsp;
			<input type="hidden"name="command" value="insertReview"/>
			<input type="hidden"name="pdid" value="${pdid}"/>
		</div>
		<div class="insertRvBtnDiv divCenter">
			<button type="submit" onClick="return checkRv()"
				class="insert_RvBtn">
					리뷰 등록
			</button>
		</div>
	</form>
</body>
</html>