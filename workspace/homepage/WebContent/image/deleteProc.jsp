<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi4.jsp" %>
<jsp:useBean id="dao" class="image.ImageDAO"/>
<jsp:useBean id="dto" class="image.ImageDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%

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
function ilist(){
	var url = "list.jsp";
	url+="?nowPage=<%=request.getParameter("nowPage")%>";
	url+="&col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
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
		boolean flag = dao.delete(dto.getIno());
		
		if(flag){
			UploadSave.deleteFile(upDir, dto.getFname());
		}
		
 if(flag){
	 out.print("<h2>삭제 성공</h2>");
 }else{
	 out.print("<h2>삭제 실패</h2>");
 }
 
 }else{ %>
<h2>비밀번호를 잘못 입력하셨습니다.<br></h2>
 <input type='button' class="w3-button w3-red" value='다시시도' onclick="history.back()">

<%} %>
 
    <input type='button' class="w3-button w3-white w3-border" value='목록' onclick="ilist()">
</div>
 </div>
 </div>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 