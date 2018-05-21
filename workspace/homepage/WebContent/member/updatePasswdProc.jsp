<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%		
		Map map = new HashMap();
		map.put("id", dto.getId());
		map.put("passwd", dto.getPasswd());

		boolean flag = dao.updatePasswd(map);
		


%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 

</style> 
<script type="text/javascript">
function read(id){
	var url="read.jsp";
	url+="?id="+id;
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
<h2>비밀번호 수정 확인</h2>

<%if(flag){ out.print("<h4>비밀번호 수정 성공</h4>");
}else{out.print("<h4>비밀번호 수정 실패</h4>");}
	%>
 
    <input type='button' class="w3-button w3-red" value='내 정보로' onclick="read('<%=dto.getId()%>')">
 </div>
 </div>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html>