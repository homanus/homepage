<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi4.jsp" %>
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
  font-size: 20px;
  border-spacing:0px;
  border-style:none;
  padding:0px;
}
h1,h2,h3,h4,h5,h6 {font-family: "Oswald"}

body {font-family: "Open Sans"}
</style> 
<script type="text/javascript">
function incheck(f){
	if(f.mname.value==false){
		alert("이름을 입력해주세요.");
		f.mname.focus();
		return false;
	}
	if(f.title.value==""){
		alert("제목을 입력해주세요.");
		f.title.focus();
		return false;
	}
	if(f.content.value==""){
		alert("내용을 입력해주세요.");
		f.content.focus();
		return false;
	}
	if(f.passwd.value==""){
		alert("비밀번호를 입력해주세요.");
		f.passwd.focus();
		return false;
	}
	if(f.fname.value==""){
		alert("사진을 올려주세요.");
		
		return false;
		
	}
	
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top2.jsp" flush="false"/>
<!-- *********************************************** -->
<div class="w3-white">
<div class="container">

<h2><span class="glyphicon glyphicon-pencil">
</span>글 등록</h2>

 
<FORM	 name='frm' 
		 method='POST' 
		 action='createProc.jsp'
		 enctype="multipart/form-data"
		 onsubmit="return incheck(this)">
		 
		 

  <TABLE class="table table-bordered">
    <TR>
      <TH><div style="margin:10px">파일등록</div></TH>
      <TD><div style="margin:10px"><input type="file" name="fname" accept=".jpg,.png,.gif"></div></TD>
    </TR>
    <TR>
      <TH><div style="margin:10px">이름</div></TH>
      <TD><div style="margin:10px"><input type="text" name="mname" size="15"></div></TD>
    </TR>
    <TR>
      <TH><div style="margin:10px">제목</div></TH>
      <TD><div style="margin:10px"><input type="text" name="title" size="15"></div></TD>
    </TR>
    <TR>
      <TH><div style="margin:10px">내용</div></TH>
      <TD><div style="margin:10px"><textarea name="content" rows="7"></textarea></div></TD>
    </TR>
    <TR>
      <TH><div style="margin:10px">비밀번호</div></TH>
      <TD><div style="margin:10px"><input type="password" name="passwd" size="15"></div></TD>
    </TR>
    
  </TABLE>

  <p class="w3-center">
    <input type='submit' class="w3-button w3-red" value='등록'>
    <input type='button' class="w3-button w3-white w3-border" value='뒤로가기' onclick="history.back()">
    </p>
</FORM>

</div>
</div>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 