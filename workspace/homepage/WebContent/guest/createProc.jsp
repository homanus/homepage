<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi2.jsp" %>
<jsp:useBean id="dao" class="guest.GuestDAO"/>
<jsp:useBean id="dto" class="guest.GuestDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%
		UploadSave upload = new UploadSave(request,-1,-1,tempDir);
		
		dto.setId(UploadSave.encode(upload.getParameter("id")));
		dto.setGname(UploadSave.encode(upload.getParameter("gname")));
		dto.setContent(UploadSave.encode(upload.getParameter("content")));
		
		
		FileItem fileItem = upload.getFileItem("fname");
		String fname = "member.jpg";
		
		int size = (int)fileItem.getSize();
		if(size>0){
			fname = UploadSave.saveFile(fileItem, upDir);
		}
		
		dto.setFname(fname);
		
		boolean flag = dao.create(dto);
		


%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 

</style> 
<script type="text/javascript">
function mlist(){
	var url = "list.jsp";
	location.href = url;
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
<%if(flag){
	out.print("<h2>등록 성공</h2>");
}else{
	out.print("<h2>등록 실패</h2>");
}

%>

 
  
    <input type='button' class='w3-button w3-red' value='목록' onclick="mlist()">
</div>
</div>
</div> 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 