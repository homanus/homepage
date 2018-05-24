<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi3.jsp" %>
<jsp:useBean id="dao" class="bbs.BbsDAO"/>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%

	dto = dao.read(dto.getBbsno());

	
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
<script type="text/javascript">
function incheck(){
	
	var f = document.frm;
		
	if(f.wname.value==""){
		alert("이름을 입력해주세요.")
		f.wname.focus();
		return;
		}
	
	if(f.title.value==""){
		alert("제목을 입력해주세요.")
		f.title.focus();
		
		return;
		}
	
	if(f.content.value==""){
		alert("내용을 입력해주세요.")
		f.content.focus();
		
		return;
		}

	if(f.passwd.value==""){
		alert("비밀번호를 입력해주세요.")
		f.passwd.focus();
		
		return;
		}
	
	f.submit();
}

</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top2.jsp" flush="false"/>
<!-- *********************************************** -->
 <div class="w3-white">
<div class="container">

<h2><span class="glyphicon glyphicon-pencil">
</span>글 수정</h2>
 
<FORM name='frm' 
	  method='POST'
	  action='./updateproc.jsp'
	  enctype="multipart/form-data"
	  >
	  
	  <input type="hidden" name="bbsno" value="<%=dto.getBbsno()%>">
	  <input type="hidden" name="col" value='<%=request.getParameter("col")%>'>
	  <input type="hidden" name="word" value='<%=request.getParameter("word")%>'>
	  <input type="hidden" name="nowPage" value='<%=request.getParameter("nowPage")%>'>
	  <input type="hidden" name="oldfile" value='<%=dto.getFilename()%>'>
	  

  <TABLE class="table table-bordered">
    <TR>
      <TH><div style="margin:10px">작성자</div></TH>
      <TD><div style="margin:10px"><input type="text" name="wname" value="<%=dto.getWname()%>"></div></TD>
    </TR>
    <tr>
    	<th><div style="margin:10px">제목</div></th>
    	<td><div style="margin:10px"><input type="text" name="title" value="<%=dto.getTitle()%>"></div></td>
    </tr>
    <tr>
    	<th><div style="margin:10px">내용</div></th>
    	<td><div style="margin:10px"><textarea rows="5" cols="30" name="content"><%=dto.getContent()%></textarea></div></td>
    </tr>
     <tr>
    	<th><div style="margin:10px">비밀번호</div></th>
    	<td><div style="margin:10px"><input type="password" name="passwd"></div></td>
    </tr>
    <TR>
      <TH><div style="margin:10px">원본파일</div></TH>
      <TD><div style="margin:10px">
      원본파일명:<%= Utility.checkNull(dto.getFilename()) %>
      </div></TD>
    </TR>
     <tr>
    	<th><div style="margin:10px">변경파일</div></th>
    	<td>
    	<div style="margin:10px"><input type="file" name="filename">
    	</div></td>
    </tr>
  </TABLE>
  <p class="w3-center">
    <input type='button' class="w3-button w3-red" value='수정' onclick="incheck()">
    <input type='button' class="w3-button w3-white w3-border" value='취소' onclick="history.back()">
    </p>
</FORM>
</div>
</div>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 