<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%
		boolean flag = dao.duplicateEmail(dto.getEmail());
		
		String code = dao.emailcode();
		
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">

</style>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<script type="text/javascript">
/* $(function(){
	if(flag==false){
	$("#btnclose").html("<button class='w3-button w3-black' onclick='emailCheck()'>이메일 검증</button>")
	}
}) */


function use(){
	opener.frm.email.value="<%=dto.getEmail()%>";
	self.close();
}
function emailCheck(){
	//여기서 proc내에서 자체적으로 비동기통신 요청후 코드값 발송,
	//그 값을 입력시 받아와서 메소드 호출
	//flag 값 받아와서 트루면 사용, false면 다시시도
	
	var param = $("#checkEmail_form").serialize();
	
	//alert(param);
	
	$.post(
		"email_proc_send.jsp",
		param,
		function(data, textStatus){
			//alert(textStatus);
			var result = eval("("+data+")");
			
			sendMail(result);
		}
	)
// 	var url="email_check_form.jsp";
<%-- 	url+="?email=<%=dto.getEmail()%>"; --%>
	
// 	var ww = window.open(url,"이메일 검증","width=500, height=500");
// 	ww.moveTo(((window.screen.width-500)/2),((window.screen.height-500)/2));
	
}

function sendMail(result){
	var url = "sendMail.jsp";
	url+="?from="+result.from;
	url+="&to="+result.to;
	url+="&subject="+result.subject;
	url+="&content="+result.content;
	
	var ww = window.open(url,"코드발송","width=500, height=500");
	ww.moveTo(((window.screen.width-500)/2),((window.screen.height-500)/2));
	
	display_choose();
}

function display_choose(){
	
			$("#pass").css("display","none");
			$("#se").css("display","");
}

function check_m(){
	var emailcode = $("#ch_mail_code").val();
	var checkcode = <%=code%>;
	
	if(checkcode==emailcode){
	$("#se").css("display","none");
	$("#check_success").css("display","");
	}else{
		alert("인증코드를 잘못 입력하셨습니다. \n 확인후 다시 입력해주세요.");
		return false;
	}
}

</script>
</head>
<!-- *********************************************** -->
<body>
<!-- *********************************************** -->
 <div class="w3-white">
<div class="w3-center">
<h2><span class="glyphicon glyphicon-th-list"></span>이메일 중복 확인</h2>

입력된 Email:<%=dto.getEmail() %><br><br>
<%
	if(flag){
		out.print("중복되어서 사용할 수 없습니다.<br><br>");
%>
<p class="w3-center">
    <button class="w3-button w3-red" onclick="location.href='email_form.jsp'">다시시도</button>
    </p>
<%
	}
	else{%>
<div id="pass">
	<%
		out.print("중복아님, 사용 가능합니다.<br><br>");

		%>
		<button id='email_btn' class="w3-button w3-white w3-border" onclick='emailCheck()'>이메일 인증코드 발송</button>
		<%
	}

%>
  <button id="btnclose" type="button" class="w3-button w3-black" onclick="window.close()">닫기</button>
 
</div>
 
 
 
 

 <div id="se"  style="display: none;">
발송된 코드를 입력해주세요.
<form id="checkEmail_form" action="sendMail.jsp" method="post">
<input type="hidden" name="from" value="homanus@naver.com">
<input type="hidden" name="to" value="<%=dto.getEmail()%>">
<input type="hidden" name="subject" value="메일 검증 코드">
<input type="hidden" id="mail_code" name="content" value="코드 인증창에 아래의 코드를 입력해주세요.<br><%=code%>">
 
<input type="text" id="ch_mail_code">
<button type="button" id="check_try" onclick="check_m()" class="w3-button w3-red">이메일 인증</button>
</form>
</div>


<div id="check_success" style="display: none;">
이메일 인증이 완료되었습니다.<br>
<button type="button" class="w3-button w3-red" onclick="use()">사용</button>
</div>



 </div>
 </div>
</body>
</html> 