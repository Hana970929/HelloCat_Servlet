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
    $('.decoration_none').click(function(){
    	var id = "<%=(String)session.getAttribute("user_id")%>";

    	if(id!='null'){
    		location.href = "WriteLetter.jsp";
    	}else{
    		alert('로그인을 해주세요!')
    	}
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
					<a href="HCController?command=Board_Main"><img src="Images/community.png" class="menuImgC"/></a>
				</div>
				<div class="fl comSt">
					<a href="store_main.html"><img src="Images/store.png" class="menuImg"/></a>
				</div>
			</div>
				<div class="fl searchbar">
				<form action="HCController?command=Search">
					<label for="input1">
					</label><input type="text" id="input1" name="search" class="search" placeholder=" 통합검색"/>
					<input type="submit" class="btn_search" name="submit" alt="search" value="">
				</form>
			</div>
			<div class="fl cart">
				<a href="cartList.html"><img src="Images/cart.png" class="cartImg"/></a>
			</div>
			<%if(id!=null){ %>
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
				<a href="HCController?command=Letter"><img src="Images/줄냥쉑.png" class="img_community_letter_l"/></a>
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
		<div class = "write">
			<a class = "decoration_none"><button class = "write_btn">
				<p class = "p_write" >글 작성</p>
				</button>
			</a>
		</div>	
			<table class = "letter_table">
			<%
				ArrayList<BoardLetterVO> list = (ArrayList<BoardLetterVO>)(request.getAttribute("list"));
			%>
				<% for(BoardLetterVO vo : list){					
				%>
					<tr class = "letter_tr" >
						<td rowspan = "2" class = "letter_td1">
						<%if(vo.getPhoto()!=null){ %>	
							<img style = "cursor:pointer;"
							onclick = "location.href = 'HCController?command=ShowLetter&bno=<%=vo.getBno()%>'"
							class = "td_photo"src = "Images/고양이/<%=vo.getPhoto()%>">
						<%}else{ %>
						<img style = "cursor:pointer;"
							onclick = "location.href = 'HCController?command=ShowLetter&bno=<%=vo.getBno()%>'"
							class = "td_photo" src = "Images/한줄냥기본.png">
						<%} %>
						</td>
						<td class = "letter_td2">
							<span class= "comment_board_title">
								<b><%=vo.getTitle()%></b>
							</span>
							<span class= "board_content">
								<%=vo.getContent()%>
							</span>
						</td>
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
					<%}%>
			</table>
			<div class = "page">
				<table style = "margin:0 auto;">
					<tr>
					<% 
						int startNo =(int)(request.getAttribute("startNo"));				
						int endNo =(int)(request.getAttribute("endNo"));				
						int total =(int)(request.getAttribute("total"));				
						int nextPage =(int)(request.getAttribute("nextPage"));				
						int prePage =(int)(request.getAttribute("prePage"));										
						if(startNo>5){
					%>
							<td class = "prePage_td"><img class = "prePage_img" src = "Images/이전2.png" onclick = "location.href = 'HCController?command=Letter&page=<%=prePage%>'"></td>
					<%	
						}else{}
		
					for(int i = startNo;i<=endNo;i++){ 
						if(i<=total){%>
							<td class = "page_td"><a class = "page_num" href = "HCController?command=Letter&page=<%=i%>"><%=i%></a></td>
						<%}					
					}
					if(endNo<total){
					%>
							<td class = "nextPage_td"><img class = "nextPage_img" src = "Images/다음2.png" onclick = "location.href ='HCController?command=Letter&page=<%=nextPage%>'"></td>
					<%	
						}else{}
					%>
					</tr>
				</table>
			</div>	
</body>
</html>