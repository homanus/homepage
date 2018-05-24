<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi3.jsp" %>
<jsp:useBean id="dao" class="bbs.BbsDAO"/>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<jsp:setProperty name="dto" property="*"/>
<% 
		UploadSave upload = new UploadSave(request,-1,-1,tempDir);
		
	String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
	
	dto.setBbsno(Integer.parseInt(upload.getParameter("bbsno")));
	
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setWname(UploadSave.encode(upload.getParameter("wname")));
	

	Map map = new HashMap();
	map.put("passwd", dto.getPasswd());
	map.put("bbsno", dto.getBbsno());
	
	
	
	FileItem fileItem = upload.getFileItem("filename");
	
	int size = (int)fileItem.getSize();
	
	String filename = null;
	if(size>0){
		UploadSave.deleteFile(upDir, oldfile);
		filename = UploadSave.saveFile(fileItem, upDir);
		}
	
	
	dto.setFilesize(size);
// 	dto.setFilename(dao.getFname(dto.getBbsno()));
	dto.setFilename(filename);
	
	boolean pflag = dao.passcheck(map);
	boolean flag = false;	
	
	if(pflag){
		flag = dao.update(dto);
	}
	

	
	

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
function bcreate(){
	var url = "createform.jsp";
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
 

  
  <%if(pflag==false){
	  out.print("<h2>잘못된 비밀번호 입니다.</h2>");
	  out.print("<button type='button' class='w3-button w3-black' onclick='history.back()'>다시시도</button><br><br><br>");
  }else if(flag){
	  out.print("<h2>글 수정을 성공 하였습니다.</h2>");
  }else{
	  out.print("<h2>글 수정을 실패 했습니다.</h2>");
  }
	  %>
  
    <input type='submit' class="w3-button w3-red" value='등록' onclick="bcreate()">
    <input type='button' class="w3-button w3-white w3-border" value='목록' onclick="blist()">
 </div></div></div>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 