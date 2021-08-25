<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%String id = (String)session.getAttribute("id"); %>
<meta charset="UTF-8">
<link rel="stylesheet" href="CSS/DH.css">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<%String Id = (String)session.getAttribute("user_id");%>
<script>
function checkId(){
	var RegExp = /^[a-zA-z0-9]{4,12}$/;
	var id = $(".id1").val();
	if(!RegExp.test(id)||id==" "){
		return false;
	}else
		return true;	
};
function checkPw(){
	var RegExp2 = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[~!@#$%^&*()+|=])[A-Za-z\d~!@#$%^&*()+|=]{8,20}$/;
	var pw = $(".pw1").val();
	if(!RegExp2.test(pw)||pw==" "){
		$(".pwCheck").html('<p style="color:red; text-align:center;">비밀번호를 8자에서 20자의 영문,숫자,특수문자를 혼합하여 공백없이 입력해주세요</p>');
		$(".pw2").css('margin-top','0');
		return false;
	}
	else{		
		$(".pwCheck").html('<p style="color:red; text-align:center;"></p>');
		$(".pw2").css('margin-top','0');
		return true;
	}
};
function checkPw2(){
	var pw = $(".pw1").val();
	var pw2 = $(".pw2").val();
	if(pw!=pw2){
		$(".pw2Check").html('<p style="color:red; text-align:center;">비밀번호를 확인해주세요</p>');
		$(".email").css('margin-top','0');
		return false;
	}else{		
		$(".pw2Check").html('<p style="color:red; text-align:center;"></p>');
		$(".email").css('margin-top','0');
		return true;	
	}
};
function checkName(){
	var RegExp3 = /^[가-힣]{2,6}$/;
	var name = $(".name1").val();
	if(!RegExp3.test(name)||name==" "){
		$(".nameCheck").html('<p style="color:red; text-align:center;">2자에서 6자의 한글을 입력해주세요</p>');
		$(".id1").css('margin-top','0');
		return false;
	}else{		
		$(".nameCheck").html('<p style="color:red; text-align:center;"></p>');
		$(".id1").css('margin-top','0');
		return true;	
	}
};
function checkNickName(){
	var RegExp6 = /^[가-힣]{2,10}$/;
	var nickname = $(".nickname1").val();
	if(!RegExp6.test(nickname)||nickname==" "){
		$(".nicknameCheck").html('<p style="color:red; text-align:center;">2자에서 10자의 한글을 입력해주세요</p>');
		$(".id1").css('margin-top','0');
		return false;
	}else{		
		$(".nicknameCheck").html('<p style="color:red; text-align:center;"></p>');
		$(".id1").css('margin-top','0');
		return true;	
	}
};
function checkEmail(){
	var RegExp4 = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var email = $(".email").val();
	if(!RegExp4.test(email)||email==" "){
		return false;
	}else
		return true;
};
/* function checkPhone(){
	var RegExp5 = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
	var phone = $(".phone").val();
	if(!RegExp5.test(phone)||phone==" "){
		return false;
	}else
		return true;	
}; */
function check(){
	if(checkName()==false||$(".name").val()==""){
		alert('이름 칸을 확인하세요!')
		return false;
	}else if(checkId()==false||$(".id1").val()==null){
		alert('아이디 칸을 확인하세요!')
		return false;
	}else if(checkNickName()==false||$(".nickname1").val()==null){
		alert('닉네임 칸을 확인하세요!')
		return false;
	}else if(checkPw()==false||$(".pw1").val()==null){
		alert('비밀번호 칸을 확인하세요!')
		return false;
	}else if(checkPw2()==false||$(".pw2").val()==null){
		alert('비밀번호 확인 칸을 확인하세요!')
		return false;
	}else if(checkEmail()==false||$(".email").val()==null){
		alert('이메일 칸을 확인하세요!')
		return false;
	}else if(checkPhone()==false||$(".phone").val()==null){
		alert('핸드폰 번호 칸을 확인하세요!')
		return false;
	}else{
		alert('회원가입을 축하합니다!')
		return true;		
		}
}

$(function() {
	$(".id1").keyup(function(){
		var id = $(".id1").val();
		$.ajax({	
			type:"get",
			url:"HCController?command=IdCheck",
			data:{"id":id},
			datatype:"json",
			success:function(data){
				if(data.loginCheck==1){
					$(".idCheck").html('<p style="color:red; text-align:center;">중복된 아이디입니다</p>');
					$(".nickname1").css('margin-top','0');
				}else if(checkId()==false){
					$(".idCheck").html('<p style="color:red; text-align:center;">아이디를 4자에서 13자의 영문 혹은 숫자로 공백없이 입력해주세요</p>');
					$(".nickname1").css('margin-top','0');
				}else if(data.loginCheck==0&&checkId()==true){
					$(".idCheck").html('<p style="color:blue; text-align:center;">사용가능한 아이디입니다</p>');
					$(".nickname1").css('margin-top','0');					
				}else{
					$(".idCheck").html('<p> </p>');
				}
			},
			error:function(request,status,error){alert(request.status+"\n"+request.responseText+"\n"+error)}
		});
	});
	$(".nickname1").keyup(function(){
		var nickname = $(".nickname1").val();
		$.ajax({	
			type:"get",
			url:"HCController?command=NickNameCheck",
			data:{"nickname":nickname},
			datatype:"json",
			success:function(data){
				if(data.loginCheck==1){
					$(".nicknameCheck").html('<p style="color:red; text-align:center;">중복된 닉네임입니다</p>');
					$(".pw1").css('margin-top','0');
				}else if(checkNickName()==false){
					$(".nicknameCheck").html('<p style="color:red; text-align:center;">닉네임을 2자에서 10자의 한글로 공백없이 입력해주세요</p>');
					$(".pw1").css('margin-top','0');
				}else if(data.loginCheck==0&&checkNickName()==true){
					$(".nicknameCheck").html('<p style="color:blue; text-align:center;">사용가능한 닉네임입니다</p>');
					$(".pw1").css('margin-top','0');					
				}else{
					$(".nicknameCheck").html('<p> </p>');
				}
			},
			error:function(request,status,error){alert(request.status+"\n"+request.responseText+"\n"+error)}
		});
	});
	$(".email").keyup(function(){
		var email = $(".email").val();
		$.ajax({
			type:"get",
			url:"HCController?command=EmailCheck",
			data:{"email":email},
			datatype:"json",
			success:function(data){
				if(data.loginCheckE==1){
					$(".emailCheck").html('<p style="color:red; text-align:center;">중복된 이메일입니다</p>');
					$(".email").css('background-color:','red');
					$(".phone").css('margin-top','0');
				}else if(checkEmail()==false){
					$(".emailCheck").html('<p style="color:red; text-align:center;">입력하신 이메일 주소를 다시 한 번 확인해주십시오  ex)zkakzlfl1234@naver.com</p>');
					$(".phone").css('margin-top','0');					
				}else if(data.loginCheckE==0&&checkEmail()==true){
					$(".emailCheck").html('<p style="color:blue; text-align:center;">사용가능한 이메일입니다</p>');
					$(".phone").css('margin-top','0');
				}
			},
			error:function(request,status,error){alert("ERR.")}
		});
	/* $(".phone").keyup(function(){
		var phone = $(".phone").val();
		$.ajax({
			type :"get",
			url : "HCController?command=PhoneCheck", 
			data : {"phone":phone},
			datatype : "json",
			success:function(data){
				if(data.loginCheckP==1){
					$(".phoneCheck").html('<p style="color:red; text-align:center;">중복된 번호입니다</p>');
					$(".loginbtn1").css('margin-top','0');
				}else if(checkPhone()==false){
					$(".phoneCheck").html('<p style="color:red; text-align:center;">번호를 확인해주세요 ex)0109452333</p>');
					$(".loginbtn1").css('margin-top','0');
				}else if(data.loginCheckP==0||checkPhone()==true){
					$(".phoneCheck").html('<p style="color:blue; text-align:center;">사용가능한 번호입니다</p>');
					$(".loginbtn1").css('margin-top','0');
				}	
			},
			error:function(request,status,error){alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	}
		});
	}); */
		
	});
});
$(function(){
	$(".logout_text").click(function(){
		<%
			if(id!=null){%>
				alert('로그아웃 되었습니다! 다음에 또 오세요!')
				location.href = "HCController?command=Board_Main";
			<%}else{%>
				alert('뭐가 문제지...')
			<%}%>
	});
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
<body>
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
	<div class = "content">
	<form action = "HCController"> 
			<input type = "text" name = "name" class = "name1 " onkeyup = "checkName();" placeholder = "이름을 입력해주세요"><br/>
			<a style = "text-decoration:none;" class = "nameCheck"></a><br/>
			
			<input type = "text" name = "id" class = "id1"  value = "" placeholder = "아이디를 입력해주세요"><br/> 
			<a style = "text-decoration:none;" class = "idCheck"></a><br/>
			
			<input type = "text" name = "nickname" class = "nickname1"  value = "" placeholder = "닉네임을 입력해주세요"><br/> 
			<a style = "text-decoration:none;" class = "nicknameCheck"></a><br/>
			
			<input type = "password" name = "pw" class = "pw1 " onkeyup = "checkPw();" placeholder = "비밀번호를 입력해주세요"><br/>
			<a style = "text-decoration:none;" class = "pwCheck"></a><br/>
			
			<input type = "password" name = "pw2" class = "pw2 " onkeyup = "checkPw2();" placeholder = "비밀번호를 다시 한번 입력해주세요"><br/>
			<a style = "text-decoration:none;" class = "pw2Check"></a><br/>
			
			<input type = "email" name = "email" class = "email " placeholder = "이메일 주소를 입력해주세요"><br/>
			<a style = "text-decoration:none;" class = "emailCheck"></a><br/>
			
			<input type = "text" name = "phone" class = "phone " placeholder = "전화번호를 입력해주세요"><br/>
			<a style = "text-decoration:none;" class = "phoneCheck"></a><br/>
			
			<button id="here" type = "submit" name = "command" value = "Join_insert" class = "loginbtn1"  onclick = "return check(); Join();"><span style = "font-family:sans; font-size:20px;">Join</span></button>
		 </form> 
		<img src = "Images/편안.png" class = "cat1">
		<img src = "Images/호다닥.png" class = "cat2">
	</div>


</body>
</html>