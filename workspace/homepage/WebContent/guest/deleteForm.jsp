<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi2.jsp" %>
<jsp:useBean id="dao" class="guest.GuestDAO"></jsp:useBean>
<jsp:useBean id="dto" class="guest.GuestDTO"></jsp:useBean>
<jsp:setProperty name="dto" property="*"/>
<%		
		Map map = new HashMap();
		map.put("id", session.getAttribute("id"));
		map.put("gno", dto.getGno());
		
		boolean flag = dao.idCheck(map);

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

function dehet(){
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

<%if(flag){ %>
 
<FORM name='frm' method='POST' action='deleteProc.jsp'>
<input type="hidden" name="gno" value="<%=dto.getGno()%>">
<input type="hidden" name="col" value="<%=request.getParameter("col")%>">
<input type="hidden" name="word" value="<%=request.getParameter("word")%>">
<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>">
<h2>삭제시 복구 불가<br>
정말로 삭제하시겠습니까?<br>
</h2>

  
    <input type='submit' class='w3-button w3-red' value='삭제'>
    <input type='button' class='w3-button w3-white w3-border' value='취소' onclick="self.close()">
</FORM>
<%}else{ %>

 		본인이 작성한 글이 아닙니다.
 		<br><input type='button' value='확인' onclick='dehet()'>
 <%}
 %>
 </div>
 </div>
 </div>
<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html> 