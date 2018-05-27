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
</head> 
<body>
<div class="w3-white">
	<div class="container">
		<c:choose>
			<c:when test="${flag}">
				<h2><span class="glyphicon glyphicon-pencil"></span></h2>
				<FORM 	name='frm'
						method='POST'
						action='updateProc'
						enctype="multipart/form-data">
						<input type="hidden" name="gno" value="${dto.gno }">
						<input type="hidden" name="oldfile" value="${oldfile }">
						<input type="hidden" name="col" value="${param.col }">
						<input type="hidden" name="word" value="${param.word }">
						<input type="hidden" name="nowPage" value="${param.nowPage }">
				  <TABLE class="table table-bordered">
				  	<tr>
				  		<th>예전 사진</th>
				  		<td><img src="${root}/storage_guest/${oldfile }" width="50%" height="50%"><br>
				    		  원본파일명:${oldfile }
				      </td>
				  	
				  	</tr>
				    <TR>
				      <tr>
				    	<th>변경할 사진</th>
				    	<td><input type="file" name="fnameMF" accept=".jpg,.png,.gif">
				    </tr>
				    <tr>
				    	<th>작성자</th>
				    	<td><input type="text" name="gname" value="${dto.gname }"></td>
				    </tr>
				    <tr>
				    	<th>내용</th>
				    	<td><textarea rows="5" cols="30" name="content">${dto.content }</textarea></td>
				    </tr>
				  </TABLE>
				  <p class="w3-center">
				    <input type='submit' class='w3-button w3-red' value='수정'>
				    <input type="button" class='w3-button w3-white w3-border' value="취소" onclick="history.back()">
				    </p>
				</FORM>
			</c:when>
			<c:otherwise>
				<div align="center">
			 		<h2>본인이 작성한 글이 아닙니다.</h2>
		 			<input type='button' class='w3-button w3-red' value='확인' onclick='history.back()'>
				</div>
			</c:otherwise>
	 	</c:choose>
	</div>
</div>
</body>
</html> 