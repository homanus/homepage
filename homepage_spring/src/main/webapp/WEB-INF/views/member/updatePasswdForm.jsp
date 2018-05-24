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
<script type="text/javascript">
function mlist(){
	var url="${root}/admin/list";
	location.href=url;
}

function mread(){
	var url="${root}/member/read";
	url+="?id=${sessionScope.id}";
	url+="&col=${col}";
	url+="&word=${word}";
	url+="&nowPage=${nowPage}";
	location.href=url;
}

function inCheck(){
	var f = document.frm;

	if(f.passwd.value==""){
		alert("비밀번호를 입력해주세요");
		f.passwd.focus();
		return;
	}
	
	if(f.repasswd.value==""){
		alert("비밀번호 확인을 입력해주세요");
		f.repasswd.focus();
		
		return;
	}
	
	if(f.passwd.value!=f.repasswd.value){
		alert("비밀번호가 일치하지 않습니다");
		f.repasswd.focus();
		
		return;
	}
		f.submit();
}
</script>
</head> 
<body>
<div class="container">
<div align="center" class="signUp">
		<h1 class="signUpTitle">비밀번호 변경</h1>
<c:choose>
	<c:when test="${flag == false }">
		비밀번호가 틀렸습니다.
		<br><input class="signUpInput" type='button' value='다시시도' onclick='history.back()'>
	</c:when>
	<c:otherwise>
<FORM 	name='frm'
		method='POST'
		action='updatePasswdProc'
		>
		<input type="hidden" name="id" value="${param.id }">
		<input type="hidden" name="col" value="${param.col }">
		<input type="hidden" name="word" value="${param.word }">
		<input type="hidden" name="nowPage" value="${param.nowPage }">
		
		<input class="signUpInput" value="${param.id }">
    	<input class="signUpInput" placeholder="변경할 비밀번호" type="password" name="passwd" value="">
    	<input class="signUpInput" placeholder="비밀번호 확인" type="password" name="repasswd" value="">
  
    <input class="signUpButton" type='button' value='비밀번호 수정' onclick="inCheck()">
    <input class="signUpButton_black" type='button' value='내 정보로' onclick="mread()">
</FORM>
	</c:otherwise>
</c:choose>
</div>
 </div>
</body>
</html> 