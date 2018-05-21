<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi4.jsp" %>
<jsp:useBean id="dao" class="image.ImageDAO"/>
<jsp:useBean id="dto" class="image.ImageDTO"/>
<%

	
	UploadSave upload = new UploadSave(request,-1,-1,tempDir);

	String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
	
	dto.setIno(Integer.parseInt(upload.getParameter("ino")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setMname(UploadSave.encode(upload.getParameter("mname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setWdate(upload.getParameter("wdate"));
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
	
	FileItem fileItem = upload.getFileItem("fname");
	int size = (int)fileItem.getSize();
	String fname = null;
	
	if(size>0){
		fname = UploadSave.saveFile(fileItem, upDir);
		UploadSave.deleteFile(upDir, oldfile);
		
	}
	dto.setFname(fname);
	
	
	Map map = new HashMap();
	map.put("ino", dto.getIno());
	map.put("passwd",dto.getPasswd());

	boolean cflag = dao.pwCheck(map);
	
	
	

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
	url+="?nowPage=<%=upload.getParameter("nowPage")%>";
	url+="&col=<%=UploadSave.encode(upload.getParameter("col"))%>";
	url+="&word=<%=UploadSave.encode(upload.getParameter("word"))%>";
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
<%
if(cflag){
	boolean flag = dao.update(dto);


	if(flag){
		out.print("<h2>수정 성공</h2>");
	}else{
		out.print("<h2>수정 실패</h2>");
	}

%>
<%}else{ %>
<p class="center">
	비밀번호를 잘못 입력하셨습니다.<br>
	 <button type='button' class="w3-button w3-red" onclick='ilist()'>목록</button>
	 <input type='button' class="w3-button w3-white w3-border" value='다시시도' onclick="history.back()">
</p>
	<%} %>

 <p class="center">
    <input type='button' class="w3-button w3-black" value='목록' onclick="ilist()">
 </p>
 </div>
 </div>
</div>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 