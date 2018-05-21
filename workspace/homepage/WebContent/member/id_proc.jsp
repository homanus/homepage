<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%
	boolean flag = dao.duplicateID(dto.getId());
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 

</style> 
<script type="text/javascript">
function use(){
	opener.frm.id.value="<%=dto.getId()%>";
	self.close();
	
	
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<!-- *********************************************** -->
 <div class="w3-white">
<div class="w3-center">
<h2><span class="glyphicon glyphicon-th-list"></span>아이디 중복 확인</h2>

 
 입력된 ID:<%=dto.getId() %> <br><br>
 
 <%
 if(flag){
	 out.print("중복되어서 사용할 수 없습니다.<br><br>");
 %>
     <p class="w3-center">
    <button class="w3-button w3-red" onclick='location.href="id_form.jsp"'>다시시도</button>
    </p>
 
 
 <%}else{
	 out.print("중복아님, 사용 가능합니다.<br><br>");
	 out.print("<button class='w3-button w3-white w3-border' onclick='use()'>사용</button> ");
 }
 
 
 %>

  
  <button type="button" class="w3-button w3-black" onclick="window.close()">닫기</button>
 </div>

  </div>
 
 
<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html> 