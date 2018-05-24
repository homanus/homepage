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
function bread(bbsno){
	var url="read";
	url+="?bbsno="+bbsno;
	url+="&col=${col}";
	url+="&word=${word}";
	url+="&nowPage=${nowPage}";
	location.href=url;
}

function create(){
	var url="create";
	location.href=url;
}

function fileDown(filename){
	var url = "${root}/download";
	url+="?filename="+filename;
	url+="&dir=/storage_bbs";
	
	location.href = url;
}
</script>
</head> 
<body>
<div class="w3-white">
	<div class="container">
		<h2><span class="glyphicon glyphicon-th-list"></span>게시판 목록</h2>
			 <div class="search">
				 <form action="./list" method="post" name="fname">
					 <select name="col"><!-- 검색할 컬럼 -->

					 	<option value="wname"
					 	<c:if test="${col == 'wname' }">
					 	selected
					 	</c:if>
					 	>성명</option>

					 	<option value="title"
					 	<c:if test="${col == 'title' }">
					 	selected
					 	</c:if>
					 	>제목</option>

					 	<option value="content"
					 	<c:if test="${col == 'content' }">
					 	selected
					 	</c:if>
					 	>내용</option>
					 	
					 	<option value="total">전체출력</option>
					 </select>
					 <input type="search" name="word" value="${word }"  required> <!-- 검색어 -->
					 <button>검색</button>
					 <button type="button" onclick="create()">등록</button>
				 </form>
			</div>
			
		 <TABLE style="width:100%">
			  <thead>
			    <TR>
			      <TH><div style="margin:10px">번호</div></TH>
			      <Th><div style="margin:10px">작성자</div></Th>
			      <Th><div style="margin:10px">제목</div></Th>
			      <Th><div style="margin:10px">작성날짜</div></Th>
			      <Th><div style="margin:10px">조회수</div></Th>
			      <Th><div style="margin:10px">파일명</div></Th>
			    </tr>
			    <tr>
			  </thead>
			    <c:choose>
			    	<c:when test="${empty list}">
					    <tbody>
						    <tr>
						    	<td colspan="6">등록된 게시글이 없습니다.</td>
						    </tr>
					    </tbody>
			    	</c:when>
			    	<c:otherwise>
			    		<c:forEach var="dto" items="${list }">
					    	<tbody>
					    		<tr>
							    	<td><div style="margin:10px">${dto.bbsno}</div></td>
							    	<td><div style="margin:10px">${dto.wname }</div></td>
							    	<td>
								    	<div style="margin:10px">
								    		<c:if test="${dto.indent > 0 }">
								    			<c:forEach begin="0" end="${dto.indent-1}">
								    				&nbsp;&nbsp;
								    			</c:forEach>
								    			<img src='${root}/images/re.jpg'>
								    		</c:if>
								    	<a href="javascript:bread('${dto.bbsno}')">${dto.title}</a>
								    		<c:if test="${util:compareDay(dto.wdate)}">
												<img src="${root}/images/new.gif">							    		
								    		</c:if>
								    	</div>
							    	</td>
							    	<td><div style="margin:10px">${dto.wdate}</div></td>
							    	<td><div style="margin:10px">${dto.viewcnt}</div></td>
							    	<td>
							    		<div style="margin:10px">
											<c:choose>
												<c:when test="${empty dto.filename}">
													${dto.filename}
												</c:when>
												<c:otherwise>
													<a href="javascript:fileDown('${dto.filename }')"${dto.filename }>${dto.filename }</a>
												</c:otherwise>
											</c:choose>
										</div>
							    	</td>
						    	</tr>
						    </tbody>
					   	</c:forEach>
			    	</c:otherwise>
			    </c:choose>
		  </TABLE>
	</div>
</div>
</body>
</html> 