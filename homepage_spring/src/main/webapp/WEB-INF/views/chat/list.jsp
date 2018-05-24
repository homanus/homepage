<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Oswald">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open Sans">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title></title> 
<style type="text/css">
img{
	width : 	50px;
	height: 	50px;
}
img.fixed{
	position: fixed;
	right:0px;
	top:70px;
}
table{
	font-size: 15px;
}
table,th,td{
     border-top: none;
        border-bottom: none;
        }
</style>
<link href="${root}/chat_util/css/main.3f6952e4.css" rel="stylesheet">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<script type="text/javascript">
function read(chat_index){
	var url = "/homepage/chat/chatRead";
	url += "?chat_index="+chat_index;
	url += "&cPage=${cPage}";
	url += "&col=${col}";
	url += "&word=${word}";
	
	location.href=url;
}
function create(){
	var url = "/homepage/chat/chatCreate";
	location.href=url;
}

function cdelete(chat_index){
	
	if(confirm("정말로 채팅방을 삭제하시겠습니까?")){
		
		$.post(
				"/homepage/chat/deleteProc",
				"chat_index="+chat_index,
				function(data,textStatus){
					if(data.flag){
						var url="delete";
						url += "?chat_index="+chat_index;
						location.href=url;
					}else{
						alert("본인이 생성한 채팅방이 아닙니다.");
						return false;
					}
				}
			)
			
	}else{
		return false;
	}
}

$(function(){
	$("#please_show").click(function(){
		$("#show_chat").css("display","none");
		$("#hide_or_chat").css("display","");
	});
	$("#please_hide").click(function(){
		$("#show_chat").css("display","");
		$("#hide_or_chat").css("display","none");
	});
})

</script>
</head> 
<body onblur="window.focus()">
<div id="show_chat"  style="display: none;" align="right">
<a id="please_show"><img src="${root }/chat_util/image/chat.jpg" class="fixed"></a>
</div>

<div align="right" id="hide_or_chat">
		<form method="post" action='list' style="margin: auto;">
<a id="please_hide" class="w3-button w3-white w3-small" style="text-align: left" >접기</a>
			<select name="col" style="height: 35px;">
				<option value="chat_index"
					<c:if test="${col == 'chat_index'}">selected</c:if>
					>번호
				</option>
				<option value="chat_title"
					<c:if test="${col == 'chat_title'}">selected</c:if>
					>제목
				</option>
				<option value="chat_nickname"
					<c:if test="${col == 'chat_nickname'}">selected</c:if>
					>방장이름
				</option>
				<option value="total">전체</option>
			</select>
		<input type="search" name="word" value="${word}" required>
		<button class="w3-button w3-blue w3-small"
		style="height: 40px;">검색</button>
		</form>

  <TABLE class="table table-hover" style="width:100%; ">
	   <c:if test="${empty list}">
			    <tr>
			    	<td colspan="4">등록된 게시글이 없습니다.</td>
			    </tr>
	   </c:if>
    <tr>
	  <th>번호</th>
      <th>채팅방 제목</th>
      <th>방장</th>
      <c:if test="${not empty sessionScope.id}">
      <th>삭제</th>
      </c:if>
    </tr>
<c:forEach var="dto" items="${list }">
    <tr>
      <td>${dto.chat_index}</td>
       <td id="up"><a href="javascript:read('${dto.chat_index}')">${dto.chat_title}</a></td>
      <td>${dto.chat_nickname}</td>
      <c:if test="${not empty sessionScope.id}">
      <td>
      <a href="javascript:cdelete('${dto.chat_index}')">삭제하기</a>
      </td>
      </c:if>
    </tr>
</c:forEach>
  </TABLE>
<c:if test="${not empty sessionScope.id}">
<a id="btn" href="javascript:create()" 
class="w3-button w3-red w3-small"
type="button"
style="height: 40px;">채팅방 생성</a>
</c:if>
	<div align="center">
	 	${paging}
	</div>
</div>


</body>
</html> 