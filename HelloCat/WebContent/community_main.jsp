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
					<a href="HCController?command=storemain"><img src="Images/store.png" class="menuImg"/></a>
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
				<a href="HCController?command=Board_Main"><img src="Images/community_home.png" class="img_community_home_h"/></a>
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
	<div class = "slider_container" style="border-bottom:0;">
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
		<%
			ArrayList<BoardLetterVO> list = (ArrayList<BoardLetterVO>)(request.getAttribute("list"));
		%>
		<div class = "communication_main">
			<div class = "communication_letter" style="border-bottom:0;">
				<div class = "letter_title">
					<span class = "span_letter_title">한줄냥</span>
				</div>
		<%for(BoardLetterVO vo:list){%>
				<table class = "letter_table" onclick = "location.href = 'HCController?command=ShowLetter&bno=<%=vo.getBno()%>'">
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
						<span class= "board_content">
							<%=vo.getTitle()%>
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
		</table>
			<%}%>
			<button class = "btnToLetter">
				<p class = "btnToLetter_p">더보기</p>
			</button>
			</div>
			<div class = "communication_photo">
				<div class = "photo_title">
					<span class = "span_photo_title">한컷냥</span>
				</div>
				<div class = "photo1" style="border-bottom:0;">
				<%
					int count = (int)(request.getAttribute("count"));
				%>
			<%ArrayList<BoardPhotoVO>list2 = (ArrayList<BoardPhotoVO>)request.getAttribute("list2");%>
					<%for(BoardPhotoVO vo : list2) {%>
					<div class = "Con1" id="<%=vo.getBno()%>">
						<div class = "content1">
							<div class = "contentphoto">
								<img src = "Images/고양이/<%=vo.getPhoto()%>" class = "turtle" >
							</div>	
						</div>	
						<div class = "content2">
							<div class = "con1">
								<span class = "span1"><%=vo.getWriter() %></span>	
									<img src = "Images/좋아요.png" class = "like"><a class ='like_num'><%=vo.getLike_count() %></a>
									<img src = "Images/댓글.png" class = "comment"><a class ='comment_num'><%=vo.getCount2()%></a>
							</div>
							<div class = "conLetter" >
								<span class = "span2"><%=vo.getContent()%></span>
							</div>
						</div>
					</div>
					<%}%>
					<button class = "btnToPhoto">
						<p class = "btnToPhoto_p">더보기</p>
					</button>			
				</div>	
	<div id = "backgroundM">	
		<div class = "popup">
			<input type = "hidden" id = "popup_bno" value = "">
			<div class = "pop_photo_writer">
				<div class = popup_writer>
					<a id="popup_w"></a>
					<a id="popup_board_date"></a>
				</div>				
			</div>
			<div class = "pop_photo">
				<img src ="	" class = "popup_photo">
			</div>
			<div class = "pop_photo_like_comment">
				<div id = "like_popup">
					<img src = "Images/like2.png" class = "like_popup">
				</div>			
			</div>
			<div class = "pop_letter">
				<div class = popup_content>
					<p id="popup_p" class = "text"></p>
				</div>
				
				<div class = "popup_comment">
					<div id = "popup_C">
						댓글 (<a style = "font-size:35px; color:#e9d8ba;" class ="popup_c"></a>)
					</div>
				</div>
				<span></span>
			</div>
		</div>
		<div class = "popup_comment_detail">			
		</div>
	</div>	
</div>
			</div>
