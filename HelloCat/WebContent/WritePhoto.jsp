<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import = "java.util.*" %>
 <%@page import = "java.sql.*" %>
 <%@ page import = "com.hellocat.vo.BoardLetterVO"%>
 <%@ page import = "com.hellocat.vo.BoardPhotoVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="CSS/DH.css">
</head>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<%String id = (String)session.getAttribute("user_id");%>
<script>
$(document).ready(function () {
    $('.bxslider').bxSlider({ // 클래스명 주의!
        auto: true, // 자동으로 애니메이션 시작
        speed: 500,  // 애니메이션 속도
        pause: 5000,  // 애니메이션 유지 시간 (1000은 1초)
        mode: 'horizontal', // 슬라이드 모드 ('fade', 'horizontal', 'vertical' 이 있음)
        autoControls: true, // 시작 및 중지버튼 보여짐
        pager: true, // 페이지 표시 보여짐
        captions: true, // 이미지 위에 텍스트를 넣을 수 있음       
        slideWidth: 1200,   
        touchEnabled : (navigator.maxTouchPoints > 0)
        
    });
});
$(function(){
	$(".logout_text").click(function(){
		location.href="LogOut.jsp";
		if(id==null){
			alert('로그아웃 되었습니다');
		}
	});
	
});
</script>
<script>
$(document).ready(function(){
	$('.photo_write_preview').hover(function(){
    	$('.photo_write_preview').css("background-color","#866744");
    	$('.photo_write_preview_p').css("color","#e9d8ba");
    },function(){
    	$('.photo_write_preview').css("background-color","#e9d8ba");
    	$('.photo_write_preview_p').css("color","#866744");
    });
	
	$('.photo_write_btn').hover(function(){
    	$('.photo_write_btn').css("background-color","#866744");
    	$('.photo_write_btn').css("box-shadow","1px 1px 2px #e9d8ba;");
    	$('.photo_write_btn_p').css("color","#e9d8ba");
    },function(){
    	$('.photo_write_btn').css("background-color","#e9d8ba");
    	$('.photo_write_btn_p').css("color","#866744");
    });
});
function showPic() {	
	$(".preview_write_photo").empty();
	var pic = $("#bpp").val();
	var picArr = pic.split("\\");
	var i = picArr.length-1;
	var img = "<img style = 'width:100%; height:100%;' src = 'Images/고양이/"+picArr[i]+"'>";
	console.log(i);
	console.log(picArr[i]);
	$(".preview_write_photo").append(img);
}
</script>
<body style = "padding-bottom:10px;" bgcolor="#f1e6d3">
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
			<div class="fl community_home">
				<a href="HCController?command=Board_Main"><img src="Images/community_home.png" class="img_community_home"/></a>
			</div>
			<div class="fl comunity_menu">
				<a href="HCController?command=Letter"><img src="Images/줄냥쉑.png" class="img_community_letter"/></a>
			</div>
			<div class="fl comunity_menu">
				<a href="HCController?command=Photo"><img src="Images/컷냥쉑.png" class="img_community_photo_p"/></a>
			</div>
			<div class="footprint">
				<img src="Images/footprint.png" class="footPrintImg">
			</div>
		</div>
	</div>
	<div class = "slider_container">
		<div class = "bxslider">
			<div class = "slide_page">
				<a href="http://localhost:9090/HelloCat/HCController?search=%EB%A1%9C%EC%96%84%EC%BA%90%EB%8B%8C&command=Search">
				<img src = "Images/royal.jpg"></a>
			</div>		
			<div class = "slide_page">
				<a href="http://localhost:9090/HelloCat/HCController?command=showOnePd&id=food_treat_003">
				<img src = "Images/ciao.jpg">
				</a>
			</div>		
			<div class = "slide_page">
				<a href="http://localhost:9090/HelloCat/HCController?command=showOnePd&id=food_feed_002">
				<img src = "Images/nat.jpg">				
				</a>
			</div>				
		</div>
	</div>
	<div class = "write_photo">	
		<div class = "wrph2">
				<form action = "HCController">
					<div class = "textarea">
						<textarea rows="3" cols="30" placeholder="본 문을 입력하세요" name="contents" id = "bpm"></textarea>
					</div>	
					<div class = "file">
						<span class = "sa">사진</span><input type = "file"  id="bpp" 
						name="bpp" accept="image/png, image/jpeg" required>
						<button type = "button" class = "photo_write_preview" onclick="showPic()"><p class= "photo_write_preview_p"> 미리보기</p></button>
						<div class = "preview_write_photo">
						</div>
					</div>
					<div id = "photo_write_btn">
						<button type = "submit" class = "photo_write_btn" name = "command" value = "WritePhoto"><p class= "photo_write_btn_p">입력완료</p></button>
					</div>	
				</form>	
			</div>	
		</div>
	

</body>
</html>