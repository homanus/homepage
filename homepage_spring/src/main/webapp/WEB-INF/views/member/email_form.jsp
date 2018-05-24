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
<link href="${root}/chat_util/css/member.css" rel="Stylesheet" type="text/css">
<title></title> 
</head> 
<body>
<div class="container">

<FORM name='frm' method='POST' action='email_proc' class="signUp1">
	<h1 class="signUpTitle">이메일 중복확인</h1>
	<input class="signUpInput" type="email" name="email" size="20" required placeholder="사용하실 이메일을 입력하세요.">
	<button class="signUpButton">중복확인</button>
  
</FORM>
</div>
 
</body>
</html> 