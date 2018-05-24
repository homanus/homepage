<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi3.jsp" %>
<jsp:useBean id="dao" class="bbs.BbsDAO"/>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%
	dto = dao.readReply(dto.getBbsno());



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
function incheck(f){
	if(f.wname.value==""){
		alert("이름을 입력해주세요.")
		f.wname.focus();
		
		return false;
		}
	if(f.title.value==""){
		alert("제목을 입력해주세요.")
		f.title.focus();
		
		return false;
		}
	if(f.content.value==""){
		alert("내용을 입력해주세요.")
		f.content.focus();
		
		return false;
		}

	if(f.passwd.value==""){
		alert("비밀번호를 입력해주세요.")
		f.passwd.focus();
		
		return false;
		}
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
</span>답변 등록</h2>

<FORM name='frm' 
	  method='POST'
	  action='./replyproc.jsp'
	  onsubmit="return incheck(this)"
	  enctype="multipart/form-data">
	  <input type='hidden' name='nowPage' value='<%=request.getParameter("nowPage")%>'>
	  <input type='hidden' name='col' value='<%=request.getParameter("col")%>'>
	  <input type='hidden' name='word' value='<%=request.getParameter("word")%>'>
	  <input type='hidden' name='bbsno' value='<%=dto.getBbsno()%>'>
	  <input type='hidden' name='grpno' value='<%=dto.getGrpno() %>'>
	  <input type='hidden' name='indent' value='<%=dto.getIndent()%>'>
	  <input type='hidden' name='ansnum' value='<%=dto.getAnsnum()%>'>

  <TABLE class="table table-bordered">
    <TR>
      <TH>작성자</TH>
      <TD><input type="text" name="wname"></TD>
    </TR>
    <tr>
    	<th>제목</th>
    	<td><input type="text" name="title" value="re:<%=dto.getTitle()%>"></td>
    </tr>
    <tr>
    	<th>내용</th>
    	<td><textarea rows="5" cols="30" name="content"></textarea></td>
    </tr>
    <tr>
    	<th>비밀번호</th>
    	<td><input type="password" name="passwd"></td>
    </tr>
    <tr>
    	<th>파일등록</th>
    	<td><input type="file" name="filename"></td>
    </tr>
  </TABLE>
  <p class="w3-center">
    <input type='submit' class="w3-button w3-red" value='답변'>
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