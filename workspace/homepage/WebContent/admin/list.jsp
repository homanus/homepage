<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%


	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total")){
		word="";
	}

	int nowPage = 1;
	int recordPerPage = 3;
	
	if(request.getParameter("nowPage")!=null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}

	int sno = ((nowPage-1)*recordPerPage)-1;
	int eno = nowPage*recordPerPage;
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	
	List<MemberDTO> list = dao.list(map);
	
	int totalRecord = dao.total(map);
	
	String paging = Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);

%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 

<title></title> 
<style type="text/css"> 
.search{
	width:80%;
	margin:2px auto;
	text-align: center;
}
</style> 
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">--%>
<script type="text/javascript">
function create(){
	var url = "createForm.jsp";
	location.href=url;
}
function read(id){
	var url="<%=root%>/member/read.jsp";
	url+="?id="+id;
	url+="&col=<%=col%>";
	url+="&word=<%=word%>";
	url+="&nowPage=<%=nowPage%>";
	location.href=url;
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
<div class="w3-white">
<div class="search">
<form method="post" action='list.jsp'>
		
<select name="col">
<option value="id"
<%if(col.equals("id")){out.print("selected");} %>
>ID</option>
<option value="mname"
<%if(col.equals("mname")){out.print("selected");} %>
>이름</option>
<option value="email"
<%if(col.equals("email")){out.print("selected");} %>
>이메일</option>
<option value="total">전체출력</option>
</select>
<input type="search" name="word" value="<%=word %>" required>
<button>검색</button>
<button type="button" onclick="location.href='<%=root%>/member/createForm.jsp'">회원가입</button>
</form>


<div class="container-fluid">
<h2><span class="glyphicon glyphicon-th-list"></span>회원 목록</h2>
</div>
    <%for(int i=0; i<list.size(); i++){
    	
    		dto = list.get(i);
    		
   %> 

  <TABLE class="table table-hover">
    <TR>
      <td rowspan="5" width="30%"><img src="<%=root%>/member/storage/<%=dto.getFname() %>" width="300px" height="200px"></td>
      <TH width="20%">ID</TH>
      <td width="50%"><a href="javascript:read('<%=dto.getId()%>')"><%=dto.getId() %></a></td>
    </tr>
    <tr>
      <th>이름</th>
       <td><%=dto.getMname() %></td>
    </tr>
    <tr>
      <th>연락처</th>
      <td><%=dto.getTel() %></td>
    </tr>
    <tr>
      <th>이메일</th>
      <td><%=dto.getEmail() %></td>
    </tr>
    <tr>
    	<th>주소</th>
    	<td><%=Utility.checkNull(dto.getAddress1()) %>
    		<%=Utility.checkNull(dto.getAddress2()) %>
    	</td>
    </tr>
  </TABLE>
    
 
  <%} //for end
    %>
    
  <DIV class='bottom'>
  <%=paging %>
  </DIV>
  </div>
  </div>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 