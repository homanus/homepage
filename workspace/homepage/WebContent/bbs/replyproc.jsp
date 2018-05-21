<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi3.jsp" %>
<jsp:useBean id="dao" class="bbs.BbsDAO"/>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%		UploadSave upload = new UploadSave(request,-1,-1,tempDir);

		dto.setWname(UploadSave.encode(upload.getParameter("wname")));
		dto.setTitle(UploadSave.encode(upload.getParameter("title")));
		dto.setContent(UploadSave.encode(upload.getParameter("content")));
		dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
		dto.setBbsno(Integer.parseInt(upload.getParameter("bbsno")));
		dto.setGrpno(Integer.parseInt(upload.getParameter("grpno")));
		dto.setIndent(Integer.parseInt(upload.getParameter("indent")));
		dto.setAnsnum(Integer.parseInt(upload.getParameter("ansnum")));
		
		FileItem fileItem = upload.getFileItem("filename");
		int size = (int)fileItem.getSize();
		String filename = null;
		if(size>0){
			filename = UploadSave.saveFile(fileItem, upDir);
		}
		
		dto.setFilename(filename);
		dto.setFilesize(size);
		
		 Map map = new HashMap();
		 map.put("grpno", dto.getGrpno());
		 map.put("ansnum", dto.getAnsnum());
	
		 dao.upAnsnum(map);
		
		 
		 boolean flag = dao.createReply(dto);
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 

</style> 
<script type="text/javascript">
function blist(){
	var url = "list.jsp";
	url+="?col=<%=UploadSave.encode(upload.getParameter("col"))%>";
	url+="&word=<%=UploadSave.encode(upload.getParameter("word"))%>";
	url+="&nowPage=<%=upload.getParameter("nowPage")%>";
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
		out.print("<h2>답변 성공</h2>");
	}else{
		out.print("<h2>답변 실패</h2>");
	}
	
	%>

  
 <p class="content"> 
    <input type='button' class="w3-button w3-red" value='목록' onclick="blist()">
    </p>
</div>
</div>
</div>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 