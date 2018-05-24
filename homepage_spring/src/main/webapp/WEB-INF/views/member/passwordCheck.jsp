<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Oswald">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open Sans">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 
<link href="${root }/chat_util/css/member.css" rel="Stylesheet" type="text/css">
<title></title> 
</head> 
<body>

<div align="center" class="container">
	<div class="signUp">
		<h1 class="signUpTitle">비밀번호 확인</h1>
		<FORM name='frm' method='POST' action='updatePasswdForm'>
				<input type="hidden" name="id" value="${param.id }">
				<input type="hidden" name="col" value="${param.col }">
				<input type="hidden" name="word" value="${param.word }">
				<input type="hidden" name="nowPage" value="${param.nowPage }">
				<input class="signUpInput" type="password"
				name="passwd1" value="" required
				placeholder="비밀번호를 입력하세요">
		 <input class="signUpButton" type='submit' value='비밀번호 확인'>
		</FORM>
	</div>
</div>

<div style="margin-bottom: 30px;"></div>
 
</body>
</html> 