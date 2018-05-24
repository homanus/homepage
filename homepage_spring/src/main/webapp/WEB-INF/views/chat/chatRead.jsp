<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<link href="${root}/chat_util/css/style.css" rel="Stylesheet" type="text/css">
<link href="${root}/chat_util/css/main.3f6952e4.css" rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Oswald">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open Sans">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript">

//시간 설정
var interval = 500;
//마지막으로 읽어온 시간을 저장, 그 값을 토대로 읽어오기 위함
var finalDate = "";
//계속해서 시간이 초기화 되는 것 방지
var timeFlag = true;
//DB의 변화를 캐치하기 위한 변수
var table_cnt = 0;
var dubFlag = true;
var res;

var chatManager = new function(){

this.time_Get = function(){
		
		if(!timeFlag){
			chatManager.check();
			return false;
		}else{
			timeFlag = false;
			
			$.post(
				"chat_time",
				"",
				function(data,textStatus){

					finalDate = data.realtime;
					chatManager.check();
				}
			)
		}
	}
	
this.check = function(){
	
	$.post(
		"chat_check",
		"table_cnt="+table_cnt+"&chat_index=${dto.chat_index}",
		function(data,textStatus){
			
			if(data.flag == true){
				
				table_cnt = data.count;
				chatManager.show();
			}
		}
	)
}

this.show = function(){
	
	if(table_cnt == 0){
		return false;
	}
	
	$.post(
		"chat_show",
		"table_cnt="+table_cnt+"&chat_index=${dto.chat_index}&finalDate="+finalDate,
		function(data,textStatus){
			res = data;
			showme = data;
			
			if(data.cflag == true){
				chatManager.chat_print();
			}
		}
	)
}

this.chat_print = function(){
	var o = document.getElementById("list");
	var dt, dd;
	// 채팅내용 추가 하기
		for(var i=0; i<showme.size; i++){
			
			
			dt = document.createElement("dt");
			dt.appendChild(document.createTextNode(res.list[i].nickname));
			o.appendChild(dt);
			
			dd = document.createElement("dd");
			dd.appendChild(document.createTextNode(res.list[i].chat_content));
			o.appendChild(dd);
			
			
	
		}
	//스크롤 가장 아래로 내리기
	o.scrollTop = o.scrollHeight;
	timeFlag = true;
	chatManager.time_Get();
}


//채팅 내용 및 닉네임을 입력후 서브밋을 하면 누르게 되면, 비동기 통신
this.write = function(frm) {
	//폼 내의 input 태그 값을 가져오기 위함
	//비동기 통신 요청시 parameter로 보내준다.
	var param = $("#Please_chat").serialize();
	
	//비동기 통신과 동시에 DB에 채팅 내용을 저장한다.
	$.post(
		"chat_write",
		param,
		function(data, textStatus){
			//alert(textStatus);
			
			//JSON data값을 받아온다.				
//				var result = eval("("+data+")");
			//채팅 내용 비워주기
			$("#msg").val("");
			//채팅내용 갱신을 위한 메소드 호출
//				chatManager.check();
		}
	)//post close
	
}//write close




//접속자 닉네임 뿌리기
this.loginList = function(){
		
		if(dubFlag == false){
			return false;
		}
		
	$.post(
		"loginList",
		"",
		function(data, textStatus){
			
			res = data;

			chatManager.Connect();
		}
	)
}
	<%
	if(session.getAttribute("id") != null) {
	%>
		this.loginList();
	<%
	}
	%>

this.Connect = function(){
	var nick = res.nickname+"님이 접속하셨습니다.";
	
	$.post(
		"chat_write",
		"nickname="+res.getTime+"&msg="+nick+"&chat_index=${dto.chat_index}",
		function(data,testStatus){
			dubFlag = false;
			chatManager.show();
		}
	)
}

//정해둔 시간마다 호출
setInterval(this.time_Get, interval);

}//chatManager close



$(function(){
	$("#please_show").click(function(){
		$("#show_chat").css("display","none");
		$("#hide_or_chat").css("display","");
	});
	$("#please_hide").click(function(){
		$("#show_chat").css("display","");
		$("#hide_or_chat").css("display","none");
	});
	$("#chat_reset").click(function(){
		$("#list").empty();
	})
})

</script>
</head> 
<body onblur="window.focus()">
<div id="show_chat"  style="display: none;" align="right">
<a id="please_show"><img src="${root }/chat_util/image/chat.jpg" class="fixed"></a>
</div>

<div id="hide_or_chat" align="right">
	
	<div id="menu_place">
	<p align="left">
	<a id="please_hide" class="w3-button w3-white w3-small" style="text-align: left">접기</a>
	<a id="chat_reset" class="w3-button w3-white w3-small" style="height: 40px;">채팅 내용 지우기</a>
	<a id="chat_list" class="w3-button w3-black w3-small"
	href="javascript:history.back()" style="position: absolute; right:15px; height: 40px;">뒤로가기</a>
	</p>
	</div>
		<dl id="list" style="text-align: left">
	<h6 align="center">
	채팅방 '${dto.chat_title}' 에 입장하셨습니다.
	</h6>
		</dl>
		

<form onsubmit="chatManager.write(this); return false;"
	  name="frm"
	  id="Please_chat">
	  <!-- 로그인 여부를 물어본 이후, 로그인 한 회원이면 닉네임값을 읽어와서 입력 아니라면 새로 등록하도록 해준다. -->
		<p align="left">
	<c:choose>
		<c:when test="${not empty sessionScope.id}">
			<input name="nickname" id="nickname" type="text"
			value="${nickname}" readonly style="position:static; left: 0px;"/>
		</c:when>
		<c:otherwise>
			<input name="nickname" id="nickname" type="text"
			 required="required" placeholder="닉네임입력"
			 >
		</c:otherwise>
	</c:choose>
		<input name="msg" id="msg" type="text" required="required" placeholder="채팅내용을 입력해주세요."/>
<!-- 		<a id="btn"  class="btn btn-default" type="submit">sub</a> -->
		<input name="btn" id="btn" class="w3-button w3-red w3-small" style="height: 33px; margin-bottom: 5px;" type="submit" value="전송"/>
		</p>	
		<input type="hidden" name="chat_index" value="${dto.chat_index }"/>
</form>


</div>

</body>
</html> 