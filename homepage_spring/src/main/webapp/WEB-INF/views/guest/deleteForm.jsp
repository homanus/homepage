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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
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

function dehet(){
opener.location.reload();
self.close();
}

</script>
</head> 
<body>
<div class="w3-white">
	<div class="container">
		<div class="w3-center">
			<c:choose>
				<c:when test="${flag == true}">
					<FORM name='frm' method='POST' action='deleteProc'>
						<input type="hidden" name="gno" value="${param.gno }">
						<input type="hidden" name="col" value="${param.col }">
						<input type="hidden" name="word" value="${param.word }">
						<input type="hidden" name="nowPage" value="${param.nowPage }">
					<h2>삭제시 복구 불가<br>
					정말로 삭제하시겠습니까?<br>
					</h2>
					    <input type='submit' class='w3-button w3-red' value='삭제'>
					    <input type='button' class='w3-button w3-white w3-border' value='취소' onclick="self.close()">
					</FORM>
				</c:when>
				<c:otherwise>
			 		<h2>본인이 작성한 글이 아닙니다.</h2>
			 		<br><input type='button' class="w3-button w3-red" value='확인' onclick='dehet()'>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
</body>
</html> 