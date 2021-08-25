<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hellocat.vo.ReviewVO"%>
<%@ page import="com.hellocat.vo.ForRvVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 보기</title>
<link href="CSS/HC.css" rel="stylesheet" type="text/css"/>
<%String id = (String)session.getAttribute("user_id");%>
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
</script>
</head>
<body bgcolor="#f1e6d3" style="padding-top: 250px;">
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
	<div class="reviewLine divCenter">
		<div class="innerReviewLine divCenter">
			<p class="reviewLineTxt">상품 리뷰 - ${pdname}</p>
		</div>
	</div>
	<table class="divCenter reviewTable">
		<thead>
			<tr>
	          	<th>점수</th>
	          	<th>내용</th>
	          	<th>작성자</th>
				<th>작성일자</th>
        	</tr>
		</thead>
		<tbody>
			<%
			ArrayList<ReviewVO> rvList = (ArrayList<ReviewVO>)(request.getAttribute("rvList"));
			for(ReviewVO vo : rvList) {%>
			<tr>
	          	<td class="rvScore"><%for(int i=1;i<=vo.getScore();i++) {%>
	          	<img src="Images/rvStar.png" class="reviewStar"/>
	          	<%}%>
	          	</td>
	          	<td class="rvContent"><%=vo.getContent()%></td>
	          	<td><%=vo.getWriter()%></td><td><%=vo.getWritedate()%></td>
	        </tr>
	        <%} %>
		</tbody>
	</table>
	<div class="page_write divCenter">
		<div class="rvPage divCenter textCenter">
			<p>
			<%
			ArrayList<ForRvVO> numList = (ArrayList<ForRvVO>)(request.getAttribute("numList"));
			for(ForRvVO vo : numList) {
				if(vo.getStartpage()>5) {%>
						<a href="HCController?command=showReview&id=<%=vo.getPdid()%>&page=<%=vo.getStartpage()-1%>">이전</a>
					<%} else {%>
						이전
					<%}
					for(int i=vo.getStartpage(); i<=vo.getEndpage(); i++) {
						if(i<=vo.getAllpage()) {
							if(i!=vo.getPagenum()) {%>
							<a href="HCController?command=showReview&id=<%=vo.getPdid()%>&page=<%=i%>"><%=i%></a>
							<%} else {
								out.println(i);
							}
						}
					}
					if(vo.getAllpage()>vo.getEndpage()) {%>
							<a href="HCController?command=showReview&id=<%=vo.getPdid()%>&page=<%=vo.getEndpage()+1%>">다음</a>					
					<%} else {%>
							다음
						<%}
					}%>
			</p>
		</div>
		<div class="writeRv">
			<button type="button" onClick="location.href='HCController?command=writeReview&pdid=${pdid}'"
			class="writeRvBtn">
				리뷰 작성
			</button>
		</div>
	</div>
</body>
</html>