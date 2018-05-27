<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<title></title> 
<link href="${root }/chat_util/css/member.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
function agreement(){
	var url = "${root}/member/agreement";
	location.href=url;
}
</script>
</head> 
<body>
<div class="w3-white">
	<div class="container">
		<div class="w3-center">
			<FORM class="signUp" name='frm' method='POST' action='${root }/member/loginProc'>
					
				  <input type="hidden" 	 name="rflag" 		value="${param.rflag }">
				  <input type="hidden"   name="nPage"		value="${param.nPage }">
				  <input type="hidden"	 name="col" 		value="${param.col }">
				  <input type="hidden"	 name="word"	 	value="${param.word }">
				  <input type="hidden"	 name="nowPage"		value="${param.nowPage }">
				  <input type="hidden"	 name="bbsno" 		value="${param.bbsno }">
				
			
				<h1 class="signUpTitle">Sign in !</h1>
				<c:choose>
			      	<c:when test="${c_id == 'Y' }">
			      		<input type='checkbox' name='c_id' value='Y' checked='checked'> ID저장
			      	</c:when>
			      	<c:otherwise>
			      		<input type='checkbox' name='c_id' value='Y'> ID 저장
			      	</c:otherwise>
			      </c:choose>
			      
				  <input class="signUpInput"
							autofocus
							type="text"
							name="id"
							value='${c_id_val }'
							required
							placeholder="ID">
							
			      <input class="signUpInput"
			      			type="password"
			      			name="passwd"
			      			value=""
			      			required
			      			placeholder="PASSWD">
			      			
				  <button class="signUpButton">Sign in</button>
			</FORM>
		</div>
	</div>
</div>
</body>
</html> 