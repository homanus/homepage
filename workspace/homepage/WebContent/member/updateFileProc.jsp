<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%
		UploadSave upload = new UploadSave(request,-1,-1,tempDir);
		
		String id = UploadSave.encode(upload.getParameter("id"));
		String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
		String col = UploadSave.encode(upload.getParameter("col"));
		String word = UploadSave.encode(upload.getParameter("word"));
		String nowPage = UploadSave.encode(upload.getParameter("nowPage"));
		
		FileItem fileItem = upload.getFileItem("fname");
		
		int size = (int)fileItem.getSize();
		String fname = null;
		
		if(size>0){
			if(oldfile!=null && !oldfile.equals("member.jpg")){
				UploadSave.deleteFile(upDir, oldfile);
			}
			
			fname = UploadSave.saveFile(fileItem, upDir);
			//메모리상에 있는 파일을 실제로 storage폴더에 파일을 담겠다.
			
		}

		Map map = new HashMap();
		map.put("id", id);
		map.put("fname", fname);
		
		
		boolean flag = dao.updateFile(map);
		


%>


<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 

</style> 
<script type="text/javascript">
function read(){
	var url = "read.jsp";
	url+="?id=<%=id%>";
	location.href=url;
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
 <div class="w3-white">
<div class="w3-center">
<h2>사진 변경</h2>
 

<%if(flag){out.print("<h4>사진 변경 성공</h4>");} 
else {out.print("<h4>사진 변경 실패</h4>");}

%>

 	<input type='button' class="w3-button w3-red" value='나의정보' onclick="read()">
 </div>
 </div>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 