<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Oswald">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open Sans">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="${root }/chat_util/css/member.css" rel="Stylesheet" type="text/css">
<title></title> 
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<script type="text/javascript">
function use(){
	var id = $("#id_form_data").serialize();
	var real_id = id.split('=');
	opener.frm.id.value=real_id[1];
	
	self.close();
}

function id_dup_check(){
	if(document.frm.id.value==""){
		alert("아이디를 입력해주세요");
		document.frm.id.focus();
		return false;
	}
	
	var param = $("#id_form_data").serialize();
	
	$.post(
		"id_proc_check",
		param,
		function(data, textStatus){
			
			var result = data;
			
			duplCheck(result);
		}
	)
}

function duplCheck(result){
	
	if(result.flag == true){
		alert("중복된 아이디입니다.");
	}else{
		$("#id_form").css("display","none");
		$("#id_proc").css("display","");
		
		var id = $("#id_form_data").serialize();
		var real_id = id.split('=');
		var real_id_get = real_id[1];
		alert("사용 가능합니다");
		$("#select_id").text("입력한 아이디: "+real_id_get);
	}
}
$(function(){
	 $('#id').keyup(
			function(event){
		             if (!(event.keyCode >=37 && event.keyCode<=40)) {
		                 var inputVal = $(this).val();
		                 $(this).val($(this).val().replace(/[^_a-z0-9]/gi,''));
						 //_(underscore), 영어, 숫자만 가능
		                    }
		                });
});
</script>
</head>
<body>
<div class="container">
<FORM id="id_form_data" class="signUp" name='frm' method='POST'>
<h1 class="signUpTitle">아이디 중복 확인</h1>
<div align="center" id="id_form">
      <label>10자 이내의 알파벳, 언더스코어(_), 숫자만 입력 가능합니다.<br>
      <input type="text" name="id" id="id"
      class="signUpInput" size="20" data-rule-required="true" maxlength="10"
      placeholder="사용하실 아이디를 입력하세요.">
      </label>
<br>
    <button class="signUpButton" type="button" onclick="id_dup_check()">중복확인</button>
<!--   <button class="signUpButton" type="button" onclick="window.close()">취소</button> -->
</div>

<div id="id_proc" align="center" style="display: none">
 		<h4 id="select_id"></h4>
 		<br>
		<input class="signUpButton" type='button' value='사용' onclick='use()'>
<!--     	<input class="signUpButton" type='button' value='다시시도' onclick="history.back()"> -->
</div>
 
</FORM>
</div>
</body>
</html> 