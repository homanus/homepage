<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp" %>
<%


		String id = (String)session.getAttribute("id");
		String grade = (String)session.getAttribute("grade");
		
		%>
<!DOCTYPE html>
<html>
<title>Check</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Oswald">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open Sans">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- ============================================ -->
<!-- ============================================ -->
<!-- ============================================ -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- ============================================ -->
<!-- ============================================ -->
<!-- ============================================ -->
<style>
h1,h2,h3,h4,h5,h6 {font-family: "Oswald"}
body {font-family: "Open Sans"}
</style>
<body class="w3-light-grey">

<!-- Navigation bar with social media icons -->

 <div class="w3-bar w3-black w3-hide-small">
  <a href="<%=root %>/index.jsp" class="w3-bar-item w3-button" style="text-align: center"><!-- <i class="fa fa-facebook-official"></i> --><span class="glyphicon glyphicon-home" style="text-align: center"></span></a>
  <a href="<%=root %>/bbs/list.jsp" class="w3-bar-item w3-button"><!-- <i class="fa fa-instagram"></i> --><span class="glyphicon glyphicon-list"></span> 게시판</a>
  <a href="<%=root %>/guest/list.jsp" class="w3-bar-item w3-button"><!-- <i class="fa fa-snapchat"></i> --><span class="glyphicon glyphicon-comment"></span> 회원 커뮤니티</a>
  <a href="<%=root %>/image/list.jsp" class="w3-bar-item w3-button"><span class="glyphicon glyphicon-film"></span> 이미지 게시판</a>
  <a href="<%=root %>/mobile/m_Psychological_testing.html" class="w3-bar-item w3-button"><i class="fa fa-frown-o" style="font-size:24px"></i>m심리테스트</a>
<!--   <a href="#" class="w3-bar-item w3-button"><i class="fa fa-flickr"></i>bang</a>
  <a href="#" class="w3-bar-item w3-button"><i class="fa fa-twitter"></i>boom</a>
  <a href="#" class="w3-bar-item w3-button"><i class="fa fa-linkedin"></i>bing</a> -->
  <a href="<%=root %>/member/agreement.jsp" class="w3-bar-item w3-button w3-right"><!-- <i class="fa fa-search"></i>--><span class="glyphicon glyphicon-user"></span> 회원가입</a>
  <a href="<%=root %>/member/loginForm.jsp" class="w3-bar-item w3-button w3-right"><span class="glyphicon glyphicon-log-in"></span> 로그인</a>
</div>
  
<!-- w3-content defines a container for fixed size centered content, 
and is wrapped around the whole page content, except for the footer in this example -->
<div class="w3-content" style="max-width:1600px">

  <!-- Header -->
  <header class="w3-container w3-center w3-padding-48 w3-white">
    <h1 class="w3-xxxlarge"><b>About what i love</b></h1>
    <h6>Welcome to the blog of <span class="w3-tag">Han's world</span></h6>
  </header>

  <!-- Image header -->
 
  </div>
