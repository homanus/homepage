<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%

%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
function idCheck(id){
	if(id==""){
		alert("아이디를 입력해주세요");
		document.frm.id.focus();
	}else{
		var url="id_proc.jsp";
		url+="?id="+id;
		
		var wr = window.open(url,"새창이름","width=500,height=500");
		wr.moveTo(((window.screen.width-500)/2),((window.screen.height-500)/2));
	}
	
}
/* function emailCheck(email){
	if(email==""){
		alert("이메일을 입력해주세요");
		document.frm.email.focus();
	}else{
		var url="email_proc.jsp";
		url+="?email="+email;
		
		var wr = window.open(url,"새창이름","width=500, height=500");
		wr.moveTo(((window.screen.width-500)/2),((window.screen.height-500)/2));
	}
} */
function emailCheck(email){
	var url="email_form.jsp";
	
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
	
/* 	if(f.email.value==""){
		alert("이메일을 입력해주세요");
		f.email.focus();
		
		return false;
	} */
}


</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top2.jsp" flush="false"/>
<!-- *********************************************** -->
       <div class="w3-white">
        <div class="w3-container w3-padding w3-black w3-center">
        회원가입<br>*표시는 반드시 작성하셔야 합니다.</DIV>
        
   
        
 <br>
<FORM 	name='frm'
		method='POST'
		action='prcreateProc.jsp'
		enctype="multipart/form-data"
		onsubmit="return inputCheck(this)">
		
  <TABLE>
    <tr>
    	<th><div style="margin:10px">회원사진<br></div></th>
    	<td><input type='file' name='fname' accept=".jpg,.png,.gif">
    	사진은 JPG, PNG, GIF 파일만 올려 주세요(본인사진)<br></td>
    </tr>
    <TR>
    <th><div style="margin:10px">*아이디<br></div></th>
      <TD>
      <input type='text' name="id" size='20' placeholder="아이디(*필수)" value="">
      <button style="font-size: 15px" type="button" class="w3-button w3-white w3-border" onclick="idCheck(document.frm.id.value)">중복 확인</button>
      </TD>
    </TR>
    <tr>
    <th><div style="margin:10px">*비밀번호<br></div></th>
    	<td><input type='password' name='passwd' size='20' placeholder="비밀번호(*필수)"><br></td>
    	
    </tr>
    <tr>
    <th><div style="margin:10px">*비밀번호 확인<br></div></th>
    	<td><input type='password' name='repasswd' size='20' placeholder="비밀번호 확인(*필수)"><br></td>
    </tr>
    <tr>
    <th><div style="margin:10px">*이름<br></div></th>
    	<td><input type='text' name='mname' size='20' placeholder="이름(*필수)"><br></td>
    </tr>
    <tr>
    <th><div style="margin:10px">전화번호<br></div></th>
    	<td><input type='text' name='tel' placeholder="전화번호"><br></td>
    </tr>
    <tr>
    <th><div style="margin:10px">*이메일<br></div></th>
    	<td>
    	<input type='email' name='email' size="20" placeholder="이메일(*필수)" readonly>
    	<button style="font-size: 15px" type="button" class="w3-button w3-white w3-border" onclick="emailCheck(document.frm.email.value)">이메일 중복확인</button>
    	</td>

    	
    </tr>
    <tr>
    <th><div style="margin:10px">우편번호</div></th>
    	<td><input type='text' name='zipcode' size="7" id="sample6_postcode" placeholder="우편번호">
    	<button style="font-size: 15px" style="font-size: 18px" type="button" class="w3-button w3-white w3-border" onclick="sample6_execDaumPostcode()">주소검색</button>
    	</td>
    </tr>
    <tr>
    <th><div style="margin:10px">주소</div></th>
    	<td>
    	<input type='text' name='address1' size="40" id="sample6_address" placeholder="주소">
    	<br>
    	<input type='text' name='address2' size="40" id="sample6_address2" placeholder="상세주소"></td>
    </tr>
    <tr>
    <th><div style="margin:10px">직업</div></th>
    	<td>
    	<select name="job">
    		<option value="0">선택하세요</option>
    		<option value="A01">회사원</option>
    		<option value="A02" selected>전산관련직</option>
    		<option value="A03">연구전문직</option>
    		<option value="A04">학생</option>
    		<option value="A05">일반자영업</option>
    		<option value="A06">공무원</option>
    		<option value="A07">의료인</option>
    		<option value="A08">법조인</option>
    		<option value="A09">종교/언론/예술인</option>
    		<option value="A10">기타</option>
    	</select>
    	</td>
    	
    </tr>
   
  </TABLE>
  <p class="w3-center">
  <button class="w3-button w3-red"><b>회원가입  </b><span class="w3-tag w3-red"></span></button></p>
    <!-- <input type='submit' value='회원가입'> -->
    <!-- <input type="reset" value="다시작성"> -->
    
</FORM>
 </div>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 