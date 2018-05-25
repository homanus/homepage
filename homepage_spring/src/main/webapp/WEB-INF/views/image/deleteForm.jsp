<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 

</style> 
<script type="text/javascript">
function ilist(){
	var url = "list";
	url+="&nowPage=${param.nowPage}";
	url+="&col=${param.col}";
	url+="&word=${param.word}";
	location.href=url;
}
</script>
</head> 
<body>
<div class="w3-white">
	<div class="container">
		<div class="w3-center">
			<FORM name='frm' method='POST' action='deleteProc'>
					<input type="hidden" name="ino" value="${param.ino }"/>
					<input type="hidden" name="fname" value="${param.fname }">
					<input type="hidden" name="nowPage" value="${param.nowPage }">
					<input type="hidden" name="col" value="${param.col }">
					<input type="hidden" name="word" value="${param.word }">
				 <h2>정말로 삭제하시겠습니까?<br>
				  삭제시 복구하실 수 없습니다.<br></h2>
				 <div>
					  비밀번호:<input type="password" name="passwd">
					  <input type='submit' class="w3-button w3-red" value='삭제'>
					  <input type='button' class="w3-button w3-white w3-border" value='취소' onclick="history.back()">
				 </div>
			</FORM>
		</div>
	</div>
</div>
</body>
</html> 