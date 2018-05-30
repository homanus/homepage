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
table,th{
width: 20%;
}
table,td{
width: 80%;
}
h1,h2,h3,h4,h5,h6 {font-family: "Oswald"}
body {font-family: "Open Sans"}

</style> 
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
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
	}else{
		var parameter = $("#rform").serialize();
		
		$.post(
				"rcreate",
				parameter,
				function(data, textStatus){
					$("[name=content]").val("");
					reply_list(data);
				}
		)
		return false;
	}
	return false;
	
}


function reply_list(data){
	
	var param = {
			nowPage: data.nowPage,
			col: data.col,
			word: data.word,
			bbsno: data.bbsno,
			nPage: data.nPage
	}
	
	$.post(
		"rlist",
		param,
		function(data, textStatus){
			
			var con_list = "";
			
			for(var i=0; i<data.size; i++){
				con_list += "<div class='rlist' style='width: 50%;'>";
				con_list += data.rlist[i].id+"<span style='float: right'>"+data.rlist[i].regdate+"</span><br>";
				con_list += "<p>"+data.rlist[i].content;
				if('${sessionScope.id}'==data.rlist[i].id){
					con_list += "<span style='float: right'>"
					con_list += "<a href='javascript:rupdate("+data.rlist[i].rnum+")'>수정</a>|";
					con_list += "<a href='javascript:rdelete("+data.rlist[i].rnum+")'>삭제</a></span>";
				}
				
				con_list += "</p></div><hr>";
			}
			$("#list_div").html(con_list);
			$("#list_paging").html("${paging}");
		}
	)
}

$(function(){
	var parameter = $("#rform").serialize();
	$.post(
			"loading",
			parameter,
			function(data, textStatus){
				reply_list(data);
			}
	)
});

function rupdate(rnum){
	var param = {
			rnum: rnum
	}
	$.post(
		"getContent",
		param,
		function(data, textStatus){
			var f = document.rform;
			f.content.value = data.content;
			f.rnum.value = rnum;
			f.rsubmit.value="수정";
			f.action="./rupdate";
			$("#rform").attr("onsubmit","return update_ajax(this);");
		}
	)
	
}

function update_ajax(f){
	var parameter = $("#rform").serialize();
	$.post(
			"rupdate",
			parameter,
			function(data, textStatus){
				reply_list(data);
				f.content.value = "";
				f.rsubmit.value="등록";
				f.action="./rcreate";
				$("#rform").attr("onsubmit","return input(this);");
			}
	)
	return false;
}

function rdelete(rnum){
	if(confirm("정말 삭제 하시겠습니까?")){
		
		var parameter={
				bbsno: '${dto.bbsno}',
				rnum: rnum,
				col: '${param.col}',
				word: '${param.word}',
				nowPage: '${param.nowPage}',
				nPage: '${nPage}'
		}
		$.post(
			"rdelete",
			parameter,
			function(data, textStatus){
				reply_list(data);
			}
		)
	}
}
</script>
</head> 
<body>
<div class="w3-white">
	<div class="container" style="width: 60%; margin: auto;">
		<b>&nbsp;&nbsp;No.${dto.bbsno}</b>
		  <TABLE class="table table-hover">
		    <TR>
		      <TH>${dto.wname}</TH>
		      <TH>
		      	${dto.title}
		      	<span style="float:right;">
		      		(조회수:${dto.viewcnt})
		      	</span>
		      </TH>
		    </TR>
		    <TR>
		      <TD colspan="2">
		      	<div style="width: 100%; height: 300px;">
		      		${dto.content }
		      	</div>
		      </TD>
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
		    
		    <div id="list_div">
		    </div>
		    
		    <div id="list_paging">
		    </div>
		    
		    <div class="rcreate">
			  	<form name="rform"
			  	id="rform"
			  	action="./rcreate"
			  	method="post"
			  	onsubmit="return input(this)">
				  	<textarea rows="3" cols="28" name="content"></textarea>
				  	<input class="w3-button w3-red" type="submit" name="rsubmit" value="등록"></input>
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