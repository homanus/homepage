<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi3.jsp" %>
<jsp:useBean id="dao" class="bbs.BbsDAO"/>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%  
		
		
		//검색관련====================================================
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		
		
		if(col.equals("total")) word="";
		//검색관련end=================================================
				
		//paging관련	================================================	
		int nowPage = 1; //현재 보고있는 페이지
		
		if(request.getParameter("nowPage")!=null){
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		
		int recordPerPage = 5;//한 페이지당 보여줄 레코드 개수
		//sno eno를 구하기 위해서는 recordPerPage, nowPage가 필요함.
		int sno = ((nowPage-1) * recordPerPage)+1;
		int eno = nowPage * recordPerPage;
		
		
		
		//=============================================================
		Map map = new HashMap();
		map.put("col",col);
		map.put("word",word);
		map.put("sno", sno);
		map.put("eno", eno);
		

        List<BbsDTO> list = dao.list(map);
        
		//전체레코드 개수 가져오기
		int totalRecord = dao.total(map);
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1">

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
function bread(bbsno){
	var url="read.jsp";
	url+="?bbsno="+bbsno;
	url+="&col=<%=col%>";
	url+="&word=<%=word%>";
	url+="&nowPage=<%=nowPage%>";
	location.href=url;
}
function bupdate(){
	var url="updateform.jsp";
	url+="?bbsno=<%=dto.getBbsno()%>";
	url+="&oldfile=<%=dto.getFilename()%>";
	url+="&col=<%=col%>";
	url+="&word=<%=word%>";
	url+="&nowPage=<%=nowPage%>";
	
	location.href=url;
	
}
function bdelete(){
//	if(confirm("삭제시 복구하실 수 없습니다. \n 정말 삭제하시겠습니까?")){
	var url="deleteform.jsp";
	url+="?bbsno=<%=dto.getBbsno()%>";
	url+="&oldfile=<%=dto.getFilename()%>";
	url+="&col=<%=col%>";
	url+="&word=<%=word%>";
	url+="&nowPage=<%=nowPage%>";
	location.href=url;
//	}
	
}
function create(){
	var url="createform.jsp";
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
<h2><span class="glyphicon glyphicon-th-list"></span>게시판 목록</h2>
 
 
  <TABLE style="width:100%">
  <thead>
    <TR>
      <TH><div style="margin:10px">번호</div></TH>
      <Th><div style="margin:10px">작성자</div></Th>
      <Th><div style="margin:10px">제목</div></Th>
      <Th><div style="margin:10px">작성날짜</div></Th>
      <Th><div style="margin:10px">조회수</div></Th>
      <Th><div style="margin:10px">파일명</div></Th>
      <!-- <TH>수정/삭제</TH> -->
    </tr>
    <tr>
    </thead>
    <%if(list.size()==0){ %>
    <tbody>
    <tr>
    	<td colspan="7">등록된 게시글이 없습니다.</td>
    </tr>
    </tbody>
    <%}else{
    
   			 	for(int i=0; i<list.size(); i++){
    				dto = list.get(i);
    	%>
    	<tbody>
    <tr>
    	<td><div style="margin:10px"><%=dto.getBbsno() %></div></td>
    	<td><div style="margin:10px"><%=dto.getWname() %></div></td>
    	<td><div style="margin:10px">
<% if(dto.getIndent()>0){ 
 		for(int r=0; r<dto.getIndent(); r++){
			out.print("&nbsp;&nbsp;");
		}
	out.print("<img src='../images/re.jpg'>");
	}
	
%>

    	<a href="javascript:bread('<%=dto.getBbsno() %>')"><%=dto.getTitle() %></a>
    	<%
    		if(Utility.compareDay(dto.getWdate())){
    			%>
    		
    			<img src="../images/new.gif">
    		<%
    		}%>
    	</div>
    	</td>
    	<td><div style="margin:10px"><%=dto.getWdate() %></div></td>
    	<td><div style="margin:10px"><%=dto.getViewcnt() %></div></td>
    	<td><div style="margin:10px">
    	<%if(dto.getFilename()==null){
    		out.print(Utility.checkNull(dto.getFilename())); 
    	}else{%>
 			<a href="javascript:fileDown('<%=dto.getFilename()%>')"<%=dto.getFilename() %>><%=dto.getFilename() %></a>
    	<%}%></div>
    	</td>
    	<!-- <td><a href="javascript:bupdate()">수정</a>
    	/<a href="javascript:bdelete()">삭제</a></td> -->
    </tr>
    </tbody>
    <%}//for end
    
    }//if end
    %>
  </TABLE>
  <DIV class='bottom'>
  <%=Utility.paging3(totalRecord, nowPage, recordPerPage, col, word) %>
  <div class="search">
 <form action="./list.jsp" method="post" name="fname">
 <select name="col"><!-- 검색할 컬럼 -->
 	<option value="wname"
 	<%if(col.equals("wname")) out.print("selected"); %>
 	>성명</option>
 	<option value="title"
 	<%if(col.equals("title")) out.print("selected"); %>
 	>제목</option>
 	<option value="content"
 	<%if(col.equals("content")) out.print("selected"); %>
 	>내용</option>
 	<option value="total">전체출력</option>
 </select>
 


 <input type="search" name="word" value="<%=word %>"  required> <!-- 검색어 -->
 <button class="w3-button w3-white w3-border">검색</button>
 <button type="button" class="w3-button w3-red" onclick="create()">등록</button>
 </form>

 </div>
  </DIV>
 </div>
 </div>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 