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
function blist(){
	var url ="list";
	url+="?col=${param.col}";
	url+="&word=${param.word}";
	url+="&nowPage=${param.nowPage}";
	location.href=url;
}
</script>
</head> 
<body>
<div class="w3-white">
	<div class="container">
		<div class="w3-center">
		  <h2>※삭제시 복구하실 수 없습니다.</h2>
		  <c:choose>
		  	<c:when test="${flag == true}">
		  		답변글이 있으므로 삭제하실 수 없습니다.
		  		<br>
				<button class="w3-button w3-red" type="button" onclick="history.back()">뒤로가기</button>
		  	</c:when>
		  	<c:otherwise>
					<FORM name='frm' method='POST' action='deleteProc'>
						<input type="hidden" name="bbsno" value="${param.bbsno}"/>
						<input type="hidden" name="col" value="${param.col}"/>
						<input type="hidden" name="word" value="${param.word}"/>
						<input type="hidden" name="nowPage" value="${param.nowPage}">
						<input type="hidden" name="oldfile" value="${param.oldfile}"/>
						  <TABLE>
						    <TR>
						      <TH>비밀번호:</TH>
						      <TD><input type="password" name="passwd" placeholder="비밀번호 입력" required></TD>
						    </TR>
						  </TABLE>
					  	<br>
					    <input type='submit' class="w3-button w3-black" value='삭제'>
					    <input type='button' class="w3-button w3-white w3-border" value='목록' onclick="blist()">
					</FORM>
				</c:otherwise>
		  	</c:choose>
		 </div>
	 </div>
</div>
</body>
</html> 