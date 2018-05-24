<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1">

<title></title>
<link href="${root }/chat_util/css/member.css" rel="Stylesheet" type="text/css">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<!-- 리캡챠 -->
<script src='https://www.google.com/recaptcha/api.js'></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
 
                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;
 
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }
 
                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;
 
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script> 

<script type="text/javascript">
function idCheck(id){
		var url="id_form";
		
		var wr = window.open(url,"아이디 중복확인","width=500,height=500");
		wr.moveTo(((window.screen.width-500)/2),((window.screen.height-500)/2));
	
	
}

function emailCheck(){
	var url="email_form";
	
	var wr = window.open(url,"이메일 검증","width=500, height=500");
	wr.moveTo(((window.screen.width-500)/2),((window.screen.height-500)/2));
	
}

function inputCheck(f){
	
	if(f.id.value==""){
		alert("아이디를 입력해주세요");
		f.id.focus();
		
		return false;
	}
	
	if(f.passwd.value==""){
		alert("비밀번호를 입력해주세요");
		f.passwd.focus();
		
		return false;
	}
	
	if(f.repasswd.value==""){
		alert("비밀번호 확인을 입력해주세요");
		f.repasswd.focus();
		
		return false;
	}
	
	if(f.passwd.value!=f.repasswd.value){
		alert("비밀번호가 일치하지 않습니다");
		f.repasswd.focus();
		
		return false;
	}
	if(f.mname.value==""){
		alert("이름을 입력해주세요");
		f.mname.focus();
		
		return false;
	}
	if(f.email.value==""){
		alert("이메일을 입력해주세요.");
		emailCheck();
		
		return false;
	}

	if (typeof(grecaptcha) != 'undefined') {
	       if (grecaptcha.getResponse() == "") {
	           alert("스팸방지코드를 확인해 주세요.");
	           return false;
	       }
	    }else{
	    	return false;
	    }
}

$(function(){
	$("#Detail_show").click(function(){
		$("#Detail").css("display","");
		$("#Detail_show").css("display","none");
		$("#Detail_hide").css("display","");
	});
	$("#Detail_hide").click(function(){
		$("#Detail").css("display","none");
		$("#Detail_hide").css("display","none");
		$("#Detail_show").css("display","");
	})
});

</script>
</head> 
<body>
<div class="container">
 <br>
	<FORM 	name='frm'
			method='POST'
			action='createProc'
			enctype="multipart/form-data"
			onsubmit="return inputCheck(this)"
			class="signUp1">
			
			<h1 class="signUpTitle">Sign up</h1>
	    	사진은 JPG, PNG, GIF 파일만 올려 주세요(본인사진)
			<input class="signUpInput" type='file' name='filenameMF' accept=".jpg,.png,.gif">
			<button class="signUpButton" style="font-size: 15px" type="button" onclick="idCheck(document.frm.id.value)">중복확인</button>
			<input class="signUpInput" type='text' name="id" size='20' placeholder="중복확인 버튼을 눌러주세요" value="" readonly>
			<input class="signUpInput" type='password' name='passwd' size='20' placeholder="비밀번호(*필수)">
			<input class="signUpInput" type='password' name='repasswd' size='20' placeholder="비밀번호 확인(*필수)">
			<input class="signUpInput" type='text' name='mname' size='20' placeholder="이름(*필수)">
			<button class="signUpButton" style="font-size: 15px" type="button" onclick="emailCheck()">이메일 중복확인</button>
			<input class="signUpInput" type='email' name='email' size="20" placeholder="중복확인 버튼을 눌러주세요" readonly>
					<select name="job" class="signUpInput">
			    		<option value="0" selected>선택하세요</option>
			    		<option value="A01">회사원</option>
			    		<option value="A02">전산관련직</option>
			    		<option value="A03">연구전문직</option>
			    		<option value="A04">학생</option>
			    		<option value="A05">일반자영업</option>
			    		<option value="A06">공무원</option>
			    		<option value="A07">의료인</option>
			    		<option value="A08">법조인</option>
			    		<option value="A09">종교/언론/예술인</option>
			    		<option value="A10">기타</option>
			    	</select>
			<button class="signUpButton_rblack" id="Detail_show" type="button">상세정보 입력</button>
			<button class="signUpButton_rblack" id="Detail_hide" type="button" style="display: none">상세정보 접기</button>
			<br>
		<div id="Detail" style="display: none">
			<input class="signUpInput" type='text' name='tel' placeholder="전화번호">
			<button class="signUpButton" style="font-size: 15px" style="font-size: 18px" type="button" onclick="sample6_execDaumPostcode()">주소검색</button>
			<input class="signUpInput" type='text' name='zipcode' size="7" id="sample6_postcode" placeholder="주소검색 버튼을 누르세요" readonly="readonly">
			<input class="signUpInput" type='text' name='address1' size="40" id="sample6_address" placeholder="주소">
	    	<input class="signUpInput" type='text' name='address2' size="40" id="sample6_address2" placeholder="상세주소">
		</div>
	    	<div id="grecaptcha" class="g-recaptcha" data-sitekey="6LdqpVgUAAAAAD4GL5mVsRPaFNFtrKyq42a1gD-X"></div>
			 <button class="signUpButton">회원가입</button>
	</FORM>
</div>
</body>
</html> 