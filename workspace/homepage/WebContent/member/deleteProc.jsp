<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%
		String fname = request.getParameter("fname");
		
		
		

		boolean flag = dao.delete(dto.getId());
		
		
		if(flag){
			if(fname!=null && !fname.equals("member.jpg"))
			UploadSave.deleteFile(upDir, fname );
			session.invalidate();
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
function mlist(){
	var url="list.jsp";
	location.href=url;
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top2.jsp" flush="false"/>
<!-- *********************************************** -->
  <div class="w3-white">
<div class="w3-center">
<h2>삭제 확인</h2>
<%if(flag){
	out.print("<h4>회원탈퇴 완료. 자동으로 로그아웃 되었습니다.</h4>");
}else{
	out.print("<h4>탈퇴 실패.</h4>");
	out.print("<input type='button' class='w3-button w3-red' value='다시시도' onclick='history.back()'>");
}
%>
 

   
    <input type='button' class="w3-button w3-black" value='홈으로' onclick="location.href='../index.jsp'">
 
 </div>
 </div>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 