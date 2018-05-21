<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>


<%
	String oldfile = request.getParameter("oldfile");

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
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
 <div class="w3-white">
<div class="w3-center">
<h2>사진 변경</h2>
 
<FORM 	name='frm'
		method='POST'
		action='updateFileProc.jsp'
		enctype="multipart/form-data">
		
		<input type="hidden" name="id" value="<%=dto.getId()%>">
		<input type="hidden" name="oldfile" value="<%=oldfile%>">
		<input type="hidden" name="col" value="<%=request.getParameter("col")%>">
		<input type="hidden" name="word" value="<%=request.getParameter("word")%>">
		<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>">
  <TABLE class="table table-bordered">
    <TR>
      <TH>원본파일</TH>
      <TD>
      <img src="./storage/<%=oldfile %>">
      원본파일명:<%=oldfile %>
      </TD>
    </TR>
    <tr>
    	<th>변경파일</th>
    	<td>
    	<input type="file" name="fname" accept=".jpg,.gif,.png">
    	</td>
    </tr>
  </TABLE>
  
    <p class="w3-center">
  <button class="w3-button w3-black"><b>변경  </b><span class="w3-tag w3-white"></span></button>
  <button type='button' class="w3-button w3-black" onclick="history.back()"><b>취소  </b><span class="w3-tag w3-white"></span></button>
  </p>

</FORM>
 </div>
 </div>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 