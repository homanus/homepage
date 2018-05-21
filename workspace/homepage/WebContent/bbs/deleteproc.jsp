<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi3.jsp" %>
<jsp:useBean id="dao" class="bbs.BbsDAO"/>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%	
	String oldfile = request.getParameter("oldfile");


	Map map = new HashMap();
	map.put("passwd", dto.getPasswd());
	map.put("bbsno",dto.getBbsno());
	
	
	
	boolean pflag = dao.passcheck(map);
	boolean flag = false;
	
	if(pflag){
		flag = dao.delete(dto.getBbsno());
	}
	
	if(flag){
		
		UploadSave.deleteFile(upDir, oldfile);
	}
	
%>
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
function blist(){
	var url="list.jsp";
	url+="?col=<%=request.getParameter("col")%>";
	url+="&word=<%=request.getParameter("word")%>";
	url+="&nowPage=<%=request.getParameter("nowPage")%>";
	location.href=url;
	
}
</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
<div class="w3-white">
<div class="container">
<div class="w3-center">


	<%if(pflag==false){
		out.print("<h2>비밀번호를 잘못 입력하셨습니다.</h2>");
		out.print("<button type='button' class='w3-button w3-red' onclick='history.back()'>다시시도</button>");
	}else if(flag){
		out.print("<h2>삭제 성공</h2>");
	}else{
		out.print("<h2>삭제 실패</h2>");
	}
	
	
	
	%>
 
  
    <input type='button' class="w3-button w3-white w3-border" value='목록으로' onclick="blist()">

</div>
</div>
</div>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 