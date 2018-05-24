<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${root}/chat_util/css/main.3f6952e4.css" rel="stylesheet">
<link href="${root }/chat_util/css/member.css" rel="Stylesheet" type="text/css">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<script type="text/javascript">
var create = new function(){
	
	this.check = function(frm){
		
		$.post(
				"room_check",
				"",
				function(data, textStatus){
					
					if(data.room_flag == true){
						alert("채팅방은 1인당 한개만 생성하실 수 있습니다.");
						return false;
					}else{
						var url = "chatCreateProc";
						url += "?"+$("#form_id").serialize();
						location.href=url;
					}
				}
			)
	}
	
}
</script>
</head>
<body>
<form   name='frm'
		method='POST'
		onsubmit='create.check(this); return false;'
		id="form_id"
		class="signUp2"
		>
		
		<h1 class="signUpTitle">채팅방 만들기</h1>
		
		<input type="hidden" name="id" value="${sessionScope.id}"/>
		
		<input class="signUpInput" type="text" name="chat_nickname" size="20" value="${chat_nickname}" readonly>
		<input class="signUpInput" type="text" name="chat_title" size="20" required="required">
		
		<button class="signUpButton">채팅방 생성</button>
		<button class="signUpButton" onclick="history.back()">뒤로가기</button>
</form>
	

</body>
</html>