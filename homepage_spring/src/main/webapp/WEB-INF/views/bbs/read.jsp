<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi3.jsp" %>
<jsp:useBean id="dao" class="bbs.BbsDAO"/>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%		
		dao.upviewcnt(dto.getBbsno());
        dto = dao.read(dto.getBbsno());
		
		dto.setContent(dto.getContent().replaceAll("\r\n", "<br>"));
		
		/* Map map = new HashMap();
		map.put("bbsno", dto.getBbsno());
		map.put("passwd", dto.getPasswd());
		
		boolean pflag = dao.passcheck(map);
		boolean flag = false;
		
		if(pflag){
			flag = dao.delete(dto.getBbsno());
		} */
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Oswald">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open Sans">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title></title> 
<style type="text/css"> 
.bottom{
  margin: 20px auto;
  text-align: center;
  width: 100%;
  padding: 10px;  /* 위 오른쪽 아래 왼쪽 */
}
h1,h2,h3,h4,h5,h6 {font-family: "Oswald"}
body {font-family: "Open Sans"}

</style> 
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
<script type="text/javascript">
function blist(){
	var url = "list.jsp";
	url+="?col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
	location.href=url;
}
function bupdate(){
	var url = "updateform.jsp";
	url+="?bbsno=<%=dto.getBbsno()%>";
<%-- 	url+="&oldfile=<%=dto.getFilename()%>"; --%>
	url+="&col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
	location.href=url;
}
function bdelete(){
//	if(confirm("삭제시 복구하실 수 없습니다. \n 정말 삭제하시겠습니까?")){
	var url="deleteform.jsp";
	url+="?bbsno=<%=dto.getBbsno()%>";
	url+="&oldfile=<%=dto.getFilename()%>";
	url+="&col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
	location.href=url;
//}
}
function reply(bbsno){
	var url="replyform.jsp";
	url+="?bbsno="+bbsno;
	url+="&col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
	location.href=url;
}
function fileDown(filename){
	var url = "<%=root%>/download";
	url+="?filename="+filename;
	url+="&dir=/bbs/storage";
	
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
<h2><span class="glyphicon glyphicon-th-list"></span>게시글 내용</h2>
 

  <TABLE class="table table-hover">
    <TR>
      <TH>번호</TH>
      <TD><%=dto.getBbsno() %></TD>
    </TR>
    <TR>
      <TH>작성자</TH>
      <TD><%=dto.getWname() %></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><%=dto.getTitle() %></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><%=dto.getContent() %></TD>
    </TR>
    <%-- <tr>
    	<th>비밀번호</th>
    	<td><%=dto.getPasswd()%></td>
    </tr> --%>
    <TR>
      <TH>조회수</TH>
      <TD><%=dto.getViewcnt() %></TD>
    </TR>
    <TR>
      <TH>등록날짜</TH>
      <TD><%=dto.getWdate() %></TD>
    </TR>
  		<tr>
  		<th>파일명</th>
   		<td>
    	<%if(dto.getFilename()==null){
    		out.print("파일없음"); 
    	}else{%>
 			<a href="javascript:fileDown('<%=dto.getFilename()%>')"<%=dto.getFilename() %>><%=dto.getFilename() %>(<%=dto.getFilesize() %>)</a>
    	<%}%>
    	</td>
    	</tr>
  
  </TABLE>
  
  <DIV class='bottom'>
  	<button type="button" class="w3-button w3-white w3-border" onclick="reply('<%=dto.getBbsno()%>')">답변</button>
    <input type='button' class="w3-button w3-white w3-border" value='목록' onclick="blist()">
    <input type='button' class="w3-button w3-white w3-border" value='수정' onclick="bupdate()">
    <input type='button' class="w3-button w3-black" value='삭제' onclick="bdelete()">
  </DIV>
  </div>
 
 </div>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 