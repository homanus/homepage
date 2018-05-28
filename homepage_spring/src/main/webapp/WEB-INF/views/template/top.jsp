<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<!DOCTYPE html>
<html>
<title>Check</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Oswald">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open Sans">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
function chat(){
	var url="${root}/chat/list";
	
	var wr = window.open(url,"채팅창","width=440, height=610, resizable=no");
	wr.moveTo(((window.screen.width-500)/2),((window.screen.height-500)/2));
	
}
</script>
<style>
h1,h2,h3,h4,h5,h6 {font-family: "Oswald"}
body {font-family: "Open Sans"}
</style>
<body class="w3-light-grey">

<!-- Navigation bar with social media icons -->
<div class="w3-bar w3-black w3-hide-small">
  <a href="${root}/" class="w3-bar-item w3-button" style="text-align: center"><span class="glyphicon glyphicon-home" style="text-align: center"></span></a>
  <a href="${root}/bbs/list" class="w3-bar-item w3-button"><span class="glyphicon glyphicon-list"></span> Board</a>
  <a href="${root}/guest/list" class="w3-bar-item w3-button"><span class="glyphicon glyphicon-comment"></span> Member Communities</a>
  <a href="${root}/image/list" class="w3-bar-item w3-button"><span class="glyphicon glyphicon-film"></span> Image board</a>
  <a href="${root}/etc/m_Psychological_testing" class="w3-bar-item w3-button" target="blank"><i class="fa fa-frown-o"></i> Psychological Testing</a>
  <a href="javascript:chat()" class="w3-bar-item w3-button"><span class="glyphicon glyphicon-phone"></span> Chat room</a>
<!--   <a href="#" class="w3-bar-item w3-button"><i class="fa fa-flickr"></i>bang</a>
  <a href="#" class="w3-bar-item w3-button"><i class="fa fa-twitter"></i>boom</a>
  <a href="#" class="w3-bar-item w3-button"><i class="fa fa-linkedin"></i>bing</a> -->
  
   <c:if test="${not empty sessionScope.id && sessionScope.grade != 'A'}">
  		<a href="${root}/member/deleteForm" class="w3-bar-item w3-button w3-right"><span class="glyphicon glyphicon-scissors"></span> Close my account</a>
   </c:if>
  <c:choose>
  	<c:when test="${empty sessionScope.id}">
		<a href="${root}/member/agreement" class="w3-bar-item w3-button w3-right"><!-- <i class="fa fa-search"></i>--><span class="glyphicon glyphicon-user"></span> Sign up</a>
		<a href="${root}/member/loginForm" class="w3-bar-item w3-button w3-right"><span class="glyphicon glyphicon-log-in"></span> Sign in</a>
  	</c:when>
  	<c:otherwise>
		<a href="${root}/member/read" class="w3-bar-item w3-button w3-right"><span class="glyphicon glyphicon-user"></span> My info</a>
		<a href="${root}/member/logout" class="w3-bar-item w3-button w3-right"><span class="glyphicon glyphicon-log-out"></span> Sign out</a>
  	</c:otherwise>
  </c:choose>
  <c:if test="${not empty sessionScope.id && sessionScope.grade == 'A' }">
    <a href="${root}/admin/list" class="w3-bar-item w3-button w3-right"><span class="glyphicon glyphicon-lock"></span> Member list</a>
  </c:if>
</div>
  
<!-- w3-content defines a container for fixed size centered content, 
and is wrapped around the whole page content, except for the footer in this example -->
<div class="w3-content" style="max-width:1600px">

  <!-- Header -->
  <header class="w3-container w3-center w3-padding-48 w3-white">
    <h1 class="w3-xxxlarge"><b>About you</b></h1>
    <h6>Welcome to the community of <span class="w3-tag">Han's world</span></h6>
  </header>

  <!-- Image header -->
 
  </div>
