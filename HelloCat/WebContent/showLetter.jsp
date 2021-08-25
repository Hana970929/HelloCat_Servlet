<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
 <%@ page import = "com.hellocat.vo.CommentLetterVO"%>
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
$(document).ready(function(){
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
				<a href="HCController?command=Photo"><img src="Images/컷냥쉑.png" class="img_community_photo"/></a>
			</div>
			<div class="footprint">
				<img src="Images/footprint.png" class="footPrintImg">
			</div>
		</div>
	</div>
	<%
		String title = (String)(request.getAttribute("title"));
		String writer = (String)(request.getAttribute("writer"));
		String photo = (String)(request.getAttribute("photo"));
		String content = (String)(request.getAttribute("content"));
		String board_date = (String)(request.getAttribute("board_date"));
		int hitcount = (int)(request.getAttribute("hitcount"));
		int comment_count = (int)(request.getAttribute("comment_count"));
		int bno = (int)(request.getAttribute("bno"));
	%>
	<div class = "showLetter_Container">
		<div class = "showLetter_title">
			<div class = "big_slt">
				<div class = "slt" id =<%=bno%>>
					<span class = "titlespan"><%=title%></span>
					<input class = "hidden_letter_bno" type = "hidden" >
				</div>
				<div class = "slw">
					<span class = "writerspan"><%=writer%></span>
				</div>
			</div>
			<div class = "letterinformation">
				<div class = "lettersmall1">
				  조회수 : 
				</div>
					
				<div class = "lettersmall">
					댓글 :
				</div>
					
				<div class = "lettersmall">
					날짜 :
				</div>
					
			</div>
			<div class = "letterinformation2">
				
					<div class = "lv">
					&nbsp;<%=hitcount%>
					</div>
				
					<div  class = "lv">
					&nbsp;<a id = "lv"><%=comment_count%></a>
					</div>
					
					<div class = "lv">
					&nbsp;<%=board_date%>
					</div>
			</div>
			
		</div>
		<div class = "showLetter_main">
			<div class = "smp">
			<%if(photo!=null){ %>	
				<img src = "Images/고양이/<%=photo%>" class = "smpi">
			<%}else{ %>
				<img src = "Images/한줄냥기본.png" class = "smpi">
			<%} %>
			</div>
			<div class = "sml">
				<%=content %>
			</div>
		</div>
		<div class = "showLetter_comment">
			<div class = "CN">	
				<div class = "commentNumber">
					<a id = "commentNumber"><%=comment_count%></a>
				</div>
				<div class = "commentNumberletter">
					개의 댓글
				</div>
			</div>
		<div class = "textandregist">
				<div class = "commenttextarea" >
					<form id = "frm1">
						<p><textarea name = "comment_letter_text" class = "cta" cols="50" rows="10" placeholder="내용을 입력하세요"></textarea></p>
						<div>
							<button type = "button" class = "regist">등록</button>
						</div>
					</form>	
				</div>	
			</div>
		
		<%ArrayList<CommentLetterVO>list = (ArrayList<CommentLetterVO>)request.getAttribute("list_C");%>
		<% for(CommentLetterVO vo : list){ %>	
			<div class = "comment_container">
				
				<div class = "comment_writer">
					<span class = "c1"><%=vo.getComment_writer() %></span>
				</div>
					<div class = "comment_main">
						<div class = "comment_main_detail">
							<span class = "c2"><%=vo.getComment_content()%></span>
						</div>
					</div>
					<div class = "comment_date">
					 	<%=vo.getComment_date()%>
					</div>	
			</div>
			<%}%>
		</div>
	</div>
	<script>
		$(document).ready(function(){
			var id = "<%=(String)session.getAttribute("user_id")%>";
			$('.regist').click(function(){
				var bno = $('.slt').attr('id');
				var formData = $("#frm1").serialize();
				if(id!='null'){					
					$.ajax({
						type:"get",
						data:{"bno":bno,"content":formData},
						datatype:"json",
						url:"HCController?command=Insert_letter_comment",
						success:function(data){
								var html = "";
								html+="<div class = 'comment_container'><div class = 'comment_writer'><input type = 'hidden'name = 'letter_cno' value = '"+data.data.comment_cno+"'<span class = 'c1'>"+data.data.comment_writer+"</span></div>";
								html+="<div class = 'comment_main'><span class = 'c2'>"+data.data.comment_content+"</span></div>";
								html+="<div class = 'comment_date'>"+data.data.comment_date+"</div></div>";
								$('.showLetter_comment').append(html);
								$('#lv').text(data.data.count);
								$('#commentNumber').text(data.data.count);
								location.reload();
							}
						});
				}else{
					alert('로그인을 해주세요!');
				}
				});
			});
	</script>
</body>
</html>