<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi2.jsp" %>
<jsp:useBean id="dao" class="guest.GuestDAO"/>
<jsp:useBean id="dto" class="guest.GuestDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%
		
		
		dto = dao.read(dto.getGno());

		dto = dao.read(dto.getGno());
		Map map = new HashMap();
		map.put("id", session.getAttribute("id"));
		map.put("gno", dto.getGno());
		
		boolean flag = dao.idCheck(map);

		String oldfile = dto.getFname();

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
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top2.jsp" flush="false"/>
<!-- *********************************************** -->
  <div class="w3-white">
<div class="container">
		<h2><span class="glyphicon glyphicon-pencil"></span></h2>
		
<%if(flag){ %>
<FORM 	name='frm'
		method='POST'
		action='updateProc.jsp'
		enctype="multipart/form-data">
		<input type="hidden" name="gno" value="<%=dto.getGno()%>">
		<input type="hidden" name="oldfile" value="<%=oldfile%>">
		<input type="hidden" name="col" value="<%=Utility.checkNull(request.getParameter("col"))%>">
		<input type="hidden" name="word" value="<%=Utility.checkNull(request.getParameter("word"))%>">
		<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>">
  <TABLE class="table table-bordered">
  	<tr>
  		<th>예전 사진</th>
  		<td><img src="./storage/<%=oldfile %>" width="50%" height="20%"><br>
    		  원본파일명:<%=oldfile %>
      </td>
  	
  	</tr>
    <TR>
      <tr>
    	<th>변경할 사진</th>
    	<td><input type="file" name="fname" accept=".jpg,.png,.gif">
    </tr>
    <tr>
    	<th>작성자</th>
    	<td><input type="text" name="gname" value="<%=dto.getGname()%>"></td>
    </tr>
    <tr>
    	<th>내용</th>
    	<td><textarea rows="5" cols="30" name="content"><%=dto.getContent() %></textarea></td>
    </tr>
  </TABLE>
  <p class="w3-center">
    <input type='submit' class='w3-button w3-red' value='수정'>
    <input type="button" class='w3-button w3-white w3-border' value="취소" onclick="history.back()">
    </p>
</FORM>
<%}else{ %>

 		본인이 작성한 글이 아닙니다.
 		<br><input type='button' class='w3-button w3-red' value='확인' onclick='history.back()'>
 <%}
 %>
 </div>
 </div>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 