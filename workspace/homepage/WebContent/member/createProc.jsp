<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<%
		UploadSave upload = (UploadSave)request.getAttribute("upload");
		
		dto.setId(UploadSave.encode(upload.getParameter("id")));
		dto.setMname(UploadSave.encode(upload.getParameter("mname")));
		dto.setAddress1(UploadSave.encode(upload.getParameter("address1")));
		dto.setAddress2(UploadSave.encode(upload.getParameter("address2")));
		dto.setPasswd(upload.getParameter("passwd"));
		dto.setTel(upload.getParameter("tel"));
		dto.setEmail(upload.getParameter("email"));
		dto.setZipcode(upload.getParameter("zipcode"));
		dto.setJob(upload.getParameter("job"));
		
		FileItem fileItem = upload.getFileItem("fname");
		int size = (int)fileItem.getSize();
		String fname="member.jpg";
		if(size>0){
			fname = UploadSave.saveFile(fileItem, upDir);
		}/* else{
			fname = "../images/new.gif";
		} */
		
		dto.setFname(fname);
		
		boolean flag = dao.create(dto);

%>
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
<script type="text/javascript">
function mlist(){
	var url = "list.jsp";
	location.href = url;
}
function login(){
	var url = "loginForm.jsp";
	location.href = url;
	
}

</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top2.jsp" flush="false"/>
<!-- *********************************************** -->
 
 <div class="w3-white">
<div class="w3-center">

 	<%
 		if(flag){
 			out.print("회원가입 성공");
 		}else{
 			out.print("회원가입 실패");
 		}
 	
 	%>
 
 <%if(flag){ %>

   <p class="w3-center">
    <button class="w3-button w3-red" onclick='login()'>로그인</button>
    </p>
  <%}else{ %>
  <button type="button" class="w3-button w3-black" onclick="history.back()">다시시도</button>
  
  <%} %>
  </div>
  </div>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 