<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		
		String grade=null;
		
		Map map = new HashMap();
		map.put("id", id);
		map.put("passwd", passwd);
		
		boolean flag = dao.loginCheck(map);
		
		
		if(flag){
			grade = dao.getGrade(id);
			session.setAttribute("id", id);
			session.setAttribute("grade", grade);
			
			Cookie cookie = null; 
		       
		    String c_id = request.getParameter("c_id"); // Y, 아이디 저장 여부 
		       
		    if (c_id != null){  // 처음에는 값이 없음으로 null 체크로 처리
		      cookie = new Cookie("c_id", "Y");    // 아이디 저장 여부 쿠키 
		      cookie.setMaxAge(120);               // 2 분 유지 
		      response.addCookie(cookie);          // 쿠키 기록 
		   
		      cookie = new Cookie("c_id_val", id); // 아이디 값 저장 쿠키  
		      cookie.setMaxAge(120);               // 2 분 유지 
		      response.addCookie(cookie);          // 쿠키 기록  
		         
		    }else{ 
		      cookie = new Cookie("c_id", "");     // 쿠키 삭제 
		      cookie.setMaxAge(0); 
		      response.addCookie(cookie); 
		         
		      cookie = new Cookie("c_id_val", ""); // 쿠키 삭제 
		      cookie.setMaxAge(0); 
		      response.addCookie(cookie); 
		}
		}
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
.r{
	text-align: center;
}
</style> 
<%-- <link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> --%>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top2.jsp" flush="false"/>
<!-- *********************************************** -->
 <div class="w3-white r">
 <div class="w3-container w3-white w3-margin w3-padding-large">
        <div class="w3-center">
          
 <%if(flag==false){
	 out.print("<h5>아이디/패스워드를 잘못 입력하셨거나<br>");
	 out.print("아이디가 존재하지 않습니다.</h5>");%>
	 <button type='button' class="w3-button w3-red" onclick='history.back()'>다시시도</button>
	   <button type="button" class="w3-button w3-black" onclick="location.href='<%=root%>/member/agreement.jsp'">회원가입</button>
	 <br>
	 <%
 }else{
	 out.print("<h3>로그인 되었습니다.</h3>");
	 %>
	 <br>
  <br>
  <button class="w3-button w3-white w3-border" onclick="location.href='<%=root%>/index.jsp'">메인으로</button>
  <button type="button" class="w3-button w3-black" onclick="location.href='<%=root%>/member/logout.jsp'">로그아웃</button>
 <!--<input type='button' value='홈으로' onclick="location.href='../index.jsp'"> -->
 
 <%}
 %>
        </div>
 </div>
 </div>
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 