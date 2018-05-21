<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>
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
  font-size: 15px;
  border-spacing:0px;
  border-style:none;
  padding:0px;
}

h1,h2,h3,h4,h5,h6 {font-family: "Oswald"}

body {font-family: "Open Sans"}

</style> 
</head> 
<!-- *********************************************** -->
<body>
<!-- *********************************************** -->
 
<div class="w3-white">
<div class="w3-center">
<h2><span class="glyphicon glyphicon-th-list"></span>이메일 중복 확인</h2>
 
<FORM name='frm' method='POST' action='./email_proc.jsp'>
  <TABLE>
    <TR>
      <TD><input type="email" name="email" size="20" required></TD>
    </TR>
  </TABLE>
  
 <p class="w3-center">
    <button class="w3-button w3-red" >중복확인</button>
  <button type="button" class="w3-button w3-black" onclick="window.close()">취소</button></p>
</FORM>
 </div>
 </div>
 
<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html> 