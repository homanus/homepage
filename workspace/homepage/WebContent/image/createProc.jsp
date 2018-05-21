<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi4.jsp" %>
<jsp:useBean id="dao" class="image.ImageDAO"/>
<jsp:useBean id="dto" class="image.ImageDTO"/>

<%

	UploadSave upload = new UploadSave(request,-1,-1,tempDir);

	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
	dto.setMname(UploadSave.encode(upload.getParameter("mname")));
	dto.setWdate(upload.getParameter("wdate"));
	
	FileItem fileItem = upload.getFileItem("fname");
	
	int size= (int)fileItem.getSize();
	String fname = null;
	
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
function ilist(){
	var url = "list.jsp";
	location.href=url;
}
function icreate(){
	var url="createForm.jsp";
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
<%
if(flag){
	out.print("<h2>등록 성공</h2>");
}else{
	out.print("<h2>등록 실패</h2>");
}
%>
 <p class="w3-center">
<button type="button" class="w3-button w3-red" onclick="ilist()">목록</button>
<button type="button" class="w3-button w3-white w3-border" onclick="icreate()">등록</button>
 </p>
</div>
 </div>
 </div>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 