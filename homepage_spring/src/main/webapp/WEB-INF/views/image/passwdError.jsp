<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
		<h1 class="signUpTitle">비밀번호 확인</h1>
			<h4>게시글의 비밀번호와 다릅니다.<br>
			</h4>
	    <input class="signUpButton" type='button' value='다시시도' onclick="history.back()">
	</div>
</div>
</body>
</html>