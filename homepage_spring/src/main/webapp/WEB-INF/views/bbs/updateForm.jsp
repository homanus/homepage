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
function incheck(){
	
	var f = document.frm;
		
	if(f.wname.value==""){
		alert("이름을 입력해주세요.")
		f.wname.focus();
		return;
		}
	
	if(f.title.value==""){
		alert("제목을 입력해주세요.")
		f.title.focus();
		
		return;
		}
	if(f.passwd.value==""){
		alert("비밀번호를 입력해주세요.")
		f.passwd.focus();
		
		return;
		}
	if (CKEDITOR.instances['content'].getData() == '') {
	      window.alert('내용을 입력해 주세요.');
	      CKEDITOR.instances['content'].focus();
	      return;
	    }
	
	f.submit();
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
			<h2><span class="glyphicon glyphicon-pencil"></span>글 수정</h2>
			<FORM name='frm' 
				  method='POST'
				  action='./updateProc'
				  enctype="multipart/form-data"
				  >
				  
				<input type="hidden" name="bbsno" value="${dto.bbsno}">
				<input type="hidden" name="col" value='${param.col}'>
				<input type="hidden" name="word" value='${param.word}'>
				<input type="hidden" name="nowPage" value='${param.nowPage}'>
				<input type="hidden" name="oldfile" value='${dto.filename}'>
				
				  <TABLE class="table table-bordered">
				    <TR>
				      <TH>작성자</TH>
				      <TD><input type="text" name="wname" value="${dto.wname }" style="width: 100%;"></TD>
				    </TR>
				    <tr>
				    	<th>제목</th>
				    	<td><input type="text" name="title" value="${dto.title }" style="width: 100%;"></td>
				    </tr>
				    <tr>
				    	<th>내용</th>
				    	<td><textarea rows="5" cols="30" name="content">${dto.content }</textarea></td>
				    </tr>
				     <tr>
				    	<th>비밀번호</th>
				    	<td><input type="password" name="passwd"></td>
				    </tr>
				    <TR>
				      <TH>원본파일</TH>
				      <TD>
				      원본파일명:${dto.filename}
				      </TD>
				    </TR>
				     <tr>
				    	<th>변경파일</th>
				    	<td>
				    	<input type="file" name="filenameMF">
				    	</td>
				    </tr>
				  </TABLE>
				  <p class="w3-center">
				    <input type='button' class="w3-button w3-red" value='수정' onclick="incheck()">
				    <input type='button' class="w3-button w3-white w3-border" value='취소' onclick="history.back()">
				    </p>
			</FORM>
		</div>
	</div>
</body>
</html> 