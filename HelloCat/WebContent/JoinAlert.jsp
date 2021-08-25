<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%String id = (String)session.getAttribute("id"); %>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/DH.css">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script>
$(function() {
	$(".pw1").keyup(function() {
		s = $(this).val();
		if(s.length > 0) {
			st = $(this).css("font-family");
			if(st=="Cafe24Oneprettynight") {
				$(this).css("font-family", "initial");
			}
		} else {
			st = $(this).css("font-family");
			if(st!="Cafe24Oneprettynight") {
				$(this).css("font-family", "Cafe24Oneprettynight");
			}
		}
	});
	$(".pw2").keyup(function() {
		s = $(this).val();
		if(s.length > 0) {
			st = $(this).css("font-family");
			if(st=="Cafe24Oneprettynight") {
				$(this).css("font-family", "initial");
			}
		} else {
			st = $(this).css("font-family");
			if(st!="Cafe24Oneprettynight") {
				$(this).css("font-family", "Cafe24Oneprettynight");
			}
		}
	});
});
$(function(){ 
	$(".id1").click(function(){ 
		$(".popup_id").fadeIn(); }); 
	$(".btn_close").click(function(){ 
		$(".popup_id").fadeOut(); }); 
});
</script>
</head>
<body bgcolor="#f1e6d3">
	<div class="basic">
		<div class="textCenter divCenter firstline">
			<div class="logo dib">
				<a href="store_main.html">
					<img class = "HClogo" src="Images/logo.png" width="270px"/>
				</a>
			</div>
			<div class = "leftcomSt">
				<div class="fl comSt">
					<a href="https://shop.witkorea.kr/"><img src="Images/community.png" class="menuImgC"/></a>
				</div>
				<div class="fl comSt">
					<a href="store_main.html"><img src="Images/store.png" class="menuImg"/></a>
				</div>
			</div>
				
				<div class="fl searchbar">
				<form action="http://localhost:9090/HelloCat/SearchResult.html">
					<label for="input1">
					</label><input type="text" id="input1" name="search" class="search" placeholder=" 통합검색"/>
					<input type="submit" class="btn_search" name="submit" alt="search" value="">
				</form>
			</div>
			<div class="fl cart">
				<a href="cartList.html"><img src="Images/cart.png" class="cartImg"/></a>
			</div>
			<div class="fl comSt">
				<a href="https://shop.witkorea.kr/"><img src="Images/login.png" class="menuImg"/></a>
			</div>
			<div class="fl comSt">
				<a href="https://shop.witkorea.kr/"><img src="Images/join.png" class="menuImg"/></a>
			</div>
		</div>
		<div class="bgDark secondLine">
			<div class="fl community_home">
				<a href="store_food.html"><img src="Images/community_home.png" class="img_community_home"/></a>
			</div>
			<div class="fl comunity_menu">
				<a href="http://localhost:9090/HelloCat/Board_letter.html"><img src="Images/줄냥쉑.png" class="img_community_letter"/></a>
			</div>
			<div class="fl comunity_menu">
				<a href="http://localhost:9090/HelloCat/Board_photo3.html"><img src="Images/컷냥쉑.png" class="img_community_photo"/></a>
			</div>
			<div class="footprint">
				<img src="Images/footprint.png" class="footPrintImg">
			</div>
		</div>
	</div>
	<div class = "content">
	<form name = "frm" action = "BoardJoinServlet"> 
			<input type = "text" name = "name" class = "name1 " placeholder = "이름을 입력해주세요"><br/>
			<input type = "text" name = "id" class = "id1" value = "" placeholder = "아이디를 입력해주세요"><br/> 
			<input id="123" type = "password" name = "pw" class = "pw1 " placeholder = "비밀번호를 입력해주세요"><br/>
			<input type = "password" name = "pw2" class = "pw2 " placeholder = "비밀번호를 다시 한번 입력해주세요"><br/>
			<input type = "email" name = "email" class = "email " placeholder = "이메일 주소를 입력해주세요"><br/>
			<input type = "number" name = "phone" class = "phone " placeholder = "전화번호를 입력해주세요"><br/>
			<button id="here" type = "submit" name = "login" class = "loginbtn1" onclick = "return check();"><span style = "font-family:sans; font-size:20px;">Join</span></button>
		 </form> 
		<img src = "Images/편안.png" class = "cat1">
		<img src = "Images/호다닥.png" class = "cat2">
	</div>
<%String check = (String)(request.getAttribute("check")); %>
<script>
$(document).ready(function(){
	$(function() {
		$(".loginbtn1").addClass("loginbtn1transition");	
	});
	
	$(".loginbtn1").click(function(){
		var id = frm.id.value;
		var pw = frm.pw.value;
		var pw2 = frm.pw2.value;
		var name = frm.name.value;
		var email = frm.email.value;
		var phone = frm.phone.value;
		var RegExp = /^[a-zA-z0-9]{4,12}$/;
		var RegExp2 = /^(?=.*[a-zA-Z0-9$@$!%*?&]{8,20}$/;
		var RegExp3 = /^[가-힣]{2,20}$/;
		var RegExp4 = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		var RegExp5 = /^[0-9]{,11}$/;
		
		if(!RegExp.test(id)||id == ''){
			console.log("1");
			alert('아이디를 4자에서 13자의 영문 혹은 숫자로 공백없이 입력해주세요');
			return false;
		}
		else if(!RegExp2.test(pw)||pw == ''){
			alert('비밀번호를 8자에서 20자의 영문 및 숫자,특수문자로 공백없이 입력해주세요');
			return false;
		}else if(pw!=pw2){
				alert('입력하신 비밀번호를 다시 한 번 확인해주세요 ');
				return false;
		}else if(!RegExp3.test(name)||name == ''){
				alert('이름을 2자에서 20자의 한글로 공백없이 입력해주세요');
				return false;
		}else if(!RegExp4.test(email)||email == ''){
				alert('입력하신 이메일 주소를 다시 한 번 확인해주십시오');
				return false;
		}else if(!RegExp5.test(phone)||phone == ''){
			alert('입력하신 전화번호를 다시 한 번 확인해주십시오');
			return false;
		}
		console.log("6");
		return true;
	});
	$(".loginbtn").click(function(){
		return true;
	});
		});
	
</script>
</body>
</html>