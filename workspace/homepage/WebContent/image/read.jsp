<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi4.jsp" %>
<jsp:useBean id="dao" class="image.ImageDAO"/>
<jsp:useBean id="dto" class="image.ImageDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%

	dto = dao.read(dto.getIno());

	dto.setContent(dto.getContent().replaceAll("\r\n", "<br>"));

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
.curImg{
	margin-right:0;
	border-style:solid;
	border-width: 3px;
	border-color: red;
}
.td_padding{
	padding:5px 5px;
}
</style> 
<script type="text/javascript">
function ilist(){
	var url = "list.jsp";
	url+="?nowPage=<%=request.getParameter("nowPage")%>";
	url+="&col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	location.href=url;
}
function icreate(){
	var url = "createForm.jsp";
	location.href=url;
}
function readGo(ino){
	var url="read.jsp";
	url+="?ino="+ino;
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
	url+="&col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	
	location.href=url;
}
function idelete(ino){
	var url="deleteForm.jsp";
	url+="?ino="+ino;
	url+="&fname=<%=dto.getFname()%>";
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
	url+="&col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	location.href=url;
}
function iupdate(ino){
	var url="updateForm.jsp";
	url+="?ino="+ino;
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
	url+="&col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	location.href=url;
}
function fileDown(fname){
	var url = "<%=root%>/download";
	url+="?filename="+fname;
	url+="&dir=/image/storage";
	
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
 
  <TABLE class="table table-hover">
    <tr>
     <TD colspan="2">
      <a href="javascript:fileDown('<%=dto.getFname()%>')"><img src="./storage/<%=dto.getFname() %>" width="100%"></a>
    </tr>
    <tr>
    	<th>이름</th>
    	<td><%=dto.getMname() %></td>
    </tr>
    <tr>
    	<th>제목</th>
    	<td><%=dto.getTitle() %></td>
    </tr>
    <tr>
    	<th>내용</th>
    	<td><%=dto.getContent() %></td>
    </tr>
    <tr>
    	<th>작성날짜</th>
    	<td><%=dto.getWdate() %></td>
    </tr>
    
  </TABLE>
  <table class="table table-hover">
  <tr>
  <%
  List list = dao.imglist(dto.getIno());
  String[] files = (String[])list.get(0);
  int[] noArr = (int[])list.get(1);
  for(int i=0; i<5; i++){
	  if(files[i]==null){
  %>
  <td class="td_padding"><img src="./storage/default.jpg" width="150px" height="125px"></td>
  <%
  
	  }else{
		  if(noArr[i]==dto.getIno()){
  %>
  <td class="td_padding"><a href="javascript:readGo('<%=noArr[i]%>')">
  <img class="curImg" src="./storage/<%=files[i] %>" width="150px" height="125px" border="0">
  </a></td>
  <%
		  }else{
  
  %>
  <td class="td_padding"><a href="javascript:readGo('<%=noArr[i]%>')">
  <img src="./storage/<%=files[i]%>" width="150px" height="125px" border="0">
  </a></td>
  <%
		  }
	  }
  }
  
  %>
  </tr>
  
  </table>
  
  
  <p class="w3-center" >
   <button type='button' class="w3-button w3-white w3-border" onclick="ilist()">목록</button>
    <button type='button' class="w3-button w3-white w3-border" onclick="icreate()">등록</button>
   <button type='button' class="w3-button w3-white w3-border" onclick="iupdate('<%=dto.getIno()%>')">수정</button>
   <button type='button' class="w3-button w3-black" onclick="idelete('<%=dto.getIno()%>')">삭제</button>
</p>	
  </div>
  </div>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 