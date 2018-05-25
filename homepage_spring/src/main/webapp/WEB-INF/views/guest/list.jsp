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
.search{
	width:80%;
	margin:2px auto;
	text-align: center;
}
h1,h2,h3,h4,h5,h6 {font-family: "Oswald"}
body {font-family: "Open Sans"}
</style> 
<script type="text/javascript">
function create(){
	var url = "create";
	location.href=url;
	
}
function gupdate(gno){
	var url = "update";
	url+="?gno="+gno;
	url+="&col=${col}";
	url+="&word=${word}";
	url+="&nowPage=${nowPage}";
	location.href=url;
	
}
function gdelete(gno){
	var url = "delete";
	url+="?gno="+gno;
	url+="&col=${col}";
	url+="&word=${word}";
	url+="&nowPage=${nowPage}";
	
	var wr = window.open(url,"삭제 팝업창","width=500,height=500");
	wr.moveTo(((window.screen.width-500)/2),((window.screen.height-500)/2));
	
}

</script>
</head> 
<body>
<script type="text/javascript">
function agreement(){
	var url = "${root}/member/agreement";
	location.href=url;
}
function login(){
	var url="../member/loginForm";
	location.href=url;
}
</script>
<div class="w3-white">
		<c:choose>
			<c:when test="${empty sessionScope.id}">
				<div class="w3-center">
					비로그인 상태입니다.<br>
					회원 커뮤니티는
					<br>로그인 또는 회원가입 후 이용하실 수 있습니다.<br>
					<input type='button' class='w3-button w3-white w3-border' value='로그인' onclick='login()'>
					<input type='button' class='w3-button w3-red' value='회원가입' onclick='agreement()'>
				</div>
			</c:when>
			<c:otherwise>
				<div class="container">
					<h2><span class="glyphicon glyphicon-pencil"></span></h2>
					<FORM 	name='frm'
							method='POST'
							action='create'
							enctype="multipart/form-data">
							<input type="hidden" name="id" value="${sessionScope.id }">
							<input type="hidden" name="passwd" value="${dto.passwd }">
					  <TABLE class="table table-bordered">
					    <TR>
					      <tr>
					    	<th>사진</th>
					    	<td><input type='file' name='fnameMF' accept=".jpg,.png,.gif">
					    </tr>
					    <tr>
					    	<th>작성자</th>
					    	<td><input type="text" name="gname" value="" required="required"></td>
					    </tr>
					    <tr>
					    	<th>내용</th>
					    	<td><textarea rows="5" cols="30" name="content" required="required"></textarea></td>
					    </tr>
					  </TABLE>
					  <p class="w3-center">
					    <input type='submit' class='w3-button w3-white w3-border' value='글 작성'>
					    <input type="reset" class='w3-button w3-red' value="리셋">
					  </p>
					</FORM>
				
				<br><br>
				<br><br>
						<h2><span class="glyphicon glyphicon-comment"></span>회원 커뮤니티</h2>
						
					<c:forEach var="dto" items="${list}">
					  <TABLE class="table table-hover">
					    <TR>
					      <td rowspan="5" width="30%"><img src="${root}/storage_guest/${dto.fname}" width="300px" height="200px"></td>
					      <th width="20%">이름</th>
					      <td width="50%">${dto.gname }</td>
					    </TR>
					    <tr>
					    	<th>내용</th>
					    	<td>${dto.content }</td>
					    </tr>
					    <tr>
					    	<th>작성시간</th>
					    	<td>${dto.gdate }</td>
					    </tr>
					    <tr>
					   		<th>수정/삭제</th>
					   		<td><a href="javascript:gupdate('${dto.gno }')">수정</a>/
					   		<a href="javascript:gdelete('${dto.gno }')">삭제</a>
					   		</td> 
					    </tr>
					  </TABLE>
				  	</c:forEach>
				 </div>
	 
			  <div class="search">
				<form method="post" action='list'>
					<select name="col">
						<option value="title"
						<c:if test="${col=='title'}">
						selected
						</c:if>	
						>제목</option>
						
						<option value="mname"
						<c:if test="${col=='mname'}">
						selected
						</c:if>
						>이름</option>
						
						<option value="total">전체</option>
					</select>
				<input type="search" name="word" value="${word}" required>
				<button class='w3-button w3-white w3-border'>검색</button>
				</form>
			</div>
	 		 ${paging}
		</c:otherwise>
	</c:choose>
</div>
</body>
</html> 