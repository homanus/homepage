<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%
		
		if(dto.getId()==null)dto.setId((String)session.getAttribute("id"));
		dto = dao.read(dto.getId());

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
TABLE{
  margin: 0 auto;            /* 테이블 가운데 정렬 */
  border-color: #AAAAAA;     /* 테이블 외곽선 색깔 */ 
  border-width: 1px;         /* 테이블 외곽선 두께 */ 
  border-style: solid;       /* 테이블 외곽선 스타일 */
  border-collapse: collapse; /* 컬럼의 외곽선을 하나로 결합 */
  font-size: 20px;

}
</style> 
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
<script type="text/javascript">
function mcreate(){
	var url="createForm.jsp";
	location.href=url;
}

function mdelete(id){
	var url="deleteForm.jsp";
	url+="?id="+id;
	url+="&col=<%=request.getParameter("col")%>"
	url+="&word=<%=request.getParameter("word")%>"
	url+="&nowPage=<%=request.getParameter("nowPage")%>"
	location.href=url;
}

function pwUpdate(id){
	var url="passwordCheck.jsp";
	url+="?id="+id;
	url+="&col=<%=request.getParameter("col")%>"
	url+="&word=<%=request.getParameter("word")%>"
	url+="&nowPage=<%=request.getParameter("nowPage")%>"
	location.href=url;
}

function infoUpdate(id){
	var url="updateInfoForm.jsp";
	url+="?id="+id;
	url+="&passwd=<%=request.getParameter("passwd")%>";
	url+="&col=<%=request.getParameter("col")%>"
	url+="&word=<%=request.getParameter("word")%>"
	url+="&nowPage=<%=request.getParameter("nowPage")%>"
	location.href=url;
}

function updateFile(){
	var url="updateFileForm.jsp";
	url+="?id=<%=dto.getId()%>";
	url+="&oldfile=<%=dto.getFname()%>";
	url+="&col=<%=request.getParameter("col")%>"
	url+="&word=<%=request.getParameter("word")%>"
	url+="&nowPage=<%=request.getParameter("nowPage")%>"
	location.href=url;
}

function mlist(){
	var url = "../admin/list.jsp";
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
	<header class="w3-container w3-center w3-padding-48 w3-white">
         <h1 class="w3-xxxlarge"><b><span class="glyphicon glyphicon-user"></span><%=dto.getMname() %>의 회원정보</b></h1>
  	</header>
 
  <TABLE class="table table-hover">
    <tr>
    	<td colspan="2"><img src=./storage/<%=dto.getFname() %>></td>
    </tr>
    <TR>
		<TH>id</TH>
		<td><%=dto.getId() %></td>
    </TR>
    <tr>
      <Th>이름</Th>
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
    	<th>우편번호</th>
    	<td><%=Utility.checkNull(dto.getZipcode()) %></td>
    </tr>
    <tr>
    	<th>주소</th>
    	<td>
    	<%=Utility.checkNull(dto.getAddress1()) %>
    	<br>
    	<%=Utility.checkNull(dto.getAddress2()) %>
    	</td>
    </tr>
    <tr>
    	<th>직업</th>
    	<td><%=dto.getJob() %>
    	<br>(<%=Utility.getCodeValue(dto.getJob()) %>)</td>
    </tr>
    <tr>
    	<th>가입날짜</th>
    	<td><%=dto.getMdate() %></td>
    </tr>
    <tr>
    	<th>등급</th>
    	<td><%=dto.getGrade() %></td>
    </tr>
  </TABLE>
  <br>
  <p class="w3-center">
  <button type='button' class="w3-button w3-blue" onclick="mlist()">목록</button>
  <button type='button' class="w3-button w3-blue" onclick="mcreate()">등록</button>
  <button type='button' class="w3-button w3-blue" onclick="infoUpdate('<%=dto.getId()%>')">정보수정</button>
  <br><br>
  <button type='button' class="w3-button w3-white w3-border" onclick="updateFile()">사진수정</button>
  <button type='button' class="w3-button w3-white w3-border" onclick="pwUpdate('<%=dto.getId()%>')">패스워드변경</button>
  <button type='button' class="w3-button w3-white w3-border" onclick="mdelete('<%=dto.getId()%>')">회원탈퇴</button>
  <button type='button' class="w3-button w3-white w3-border" onclick="location.href='<%=root %>/download?dir=/member/storage&filename=<%=dto.getFname()%>'">
  다운로드</button>
  </p>
  	<!-- <input type='button' value='목록' onclick="mlist()"> -->
    <%-- <input type='button' value='등록' onclick="mcreate()">
    <input type='button' value='정보수정' onclick="infoUpdate('<%=dto.getId()%>')">
    <br><br>
    <input type='button' value='사진수정' onclick="updateFile()">
    <input type='button' value='패스워드변경' onclick="pwUpdate('<%=dto.getId()%>')">
    <input type='button' value='회원탈퇴' onclick="mdelete('<%=dto.getId()%>')">
     <input type='button' value='다운로드'  
           onclick="location.href='<%=root %>/download?dir=/member/storage&filename=<%=dto.getFname()%>'">  
 --%>
  </div>
  </div>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 