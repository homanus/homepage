<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi3.jsp" %>
<jsp:useBean id="dao" class="bbs.BbsDAO"/>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<jsp:setProperty name="dto" property="*"/>


<%
	boolean flag = dao.checkRefnum(dto.getBbsno());
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
function blist(){
	var url ="list.jsp";
	url+="?con=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
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
  <h2>※삭제시 복구하실 수 없습니다.</h2>
<%if(flag){ 
   out.print("답변 글이 있으므로 삭제할 수 없습니다.");
%>
<br>
<button type="button" onclick="history.back()">뒤로가기</button>
<%
}else{
%>


 
<FORM name='frm' method='POST' action='deleteproc.jsp'>
<input type="hidden" name="bbsno" value="<%=dto.getBbsno()%>"/>
<input type="hidden" name="col" value="<%=request.getParameter("col")%>"/>
<input type="hidden" name="word" value="<%=request.getParameter("word")%>"/>
<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage") %>">
<input type="hidden" name="oldfile" value="<%=request.getParameter("oldfile")%>"/>
  <TABLE>
    <TR>
      <TH><div style="margin:10px">비밀번호:</div></TH>
      <TD><div style="margin:10px"><input type="password" name="passwd" placehorder="비밀번호 입력" required></div></TD>
    </TR>
  </TABLE>
  
    <input type='submit' class="w3-button w3-black" value='삭제'>
    <input type='button' class="w3-button w3-white w3-border" value='목록' onclick="blist()">
</FORM>
 </div>
 </div>
 </div>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
<%}%>