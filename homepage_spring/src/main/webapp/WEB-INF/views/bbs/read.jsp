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
<title></title> 
<style type="text/css"> 
.bottom{
  margin: 20px auto;
  text-align: center;
  width: 100%;
  padding: 10px;  /* 위 오른쪽 아래 왼쪽 */
}
h1,h2,h3,h4,h5,h6 {font-family: "Oswald"}
body {font-family: "Open Sans"}

</style> 
<script type="text/javascript">
function blist(){
	var url = "list";
	url+="?col=${param.col}";
	url+="&word=${param.word}";
	url+="&nowPage=${param.nowPage}";
	location.href=url;
}
function bupdate(){
	var url = "update";
	url+="?bbsno=${dto.bbsno}";
	url+="&col=${param.col}";
	url+="&word=${param.word}";
	url+="&nowPage=${param.nowPage}";
	location.href=url;
}
function bdelete(){
	var url="delete";
	url+="?bbsno=${dto.bbsno}";
	url+="&oldfile=${dto.filename}";
	url+="&col=${param.col}";
	url+="&word=${param.word}";
	url+="&nowPage=${param.nowPage}";
	location.href=url;
}
function reply(bbsno){
	var url="reply";
	url+="?bbsno="+bbsno;
	url+="&col=${param.col}";
	url+="&word=${param.word}";
	url+="&nowPage=${param.nowPage}";
	location.href=url;
}
function fileDown(filename){
	var url = "${root}/download";
	url+="?filename="+filename;
	url+="&dir=/storage_bbs";
	
	location.href = url;
}

function input(f){
	if('${sessionScope.id}'==""){
		if(confirm("로그인후 댓글을 다실 수 있습니다. \n 로그인 하시겠습니까?")){
			var url = "../member/loginForm";
			url += "?bbsno=${dto.bbsno}";
			url += "&nowPage=${param.nowPage}";
			url += "&col=${param.col}";
			url += "&word=${param.word}";
			url += "&nPage=${nPage}";
			url += "&rflag=../bbs/read";
			location.href=url;
			
			return false;
		
		}else{
				return false;
		}
	
	}else if(f.content.value==false){
		alert("댓글내용을 입력하세요.");
		f.content.focus();
		
		return false;
	}

}

function rupdate(rnum,rcontent){
	var f = document.rform;
	
	f.content.value = rcontent;
	f.rnum.value = rnum;
	f.rsubmit.value="수정";
	f.action="./rupdate";
}

function rdelete(rnum){
	if(confirm("정말 삭제 하시겠습니까?")){
		var url="./rdelete";
		url += "?rnum="+rnum;
		url += "&bbsno=${dto.bbsno}";
		url += "&nowPage=${param.nowPage}";
		url += "&nPage=${nPage}";
		url += "&col=${param.col}";
		url += "&word=${param.word}";
		
		location.href=url;
		
	}
}
</script>
</head> 
<body>
<div class="w3-white">
	<div class="container">
		<h2><span class="glyphicon glyphicon-th-list"></span>게시글 내용</h2>
		
		  <TABLE class="table table-hover">
		    <TR>
		      <TH>번호</TH>
		      <TD>${dto.bbsno }</TD>
		    </TR>
		    <TR>
		      <TH>작성자</TH>
		      <TD>${dto.wname }</TD>
		    </TR>
		    <TR>
		      <TH>제목</TH>
		      <TD>${dto.title }</TD>
		    </TR>
		    <TR>
		      <TH>내용</TH>
		      <TD>${dto.content }</TD>
		    </TR>
		    <TR>
		      <TH>조회수</TH>
		      <TD>${dto.viewcnt }</TD>
		    </TR>
		    <TR>
		      <TH>등록날짜</TH>
		      <TD>${dto.wdate }</TD>
		    </TR>
		  		<tr>
		  		<th>파일명</th>
		   		<td>
		   			<c:choose>
		   				<c:when test="${empty dto.filename}">
		   					파일없음
		   				</c:when>
		   				<c:otherwise>
				 			<a href="javascript:fileDown('${dto.filename }')"${dto.filename }>${dto.filename }(${dto.filesize })</a>
		   				</c:otherwise>
		   			</c:choose>
		    	</td>
		    </tr>
		  </TABLE>
		  
		  	<button type="button" class="w3-button w3-white w3-border" onclick="reply('${dto.bbsno}')">답변</button>
		    <input type='button' class="w3-button w3-white w3-border" value='목록' onclick="blist()">
		    <input type='button' class="w3-button w3-white w3-border" value='수정' onclick="bupdate()">
		    <input type='button' class="w3-button w3-black" value='삭제' onclick="bdelete()">
		    <hr>
		    
		    <c:forEach var="rdto" items="${rlist }">
		    	  <div class="rlist">
					  ${rdto.id}<br>
					  <p>${rdto.content}</p>
					  ${rdto.regdate}
					  <c:if test="${sessionScope.id==rdto.id}">
						  <span style="float:right">
						  <a href="javascript:rupdate('${rdto.rnum }','${rdto.content }')">수정</a>|
						  <a href="javascript:rdelete('${rdto.rnum }')">삭제</a>
						  </span>
					  </c:if>
				  </div>
		    </c:forEach>
		    
		    ${paging }
		    
		    <div class="rcreate">
			  	<form name="rform"
			  	action="./rcreate"
			  	method="post"
			  	onsubmit="return input(this)">
				  	<textarea rows="3" cols="28" name="content"></textarea>
				  	<input type="submit" name="rsubmit" value="등록"></input>
					
					<input type="hidden" name="nowPage" value="${param.nowPage}">
					<input type="hidden" name="col" value="${param.col}">
					<input type="hidden" name="id" value="${sessionScope.id}">
					<input type="hidden" name="word" value="${param.word}">
					<input type="hidden" name="bbsno" value="${dto.bbsno}">
					<input type="hidden" name="rnum" value="${0}">
					<input type="hidden" name="nPage" value="${nPage}">
			  	</form>
		    </div>
	 </div>
</div>
</body>
</html> 