<script>
$(document).ready(function(){
	var count = 0;
	$(document).on("click",".Con1",function(){ 
		const bno = $(this).attr('id');
			$.ajax({
				type:"get",
				data:{"bno": bno},
				datatype:"json",
				url:"photo_popup",
				success:function(data){
					var result = data.data;
					var photo = result.photo;
					var bno = result.bno;
					var content = result.content;
					var writer = result.writer;
					$(".popup_photo").attr("src", "Images/고양이/"+data.data.photo);		
					$("#popup_w").text(data.data.writer);
					$("#popup_p").text(data.data.content);
					$("#popup_board_date").text(data.data.board_date);
					$(".popup_c").text(data.data.count);
					$("#popup_bno").val(data.data.bno);
					count = data.data.count;
					$(".like_popup_count").text(data.data.like_count);
					/*$("#popup_c").text(data.data.content);*/	
				}
			});
		if($("#backgroundM").css("display")=="none"){			
			$("#backgroundM").show();	
		}	
		$(".popup").fadeIn(); 
		
	}); 
		
		$(".popup_photo").click(function(){ 			
			$("#backgroundM").hide();
			$(".popup").fadeOut(); 
			$(".popup_comment_detail").fadeOut();
			history.go(0);

	}); 	
		$(".popup_c").mouseover(function(){
			$(".popup_c").css("text-decoration","none");
	});
		$(".popup_comment").click(function(){
			var bno = $("#popup_bno").attr('value');
				$.ajax({
					type:"get",
					data:{"bno":bno},
					datatype:"json",
					url:"popupCommentServlet",
					success:function(data){
						var html = "";	
						var result = data.arr;
							if(count!=""){
								for(var i =0;i<=result.length-1;i++){							
									var a = result[i];
									var cno = a.comment_cno;
									var writer = a.comment_writer;
									var content = a.comment_content;
									var date = a.comment_date;
									html+="<div class = 'pcd'><div class = 'pcd_writer'><a id ='pcd_writer'><b>"+writer+"</b></a></div>";
									html+="<div class = 'pcd_content'><a id = 'pcd_content'>"+content+"</a><div class = 'photo_comment_date'><a>"+date+"</a></div></div></div>";
								}
								html+="<div id = 'photo_comment_detail'><form id='frm1' name = 'pho_co_de'><input type = 'text' name='content' class = 'photo_comment_detail'><button type='button' class ='IPC'>댓글입력</button></form></div>";
								$(".popup_comment_detail").empty();
								$(".popup_comment_detail").append(html);
							}else{
								html+="<div id = 'photo_comment_detail'><form id='frm1' name = 'pho_co_de'><input type = 'text' name='content' class = 'photo_comment_detail'><button type='button' class ='IPC'>댓글입력</button></form></div>";
								$(".popup_comment_detail").empty();
								$(".popup_comment_detail").append(html);
							}
					}
				});
			$(".popup_comment_detail").fadeIn();
		});
		$(".popup_comment_detail").click(function(){
			
		});
	$(document).on("click",".like_popup",function(){
				var bno = $("#popup_bno").attr('value');
					$.ajax({
						type:"get",
						data:{"bno":bno},
						datatype:"json",
						url:"HCController?command=Insert_like",
						success:function(data){
							var a = data.data;
							var like_count = a.like_count;
							var like_bno = a.like_bno;
							console.log (like_bno);
							var html="";
							html+="<img src = 'Images/like2.png' class = 'like_popup'>";
							html+="<div class = 'like_popup_count'>"+like_count+"</div>";
							$("#like_popup").empty();	
							$("#like_popup").append(html);	
						},
						
					});
	});
	
	$(document).on("click",".IPC",function(){
		var bno = $("#popup_bno").attr('value');
		var formData = $("#frm1").serialize();
		var id = "<%=(String)session.getAttribute("user_id")%>";
		if(id=='null'){
			alert('로그인을 해주세요');
		}else{				
			$.ajax({
					type:"get",
					data:{"bno":bno,"content":formData},
					datatype:"json",
					url:"HCController?command=Insert_photo_comment",
					success:function(data){
						var a = data.data;
						var comment_content = a.comment_content;
						var comment_writer = a.comment_writer;
						var comment_cno = a.comment_cno;
						var comment_date = a.comment_date;
						var html="";
						count = a.count;
						if(count!=""){	
							html+="<div class = 'pcd'><input type = 'hidden' value = '"+comment_cno+"'><div class = 'pcd_writer'><a id ='pcd_writer'><b>"+comment_writer+"</b></a></div>";
							html+="<div class = 'pcd_content'><a id = 'pcd_content'>"+comment_content+"</a><div class = 'photo_comment_date'><a>"+comment_date+"</a></div></div></div>";
							$(".popup_comment_detail").append(html);
						}else{
							html+="<div class = 'pcd'><input type = 'hidden' value = '"+comment_cno+"'><div class = 'pcd_writer'><a id ='pcd_writer'><b>"+comment_writer+"</b></a></div>";
							html+="<div class = 'pcd_content'><a id = 'pcd_content'>"+comment_content+"</a><div class = 'photo_comment_date'><a>"+comment_date+"</a></div></div></div>";
							html+="<div id = 'photo_comment_detail'><form id='frm1' name = 'pho_co_de'><input type = 'text' name='content' class = 'photo_comment_detail'><button type='button' class ='IPC'>댓글입력</button></form></div>";							
							$(".popup_comment_detail").empty();
							$(".popup_comment_detail").append(html);
						}	
						$(".popup_c").text(count);
						
						}
					});
			}
		});
});
$(document).ready(function(){
	$('.btnToLetter').hover(function(){
    	$('.btnToLetter').css("background-color","#866744");
    	$('.btnToLetter_p').css("color","#e9d8ba");
    },function(){
    	$('.btnToLetter').css("background-color","#e9d8ba");
    	$('.btnToLetter_p').css("color","#866744");
    });
	$('.btnToLetter').click(function(){
		location.href="HCController?command=Letter";
	});
	$('.btnToPhoto').hover(function(){
    	$('.btnToPhoto').css("background-color","#866744");
    	$('.btnToPhoto_p').css("color","#e9d8ba");
    },function(){
    	$('.btnToPhoto').css("background-color","#e9d8ba");
    	$('.btnToPhoto_p').css("color","#866744");
    });
	$('.btnToPhoto').click(function(){
		location.href="HCController?command=Photo";
	});
});

</script>
	
</body>
</html>