<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import = "java.util.*" %>
 <%@page import = "java.sql.*" %>
 <%@ page import = "com.hellocat.vo.BoardLetterVO"%>
 <%@ page import = "com.hellocat.vo.BoardPhotoVO"%>
 <%@ page import = "com.hellocat.vo.ProductVO"%>
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
</script>

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
				<form action="HCController">
				<input type="text" id="input1" name="search" class="search" placeholder=" 통합검색"/>
				<input type="hidden" name="command" value="Search">
					<input type="submit" class="btn_search" value="">
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
				<a href="HCController?command=Photo"><img src="Images/컷냥쉑.png" class="img_community_photo"/></a>
			</div>
			<div class="footprint">
				<img src="Images/footprint.png" class="footPrintImg">
			</div>
		</div>
	</div>
	<div class = "slider_container">
		<div class = "bxslider" style="border:0;">
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
	<div style="text-align:center; padding-top:20px;">
		<h1>[&nbsp;<%=request.getAttribute("search")%>&nbsp;] 검색 결과</h1>
	</div>
	<%
			ArrayList<BoardLetterVO> list = (ArrayList<BoardLetterVO>)(request.getAttribute("list"));
		%>
		<div class = "communication_main" style="margin-top:50px;">
		<div class = "letter_title">
					<span class = "span_letter_title">스토어</span>
				</div>
		<div class="showThreePd divCenter" style="padding:20px 0;">
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
				<div class="showStars" style="float:right; width: 180px;">
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
			<div class = "communication_letter" style="clear:both; padding:50px 0;">
				<div class = "letter_title">
					<span class = "span_letter_title">커뮤니티</span>
				</div>
		<%for(BoardLetterVO vo:list){%>
				<table class = "letter_table" onclick = "location.href = 'HCController?command=ShowLetter&bno=<%=vo.getBno()%>'"
				style="margin-bottom:30px;">
				<tr class = "letter_tr" >
				<%if(vo.getPhoto()!=null){ %>	
					<td rowspan = "2" class = "letter_td1">
						<img class = "td_photo"src = "Images/고양이/<%=vo.getPhoto()%>">
					</td>
					<td class = "letter_td2">
						<span class= "board_content">
							<%=vo.getContent()%>
						</span>
					</td>
				<%}else{%>
					<td class = "nonpic_letter_td2">
					<span class= "board_content">
						<%=vo.getContent()%>
					</span>
				</td>
				<%}%>

				</tr>
				<tr class = "letter_tr3">
					<td class = "letter_td3">
						<img class="flimage" src = "Images/comment.png">
						<a class = "letter_comment_num"><%=vo.getComment_count()%></a>												
						<span class="span_fl">
							<%=vo.getWriter()%>
						</span>
						<div style="clear:both;"></div>
					</td>
				</tr>
		</table>
			<%}%>
			</div>
		</div>
	