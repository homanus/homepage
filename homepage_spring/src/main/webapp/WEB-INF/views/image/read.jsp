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
  width: 50%;
}
.search{
	width:80%;
	margin:2px auto;
	text-align: center;
}
h1,h2,h3,h4,h5,h6 {font-family: "Oswald"}
body {font-family: "Open Sans"}
.curImg{
	margin-right:0;
	border-style:solid;
	border-width: 3px;
	border-color: red;
}
.td_padding{
	padding:5px 5px;
}
</style> 
<script type="text/javascript">
function ilist(){
	var url = "list";
	url+="?nowPage=${param.nowPage}";
	url+="&col=${param.col}";
	url+="&word=${param.word}";
	location.href=url;
}
function icreate(){
	var url = "create";
	location.href=url;
}
function readGo(ino){
	var url="read";
	url+="?ino="+ino;
	url+="&nowPage=${param.nowPage}";
	url+="&col=${param.col}";
	url+="&word=${param.word}";
	
	location.href=url;
}
function idelete(ino){
	var url="delete";
	url+="?ino="+ino;
	url+="&fname=${dto.fname}";
	url+="&nowPage=${param.nowPage}";
	url+="&col=${param.col}";
	url+="&word=${param.word}";
	location.href=url;
}
function iupdate(ino){
	var url="update";
	url+="?ino="+ino;
	url+="&nowPage=${param.nowPage}";
	url+="&col=${param.col}";
	url+="&word=${param.word}";
	location.href=url;
}
function fileDown(fname){
	var url = "${root}/download";
	url+="?filename="+fname;
	url+="&dir=/storage_image";
	
	location.href=url;
	
}

</script>
</head> 
<body>
<div class="w3-white">
	<div class="container">
	  <TABLE class="table table-hover">
	    <tr>
	     <TD colspan="2">
	      <a href="javascript:fileDown('${dto.fname }')"><img src="${root}/storage_image/${dto.fname }" width="100%" height="800px;"></a>
	    </tr>
	    <tr>
	    	<th>${dto.title }</th>
	    	<th style="float: right;">${dto.mname }</th>
	    </tr>
	    <tr>
	    	<td colspan="2">
		    	<div style="width: 100%; height: 200px;">
		    		${dto.content }
		    	</div>
	    	</td>
	    </tr>
	    <tr>
	    	<th>작성날짜</th>
	    	<td>${dto.wdate }</td>
	    </tr>
	  </TABLE>
	  
	  <table class="table table-hover">
		  <tr>
		   <c:set var="files" value="${list[0]}"/> 
		   <c:set var="noArr" value="${list[1]}"/>
			  <c:forEach var="i" begin="0" end="4" >
			  	<c:choose>
			  		<c:when test="${empty files[i]}">
			  			<td class="td_padding"><img src="${root }/storage_image/default.jpg" width="150px" height="125px"></td>
			  		</c:when>
			  		<c:otherwise>
			  			<c:choose>
				  			<c:when test="${noArr[i] == dto.ino }">
					  			<td class="td_padding"><a href="javascript:readGo('${noArr[i]}')">
					  			<img class="curImg" src="${root }/storage_image/${files[i]}" width="150px" height="125px" border="0">
					  			</a></td>
				  			</c:when>
				  			<c:otherwise>
				  			  <td class="td_padding"><a href="javascript:readGo('${noArr[i]}')">
							  <img src="${root }/storage_image/${files[i]}" width="150px" height="125px" border="0">
							  </a></td>
				  			</c:otherwise>
			  			</c:choose>
			  		</c:otherwise>
			  	</c:choose>
			  </c:forEach>
		  </tr>
	  </table>
	  
	  
		<p class="w3-center" >
		   <button type='button' class="w3-button w3-white w3-border" onclick="ilist()">목록</button>
		   <button type='button' class="w3-button w3-white w3-border" onclick="icreate()">등록</button>
		   <button type='button' class="w3-button w3-white w3-border" onclick="iupdate('${dto.ino}')">수정</button>
		   <button type='button' class="w3-button w3-black" onclick="idelete('${dto.ino}')">삭제</button>
		</p>	
	</div>
</div>
</body>
</html> 