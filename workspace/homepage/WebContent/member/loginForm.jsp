<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%

String c_id = "";     // ID 저장 여부를 저장하는 변수, Y
String c_id_val = ""; // ID 값
 
Cookie[] cookies = request.getCookies(); 
Cookie cookie=null; 
 
if (cookies != null){ 
 for (int i = 0; i < cookies.length; i++) { 
   cookie = cookies[i]; 
 
   if (cookie.getName().equals("c_id")){ 
     c_id = cookie.getValue();     // Y 
   }else if(cookie.getName().equals("c_id_val")){ 
     c_id_val = cookie.getValue(); // user1... 
   } 
 } 
} 
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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
.r{
	margin:500px;
}
</style> 
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
<script type="text/javascript">
function agreement(){
	var url = "agreement.jsp";
	location.href=url;
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top2.jsp" />

<!-- *********************************************** -->
 
<!-- <DIV class="title">로그인</DIV> -->
<div class="w3-white">
 
<FORM name='frm' method='POST' action='<%=root %>/member/loginProc.jsp'>
  <TABLE>
    <TR>
      <TH>아이디</TH>
      <TD><input type="text" name="id" value='<%=c_id_val%>' required>
      <%
      if(c_id.equals("Y")){
      %>
      <input type='checkbox' name='c_id' value='Y' checked='checked'> ID저장
      <%}else{ %>
      <input type='checkbox' name='c_id' value='Y'> ID 저장
      <%} %>
      </TD>
    </TR>
    <tr>
    	<th>비밀번호</th>
    	<td><input type="password" name="passwd" value="" required></td>
    </tr>
  </TABLE>
  <br>
  <p class="w3-center">
  <button class="w3-button w3-red" >로그인</button>
  <button type="button" class="w3-button w3-black" onclick="agreement()">회원가입</button></p>
    <!-- <input type='submit' value='로그인'> -->
    <!-- <input type='button' value='회원가입' onclick="agreement()"> -->
</FORM>
 
 </div>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 