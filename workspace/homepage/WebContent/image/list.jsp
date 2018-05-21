<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi4.jsp" %>
<jsp:useBean id="dao" class="image.ImageDAO"/>
<jsp:useBean id="dto" class="image.ImageDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%
	
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total")){
		word = "";
	}
	
	int nowPage = 1;
	int recordPerPage = 5;
	
	if(request.getParameter("nowPage")!=null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	int sno = ((nowPage-1)*recordPerPage)+1;
	int eno = nowPage*recordPerPage;
	
	Map map = new HashMap();
	map.put( "col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	


	List<ImageDTO> list = dao.list(map);
	
	int totalRecord = dao.total(map);


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
.search{
	width:80%;
	margin:2px auto;
	text-align: center;
}
h1,h2,h3,h4,h5,h6 {font-family: "Oswald"}
body {font-family: "Open Sans"}
th{
text-align: center;
}
</style> 
<script type="text/javascript">
function icreate(){
	var url = "createForm.jsp";
	location.href=url;
}
function filedown(fname){
	var url = "<%=root%>/download";
	url+="?filename="+fname;
	url+="&dir=/image/storage";
	
	location.href=url;
	
}
function idelete(ino){
	var url="deleteForm.jsp";
	url+="?ino="+ino;
	url+="&fname=<%=dto.getFname()%>";
	url+="&nowPage=<%=nowPage%>";
	url+="&col=<%=col%>";
	url+="&word=<%=word%>";
	location.href=url;
}
function iupdate(ino){
	var url="updateForm.jsp";
	url+="?ino="+ino;
	url+="&nowPage=<%=nowPage%>";
	url+="&col=<%=col%>";
	url+="&word=<%=word%>";
	location.href=url;
}
function read(ino){
	var url = "read.jsp";
	url+="?ino="+ino;
	url+="&nowPage=<%=nowPage%>";
	url+="&col=<%=col%>";
	url+="&word=<%=word%>";
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
<h2><span class="glyphicon glyphicon-film"></span>이미지 게시판</h2>

<table class="table table-hover">
	<tr>
		<th><div style="margin:10px">사진</div></th>
		<th><div style="margin:10px">제목</div></th>
		<th><div style="margin:10px">이름</div></th>
		<th><div style="margin:10px">작성날짜</div></th>
		<th><div style="margin:10px">수정/삭제</div></th>
	</tr>
	<%if(list.size()==0){ %>
	<tr>
		<td colspan="5">작성된 글이 없습니다.</td>
	</tr>
	<%}else{
		for(int i=0; i<list.size(); i++){
			dto = list.get(i);
		
	
	%>
	
	<tr>
		<td><div style="margin:10px"><a href="javascript:filedown('<%=dto.getFname()%>')"<%=dto.getFname() %>><img src="./storage/<%=dto.getFname() %>" width="100px" height="80px"></a></div></td>
		<td><div style="margin:10px"><a href="javascript:read('<%=dto.getIno() %>')"><%=dto.getTitle() %></a></div></td>
		<td><div style="margin:10px"><%=dto.getMname() %></div></td>
		<td><div style="margin:10px"><%=dto.getWdate() %></div></td>
		<td><div style="margin:10px"><a href="javascript:iupdate('<%=dto.getIno()%>')">수정</a>/
		<a href="javascript:idelete('<%=dto.getIno()%>')">삭제</a></div></td>
	</tr>
	
	

	
    <%}//for%>
	<%}//if
		%>
</table>
 <div class="search">
<%=Utility.paging3(totalRecord, nowPage, recordPerPage, col, word) %>

<form name='frm' action='list.jsp' method='post'>
<select name="col">
	<option value="title"
	<%if(col.equals("title")) {out.print("selected");} %>
	>제목</option>
	<option value="mname"
	<%if(col.equals("mname")) {out.print("selected");} %> 
	>이름</option>
	<option value="total">전체</option>
</select>
<input type="search" name="word" value="<%=word%>" required>
<button  class="w3-button w3-white w3-border">검색</button>
<button type="button" class="w3-button w3-red" onclick="icreate()">등록</button>
</form>
</div>

 </div>
 </div> 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 