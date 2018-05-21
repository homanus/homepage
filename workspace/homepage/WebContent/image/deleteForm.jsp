<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi4.jsp" %>
<jsp:useBean id="dto" class="image.ImageDTO"></jsp:useBean>
<jsp:useBean id="dao" class="image.ImageDAO"></jsp:useBean>
<jsp:setProperty name="dto" property="*"/>
		<%
			
		

		
		
			dto.setFname(dao.getFname(dto.getIno()));
		
		
		%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 

</style> 
<script type="text/javascript">
function ilist(){
	var url = "list.jsp";
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
	url+="&col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	location.href=url;
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top2.jsp" flush="false"/>
<!-- *********************************************** -->

<div class="w3-white">
<div class="container">
<div class="w3-center">



<FORM name='frm' method='POST' action='deleteProc.jsp'>
		<input type="hidden" name="ino" value="<%=dto.getIno()%>"/>
		<input type="hidden" name="fname" value="<%=dto.getFname()%>">
		<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>">
		<input type="hidden" name="col" value="<%=request.getParameter("col")%>">
		<input type="hidden" name="word" value="<%=request.getParameter("word")%>">
<h2>정말로 삭제하시겠습니까?<br>
  삭제시 복구하실 수 없습니다.<br></h2>
 <div>
  비밀번호:<input type="password" name="passwd">
  <input type='submit' class="w3-button w3-black" value='삭제'>
  <input type='button' class="w3-button w3-white w3-border" value='취소' onclick="history.back()">
 </div>
</FORM>
</div>
</div>
</div>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 