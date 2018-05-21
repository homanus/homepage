<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%

		UploadSave upload = new UploadSave(request,-1,-1,tempDir);

		String id = upload.getParameter("id");
		String email = upload.getParameter("email");
		
		String str = "";
		
		if(dao.duplicateID(id)){
			str = "중복된 아이디 입니다.";
		}else if(dao.duplicateEmail(email)){
			str = "중복된 이메일 입니다.";
		}else{
			
			request.setAttribute("upload", upload);
			%>
			
			<jsp:forward page="/member/createProc.jsp"/>
			
		<%
		return;
		//더 이상 오지 말고 create페이지로 이동해라.
		}%>

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
h1,h2,h3,h4,h5,h6 {font-family: "Oswald"}

body {font-family: "Open Sans"}
</style> 
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top2.jsp" flush="false"/>
<!-- *********************************************** -->
 
<div class="w3-white margin">
<div class="w3-center">

<h4><%=str %></h4> <input type='button' class="w3-button w3-red" value='다시시도' onclick="history.back()">
 
 </div>
 </div>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 