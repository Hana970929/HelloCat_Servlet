<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hellocat.vo.ProductVO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재밌겠냥</title>
<%String id = (String)session.getAttribute("user_id");%>
<link href="CSS/HC.css" rel="stylesheet" type="text/css"/>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
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
var page = 2; //불러올 페이지
function next_load_t() { 
	$.ajax({
		type:"GET",
		url:"HCController?command=infiniteScroll_t",
		data : {'page':page},
		dataType : "json",
		success: function(string) {
			var result = string.jsonArr_t;
			if(result.length<6) {
				for (var i=0;i<=result.length-1;i++) {
					var pd = result[i];
					var append_node = "";
					append_node += "<div class='showOnePd fl'>";
					append_node += "<div class='pdImgDiv'>";
					append_node += "<a href='HCController?command=showOnePd&id="+pd.pdid+"'><img src='Images/"+pd.photo+".jpg' class='scale pdPicImg'/></a>";
					append_node += "</div>";
					append_node += "<h2><span class='textDark'>재밌겠냥</span></h2>";
					append_node += "<h1><a href='goods_view.html'>"+pd.name+"</a>";
					append_node += "</h1><h3>"+pd.explain+"</h3>";
					append_node += "<h2 class='fl' style='margin-top: 10px;'>"+pd.s_price+"원</h2>";
					append_node += "<div class='showStars' style='float:right; width: 180px;'>";
					for(var j=1; j<=5; j++) { 
						if(j<=pd.score) {
							append_node += "<a href='HCController?command=showReview&id="+pd.pdid+"'><img src='Images/rvStar.png' class='fl starImg'/></a>";
					  }	else {
						  	append_node += "<a href='HCController?command=showReview&id="+pd.pdid+"'><img src='Images/rvstar2.png' class='fl starImg'/></a>";			
						}
					} append_node += "<a href='HCController?command=showReview&id="+pd.pdid+"' style='line-height: 49px;'> ("+pd.rvcnt+")</a>";	
					append_node += "</div>";
					append_node += "</div>";
					$('#pdcontainer').append(append_node);
				} page++;
				$("#morePdbtn").html("상품이 더 이상 없습니다.")
				$("#morePdbtn").prop("disabled", true);
			} else {
				for (var i=0;i<=result.length-1;i++) {
					var pd = result[i];
					var append_node = "";
					append_node += "<div class='showOnePd fl'>";
					append_node += "<div class='pdImgDiv'>";
					append_node += "<a href='HCController?command=showOnePd&id="+pd.pdid+"'><img src='Images/"+pd.photo+".jpg' class='scale pdPicImg'/></a>";
					append_node += "</div>";
					append_node += "<h2><span class='textDark'>갖고싶냥</span></h2>";
					append_node += "<h1><a href='goods_view.html'>"+pd.name+"</a>";
					append_node += "</h1><h3>"+pd.explain+"</h3>";
					append_node += "<h2 class='fl' style='margin-top: 10px;'>"+pd.s_price+"원</h2>";
					append_node += "<div class='showStars' style='float:right; width: 180px;'>";
					for(var j=1; j<=5; j++) { 
						if(j<=pd.score) {
							append_node += "<a href='HCController?command=showReview&id="+pd.pdid+"'><img src='Images/rvStar.png' class='fl starImg'/></a>";
					  }	else {
						  	append_node += "<a href='HCController?command=showReview&id="+pd.pdid+"'><img src='Images/rvstar2.png' class='fl starImg'/></a>";			
						}
					} append_node += "<a href='HCController?command=showReview&id="+pd.pdid+"' style='line-height: 49px;'> ("+pd.rvcnt+")</a>";	
					append_node += "</div>";
					append_node += "</div>";
					$('#pdcontainer').append(append_node);
				} page++;
			}
		},
		error: function(xhr, status, error) {
		 	}
		});
	}
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
			<b>재밌겠냥 (인기순)</b>
		</div>
		<div class="salesOrNew">
			<a href="HCController?command=storetoy_n">신상품순</a>&nbsp;|&nbsp;<b>인기순</b>
		</div>
	</div>
	<div class="showThreePd divCenter" id="pdcontainer">
		<%
			ArrayList<ProductVO> pdList = (ArrayList<ProductVO>)(request.getAttribute("pdList"));
			for(ProductVO vo:pdList) {
				String arr[] = vo.getPhoto().split("\\*");
		%>
			<div class="showOnePd fl">
			<div class="pdImgDiv">
				<a href="HCController?command=showOnePd&id=<%=vo.getId()%>"><img src="Images/<%=arr[0]%>.jpg" class="scale pdPicImg"/></a>
			</div>
				<h2><span class="textDark">재밌겠냥</span></h2>
				<h1><a href="goods_view.html"><%=vo.getName()%> </a>
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
	<div class="nomorePd">
		<button id="morePdbtn"style="width:100%; height:100%;" onclick="next_load_t()">
			상품 더 보기
		</button>
	</div>
</body>
</html>