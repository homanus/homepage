<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi3.jsp" %>
<jsp:useBean id="dao" class="bbs.BbsDAO" />
<jsp:useBean id="dto" class="bbs.BbsDTO" />
<jsp:setProperty name="dto" property="*"/>
<%     
		UploadSave upload = new UploadSave(request,-1,-1,tempDir);

		
		dto.setWname(UploadSave.encode(upload.getParameter("wname")));
		dto.setTitle(UploadSave.encode(upload.getParameter("title")));
		dto.setContent(UploadSave.encode(upload.getParameter("content")));
		dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
		
		FileItem fileItem = upload.getFileItem("filename");
		int size = (int)fileItem.getSize();
		String filename = null;
		
		if(size>0){
			filename = UploadSave.saveFile(fileItem, upDir);
		}
		
		dto.setFilename(filename);
		dto.setFilesize(size);
		
        boolean flag = dao.create(dto);
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 

</style> 
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top2.jsp" flush="false"/>
<!-- *********************************************** -->
 
 <div class="w3-white">
<div class="container">
<div class="w3-center">
 
<FORM name='frm' method='POST' action='createform.jsp'>
  <%
  if(flag)out.print("<h2>등록성공</h2>");
  else out.print("<h2>등록실패</h2>");
  %>
  
    <input type='submit' class='w3-button w3-red' value='계속등록'>
    <input type='button' class='w3-button w3-white w3-border' value='목록으로' onclick="location.href='list.jsp'">
</FORM>
 
 </div></div></div>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 