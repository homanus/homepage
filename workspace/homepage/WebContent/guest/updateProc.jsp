<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi2.jsp" %>
<jsp:useBean id="dao" class="guest.GuestDAO"/>
<jsp:useBean id="dto" class="guest.GuestDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%

		UploadSave upload = new UploadSave(request,-1,-1,tempDir);

		dto.setGno(Integer.parseInt(upload.getParameter("gno")));
		dto.setGname(UploadSave.encode(upload.getParameter("gname")));
		dto.setContent(UploadSave.encode(upload.getParameter("content")));
		dto.setGdate(upload.getParameter("gdate"));
		
		dto.setFname(dao.getFname(dto.getGno()));
		
		String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
		
		String col = UploadSave.encode(upload.getParameter("col"));
		String word = UploadSave.encode(upload.getParameter("word"));
		String nowPage = upload.getParameter("nowPage");
		
		FileItem fileItem = upload.getFileItem("fname");
		
		int size = (int)fileItem.getSize();
		String fname=null;
		if(size>0){
			if(oldfile!=null && !oldfile.equals("member.jpg")){
				UploadSave.deleteFile(upDir, oldfile);
				
				fname = UploadSave.saveFile(fileItem, upDir);
			}
		}
		
		boolean flag = dao.update(dto);

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
	url+="?col=<%=col%>";
	url+="&word=<%=word%>";
	url+="&nowPage=<%=nowPage%>";
	location.href=url;
	
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
  <div class="w3-white">
<div class="container">
<div class="w3-center">

<%if(flag){
	out.print("<h2>수정 성공</h2>");
}else{
	out.print("<h2>수정 실패</h2>");
	
}
%>
 

  
    <input type='button' class='w3-button w3-red' value='목록으로' onclick="mlist()">
  </DIV>
  </div>
  </div>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 