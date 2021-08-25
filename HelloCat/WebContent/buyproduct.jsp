<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.hellocat.vo.BuyPdVO"%>
<%String id = (String)session.getAttribute("user_id");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 구매페이지</title>
<link href="CSS/HC.css" rel="stylesheet" type="text/css"/>
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
	<form name="pcform" action="HCController">
		<div class="orderDiv">
			<div class="orderPurchase">
				<p><b>주문/결제</b></p>
			</div>
			<div class="orderedPd">
				<p>주문상품</p>
			</div>
			<%
				ArrayList<BuyPdVO> pdList = (ArrayList<BuyPdVO>)(request.getAttribute("pdList"));
				DecimalFormat df = new DecimalFormat("###,###");
				int sum = 0;
				for(BuyPdVO vo:pdList) {
					String arr[] = vo.getPhoto().split("\\*");
					sum+=vo.getPrice()*vo.getQuantity();
			%>
			<div class="OrderedPdTable">
				<div class="fl OrderedPdImg">
					<img src="Images/<%=arr[0]%>.jpg" class="fl orderedPdImg"/>
					<input type="hidden" name="<%=vo.getName()%>" value="<%=vo.getQuantity()%>">
				</div>
				<div class="fl orderedPdInfo">
					<h2 style="width:450px;"><%=vo.getName()%></h2>
					<div class="orderedPdPrice">
						<h4>개당 <%=vo.getThePrice()%> 원</h4>
					</div>
					<div class="resultPrice">
						<h1><b><%=vo.getQuantity()%>개 <%=df.format(vo.getPrice()*vo.getQuantity())%>원</b></h1>
					</div>
				</div>
			</div>
			<%}
			String sum1 = df.format(sum);
			int d_price = 0;
			int sale = sum/10;
			if(sum<=50000) {
				d_price = 2500;
			}
			String d_price1 = df.format(d_price);
			String t_price = df.format(sum+d_price-sale);
			String sale_price = df.format(sale);%>
		</div>
		<div class="inputUserInfo">
			<div class="orderedPd">
				<p>주문자 정보</p>
			</div>
			<div>
				<ul>
					<li class="userInput">
						<span class="fl infoTxt">이름</span>
						<div class="fl">
							<input class="infoInput" type="text" id="fromname" name="fromName" value="${name}"/>
						</div>
					</li>
					<li class="userInput">
						<span class="fl infoTxt">연락처</span>
						<div class="fl">
							<input class="telInput" type="number" id="fromTel1" name="fromTel1" value="${phone1}"/>
							<input class="telInput" type="number" id="fromTel2" name="fromTel2" value="${phone2}"/>
							<input class="telInput" type="number" id="fromTel3" name="fromTel3" value="${phone3}"/>
						</div>
					</li>
					<li class="userInput">
						<span class="fl infoTxt">이메일</span>
						<div class="fl">
							<input class="infoInput" type="text" name="mail" value="${mail}"/>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div class="inputUserInfo2">
			<div class="orderedPd">
				<p>배송지 정보</p>
			</div>
			<div>
				<ul style="height:500px;">
					<li class="userInput">
						 <input type="checkbox" id="sameasorder" class="fl">
						 <label for="sameasorder" class="fl"></label> <div class="fl" style="margin-left:11px;">주문자 정보와 동일</div> 
					</li>
					<li class="userInput">
						<span class="fl infoTxt">이름</span>
						<div class="fl">
							<input class="infoInput" type="text" id="toName" name="toName"/>
						</div>
					</li>
					<li class="addInputList">
						<%String[] arr = new String[2];
						arr[0] = "";
						arr[1] = "";
						String add_short = (String)(request.getAttribute("add_short"));
						if(add_short.length()>5) {
						String addd = (String)request.getAttribute("add_short");
						String [] arr2 = addd.split("\\*");
						arr[0] = arr2[0];
						arr[1] = arr2[1];
						}%>
						<span class="fl infoTxt">주소</span>
						<div class="fl">
							<ul style="padding:0;">
								<li class="addInputListOne">
									<input type="text" class="telInput" id="sample6_postcode" name="add_num"
									placeholder="우편번호" value="${add_num}">
									<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btnforadd">
								</li>
								<li class="addInputListOne">
									<input class="addInput" type="text" id="sample6_address" name="add_long"
									placeholder="주소" value="${add_long}">
								</li>
								<li class="addInputListOne">
									<input class="addinput4" type="text" id="sample6_detailAddress" name="add_short1"
									value="<%=arr[0]%>" placeholder="상세주소">
									<input type="text" id="sample6_extraAddress" class="telInput" name="add_short2"
									value="<%=arr[1]%>" placeholder="참고항목">
								</li>
							</ul>
						</div>
					</li>
					<li class="userInput">
						<span class="fl infoTxt">연락처 1</span>
						<div class="fl">
							<input class="telInput" type="tel" id="totel1" name="tel"/>
							<input class="telInput" type="tel" id="totel2" name="tel"/>
							<input class="telInput" type="tel" id="totel3" name="tel"/>
						</div>
					</li>
					<li class="userInput">
						<span class="fl infoTxt">연락처 2</span>
						<div class="fl">
							<input class="telInput" type="tel" id="input2"/>
							<input class="telInput" type="tel" id="input2"/>
							<input class="telInput" type="tel" id="input2"/>
						</div>
					</li>
					<li class="userInput" style="margin-top:10px;">
						 <input type="checkbox" id="useNextTime" class="fl" name="rememberAdd" value="yes" checked>
						 <label for="useNextTime" class="fl"></label> <div class="fl" style="margin-left:11px;">
						 주소 기억하기 (다음에도 이 주소 사용)</div> 
					</li>
				</ul>
			</div>
		</div>
		<div class="purchaseDiv">	
			<div class="firstBill">
				<p>결제 금액</p>
			</div>
			<div class="secondBill">
				<div class="fl"><p>상품 금액</p></div>
				<div style="float:right;"><p><%=sum1%> 원</p></div>
				<div class="fl" style="clear:both;"><p>총 할인</p></div>
				<div style="float:right; color:blue;"><p>(-) <%=sale_price%> 원</p></div>
				<div class="fl" style="clear:both;"><p>배송비</p></div>
				<div style="float:right;"><p>(+) <%=d_price1%> 원</p></div>
				<div class="fl" style="clear:both;"><h2>최종 결제금액</h2></div>
				<div style="float:right;"><h2><%=t_price%> 원</h2></div>
			</div>
			<div class="purchaseOption divCenter">
				<label class="box-radio-input"><input type="radio" name="cp_item"
				value="옵션1" checked="checked"><span>카카오페이</span></label>
				<label class="box-radio-input"><input type="radio" name="cp_item"
				value="옵션2"><span>신용카드</span></label>
				<label class="box-radio-input"><input type="radio" name="cp_item"
				value="옵션3"><span>계좌이체</span></label>
			</div>
			<div class="purchaseBtnDiv">
			<input type="hidden" name="command" value="afterPurchase"/>
			<input type="hidden" name="buynow" value="<%=request.getParameter("buyNow")%>"/>
				<button type="submit" class="purchaseBtn">
					결제하기
				</button>
			</div>
		</div>
	</form>
</body>
<script
  src="https://code.jquery.com/jquery-3.6.0.js"
  integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
  crossorigin="anonymous"></script>
<script>
$(document).ready(function(){
	var fromname = $("#fromname").val();
	var fromtel1 = $("#fromTel1").val();
	var fromtel2 = $("#fromTel2").val();
	var fromtel3 = $("#fromTel3").val();
    $("#sameasorder").change(function(){
        if($("#sameasorder").is(":checked")){
            $("#toName").val(fromname);
            $("#totel1").val(fromtel1);
            $("#totel2").val(fromtel2);
            $("#totel3").val(fromtel3);
        }
    });
});

</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</html>




















