<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Oswald">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open Sans">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="${root }/chat_util/css/member.css" rel="Stylesheet" type="text/css">
<title></title> 
</head> 
<body>
 
<div class="container">
	<div class="signUp">
		<FORM name='frm' method='POST' action='deleteProc'>
			<h1 class="signUpTitle">회원 탈퇴</h1>
			<input class="signUpInput" type="hidden" name="id" value="${id }">
			<input class="signUpInput" type="hidden" name="fname" value="${fname }">
						<h4>
						정말 탈퇴 하시겠습니까?<br>
						회원 탈퇴시 복구하실 수 없습니다.
						</h4>
			<input class="signUpButton" type='submit' value='회원탈퇴' onclick="mdelete()">
			<input class="signUpButton" type='button' value='취소' onclick='history.back()'>
		
		</FORM>
	</div>
</div>
 
</body>
</html> 