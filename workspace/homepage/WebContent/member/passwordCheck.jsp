<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%

	

%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 

</style> 
<script type="text/javascript">


</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
 
 <div class="w3-white">
<div class="w3-center">
<h2>비밀번호 확인</h2>
<FORM name='frm' method='POST' action='updatePasswdForm.jsp'>


		<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
		<input type="hidden" name="col" value="<%=request.getParameter("col") %>">
		<input type="hidden" name="word" value="<%=request.getParameter("word") %>">
		<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage") %>">
		

 <input type="password" name="passwd1" value="" required>
 <input class="w3-button w3-red" type='submit' value='수정하러가기'>
</FORM>
 
 </div>
 </div>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 