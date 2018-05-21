<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd1");

	
	Map map = new HashMap();
	map.put("id", id);
	map.put("passwd", passwd);
	
	boolean flag = dao.CheckPW(map);


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
function mlist(){
	var url="list.jsp";
	location.href=url;
}
function updatePasswd(){
	var url="updatePasswdProc.jsp";
	location.href=url;
}




function inCheck(){
	var f = document.frm;

	if(f.passwd.value==""){
		alert("비밀번호를 입력해주세요");
		f.passwd.focus();
		return;
	}
	
	if(f.repasswd.value==""){
		alert("비밀번호 확인을 입력해주세요");
		f.repasswd.focus();
		
		return;
	}
	
	if(f.passwd.value!=f.repasswd.value){
		alert("비밀번호가 일치하지 않습니다");
		f.repasswd.focus();
		
		return;
	}
		f.submit();
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 <div class="w3-white">
<div class="w3-center">
<%if(flag==false){ 
out.print("<h2>비밀번호가 틀렸습니다.</h2>");
out.print("<br><input type='button' class='w3-button w3-red' value='다시시도' onclick='history.back()'> ");
}else{

%>
<h2>비밀번호 변경</h2>
<FORM 	name='frm'
		method='POST'
		action='updatePasswdProc.jsp'
		>
		<input type="hidden" name="id" value="<%=dto.getId() %>">
		<input type="hidden" name="col" value="<%=request.getParameter("col") %>">
		<input type="hidden" name="word" value="<%=request.getParameter("word") %>">
		<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage") %>">
		
		
  <TABLE>
    <TR>
      <TH>아이디</TH>
      <TD><%=dto.getId() %></TD>
    </TR>
    <tr>
    	<th>비밀번호</th>
    	<td><input type="password" name="passwd" value=""></td>
    </tr>
    <tr>
    	<th>비밀번호 확인</th>
    	<td><input type="password" name="repasswd" value=""></td>
    </tr>
  </TABLE>
  <br>
    <input type='button' class="w3-button w3-black" value='비밀번호 수정' onclick="inCheck()">
    <input type='button' class="w3-button w3-red" value='목록' onclick="mlist()">
</FORM>
<%}%>
</div>
</div>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 