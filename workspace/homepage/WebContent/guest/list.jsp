<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi2.jsp" %>
<jsp:useBean id="dao" class="guest.GuestDAO"/>
<jsp:useBean id="dto" class="guest.GuestDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%

	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total")){
		word = "";
	}

	int nowPage = 1;
	int recordPerPage = 3;
	
	if(request.getParameter("nowPage")!=null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	
	int sno = ((nowPage-1)*recordPerPage)+1;
	int eno = nowPage*recordPerPage;


	Map map = new HashMap();
	map.put("col",col );
	map.put("word",word );
	map.put("sno",sno );
	map.put("eno",eno );
	
	
	dto.setId((String)session.getAttribute("id"));
	
	List<GuestDTO>list = dao.list(map);
	
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

</style> 
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>

<script type="text/javascript">
function create(){
	var url = "createProc.jsp";
	location.href=url;
	
}
function gupdate(gno){
	var url = "updateForm.jsp";
	url+="?gno="+gno;
	url+="&col=<%=col%>";
	url+="&word=<%=word%>";
	url+="&nowPage=<%=nowPage%>";
	location.href=url;
	
}
function gdelete(gno){
	var url = "deleteForm.jsp";
	url+="?gno="+gno;
	url+="&col=<%=col%>";
	url+="&word=<%=word%>";
	url+="&nowPage=<%=nowPage%>";
	
	var wr = window.open(url,"음하하하하핳","width=500,height=500");
	wr.moveTo(((window.screen.width-500)/2),((window.screen.height-500)/2));
	
}

</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top2.jsp" flush="false"/>
<script type="text/javascript">
function agreement(){
	var url = "<%=root%>/member/agreement.jsp";
	location.href=url;
}
function login(){
	var url="../member/loginForm.jsp";
	location.href=url;
}
</script>
<!-- *********************************************** -->
<div class="w3-white">
<div class="w3-center">


 <%if(dto.getId()==null){
 out.print("비로그인 상태입니다.<br>");
 out.print("회원 커뮤니티는");
 out.print("<br>로그인 또는 회원가입 후 이용하실 수 있습니다.");
 out.print("<br><input type='button' class='w3-button w3-white w3-border' value='로그인' onclick='login()'> ");
 out.print(" <input type='button' class='w3-button w3-red' value='회원가입' onclick='agreement()'>");
 
 }else{%>

</div>
<!-- =========================================================== -->

<div class="container">
<h2><span class="glyphicon glyphicon-pencil"></span></h2>
<FORM 	name='frm'
		method='POST'
		action='createProc.jsp'
		enctype="multipart/form-data">
		<input type="hidden" name="id" value="<%=dto.getId()%>">
		<input type="hidden" name="passwd" value="<%=dto.getPasswd()%>">
		
  <TABLE class="table table-bordered">
    <TR>
      <tr>
    	<th>사진</th>
    	<td><input type='file' name='fname' accept=".jpg,.png,.gif">
    </tr>
    <tr>
    	<th>작성자</th>
    	<td><input type="text" name="gname" value=""></td>
    </tr>
    <tr>
    	<th>내용</th>
    	<td><textarea rows="5" cols="30" name="content"></textarea></td>
    </tr>
  </TABLE>
  <p class="w3-center">
    <input type='submit' class='w3-button w3-white w3-border' value='글 작성'>
    <input type="reset" class='w3-button w3-red' value="리셋">
    </p>
</FORM>

<br><br>
<br><br>

<!-- =========================================================== -->






		

		
		<h2><span class="glyphicon glyphicon-comment"></span>회원 커뮤니티</h2>

	<%for(int i=0; i<list.size(); i++){
			dto = (GuestDTO)list.get(i);
	
	%>

  <TABLE class="table table-hover">
    <TR>
      <td rowspan="5" width="30%"><img src="./storage/<%=dto.getFname() %>" width="300px" height="200px"></td>
      <th width="20%">이름</th>
      <td width="50%"><%=dto.getGname() %></td>
    </TR>
<%--     <tr>
    	<th>번호</th>
    	<td><%=dto.getGno() %></td>
    </tr> --%>
    <tr>
    	<th>내용</th>
    	<td><%=dto.getContent() %></td>
    </tr>
    <tr>
    	<th>작성시간</th>
    	<td><%=dto.getGdate() %></td>
    </tr>
    <tr>
   		<th>수정/삭제</th>
   		<td><a href="javascript:gupdate('<%=dto.getGno()%>')">수정</a>/
   		<a href="javascript:gdelete('<%=dto.getGno() %>')">삭제</a>
   		</td> 
    </tr>
    
  </TABLE>
  
  
  <%} %>
 </div>
 
  <div class="search">
  
<form method="post" action='list.jsp'>
		
<select name="col">
<option value="gname"
<%if(col.equals("gname")){out.print("selected");} %>
>이름</option>
<option value="content"
<%if(col.equals("content")){out.print("selected");} %>
>내용</option>
<option value="total">전체출력</option>
</select>
<input type="search" name="word" value="<%=word %>" required>
<button class='w3-button w3-white w3-border'>검색</button>
</form>
</div>
  <%=Utility.paging3(totalRecord, nowPage, recordPerPage, col, word) %>
 
<%}%>
</div>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 