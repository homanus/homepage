<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
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
  border-spacing:0px;
  border-style:none;
  padding:0px;
}
h1,h2,h3,h4,h5,h6 {font-family: "Oswald"}

body {font-family: "Open Sans"}
</style> 
<script type="text/javascript">
function incheck(f){
	if(f.mname.value==""){
		alert("이름을 입력해주세요.");
		f.mname.focus();
		return false;
	}
	if(f.title.value==""){
		alert("제목을 입력해주세요.");
		f.title.focus();
		return false;
	}
	if(f.passwd.value==""){
		alert("비밀번호를 입력해주세요.");
		f.passwd.focus();
		return false;
	}
	if(f.fname.value==false){
		alert("사진을 올려주세요.");
		return false;
	}
	 if (CKEDITOR.instances['content'].getData() == '') {
	      window.alert('내용을 입력해 주세요.');
	      CKEDITOR.instances['content'].focus();
	      return false;
	    }
}
</script>
<script type="text/javascript" src="${root}/ckeditor/ckeditor.js"></script>
<script type="text/JavaScript">
   window.onload=function(){
     CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  };
</script>
</head> 
<body>
<div class="w3-white">
	<div class="container">
		<h2><span class="glyphicon glyphicon-pencil">
		</span>수정</h2>
	 
		<FORM	 name='frm' 
				 method='POST' 
				 action='updateProc'
				 enctype="multipart/form-data"
				 onsubmit="return incheck(this)">
				 <input type="hidden" name="ino" value="${dto.ino }">
				 <input type="hidden" name="oldfile" value="${oldfile }">
				 <input type="hidden" name="nowPage" value="${param.nowPage }">
				 <input type="hidden" name="col" value="${param.col }">
				 <input type="hidden" name="word" value="${param.word }">
				  
				  <TABLE class="table table-bordered">
					  <tr>
					  	<th>원본 파일</th>
					  	<td><img src="${root}/storage_image/${dto.fname}" width="60%"></td>
					  </tr>
					    <TR>
					      <TH>수정 파일</TH>
					      <TD><input type="file" name="fnameMF" accept=".jpg,.png,.gif" size="15" required="required"></TD>
					    </TR>
					    <TR>
					      <TH>이름</TH>
					      <TD><input type="text" name="mname" value="${dto.mname }" style="width: 100%;"></TD>
					    </TR>
					    <TR>
					      <TH>제목</TH>
					      <TD><input type="text" name="title" value="${dto.title }" style="width: 100%;"></TD>
					    </TR>
					    <TR>
					      <TH>내용</TH>
					      <TD><textarea name="content" rows="7">${dto.content }</textarea></TD>
					    </TR>
					    <tr>
					    	<th>비밀 번호</th>
					    	<td><input type="password" name="passwd" size="15"></td>
					    </tr>
				  </TABLE>
		  	<p class="w3-center">
		    	<input type='submit' class="w3-button w3-red" value='수정'>
		   		<input type='button' class="w3-button w3-white w3-border" value='뒤로가기' onclick="history.back()">
		    </p>
		</FORM>
	</div>
</div>
</body>
</html> 