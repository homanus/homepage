<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi2.jsp" %>
<jsp:useBean id="dao" class="guest.GuestDAO"></jsp:useBean>
<jsp:useBean id="dto" class="guest.GuestDTO"></jsp:useBean>
<jsp:setProperty name="dto" property="*"/>

<%

		boolean flag = dao.delete(dto.getGno());

		if(flag){
			if(dto.getFname()!=null && !dto.getFname().equals("member.jpg"))
				UploadSave.deleteFile(upDir, dto.getFname());
			%>
		<%
		}

%>

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
TABLE{
  margin: 0 auto;            /* 테이블 가운데 정렬 */
  border-color: #AAAAAA;     /* 테이블 외곽선 색깔 */ 
  border-width: 1px;         /* 테이블 외곽선 두께 */ 
  border-style: solid;       /* 테이블 외곽선 스타일 */
  border-collapse: collapse; /* 컬럼의 외곽선을 하나로 결합 */
  font-size: 20px;
  border-spacing:0px;
  border-style:none;
  padding:0px;
}
h1,h2,h3,h4,h5,h6 {font-family: "Oswald"}

body {font-family: "Open Sans"}
</style> 
<script type="text/javascript">
function greload(){
	opener.location.reload();
	self.close();
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<!-- *********************************************** -->
 
<div class="w3-white">
<div class="container">
<div class="w3-center">

<%if(flag){ 
 		out.print("<h2>삭제 성공</h2>");
 }else{
	 out.print("<h2>삭제 실패</h2>");
 }
 %>

  
    <input type='button' value='확인' class='w3-button w3-red' onclick="greload()">

</div></div></div> 
 
<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html> 