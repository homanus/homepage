<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<!DOCTYPE html>

<html>
<title>홈페이지 메인</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Oswald">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open Sans">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript">
function bread(bbsno){
	var url="${root}/bbs/read";
	url+="?bbsno="+bbsno;
	url+="&col=${col}";
	url+="&word=${word}";
	url+="&nowPage=${nowPage}";
	location.href=url;
}
function bbs_fileDown(filename){
	var url = "${root}/download";
	url+="?filename="+filename;
	url+="&dir=/${root}/storage_bbs";
	
	location.href = url;
}
function read(ino){
	var url = "${root}/image/read";
	url+="?ino="+ino;
	url+="&nowPage=${image_nowPage}";
	url+="&col=${image_col}";
	url+="&word=${image_word}";
	location.href=url;
}
function image_filedown(fname){
	var url = "${root}/download";
	url+="?filename="+fname;
	url+="&dir=/${root}/storage_image";
	
	location.href=url;
}
function chat(){
	var url="${root}/chat/list";
	
	var wr = window.open(url,"채팅창","width=440, height=610, resizable=no");
	wr.moveTo(((window.screen.width-500)/2),((window.screen.height-500)/2));
	
}
</script>
<style>
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
<body class="w3-light-grey">

  <!-- Image header -->
  <header class="w3-display-container w3-wide" id="home">
    <img class="w3-image" src="${root}/w3images/jane.jpg" width="1600" height="1060">
    <div class="w3-display-left w3-padding-large">
      <h1 class="w3-text-white"></h1>
      <h1 class="w3-jumbo w3-text-white w3-hide-small"><b></b></h1>
<!--       <h6><button class="w3-button w3-white w3-padding-large w3-large w3-opacity w3-hover-opacity-off" onclick="document.getElementById('subscribe').style.display='block'">SUBSCRIBE</button></h6> -->
    </div>
  </header>

<div class="w3-content" style="max-width:1600px">
<!-- TOP END index 시작 -->

  <!-- Grid -->
  <div class="w3-row w3-padding w3-border">

    <!-- Blog entries -->
    <div class="w3-col l8 s12">
    
      <!-- Blog entry -->
      <div class="w3-container w3-white w3-margin w3-padding-large">
        <div class="w3-center">
          <h5><span class="glyphicon glyphicon-list">Board</span>
<!--           <span class="w3-opacity">Board</span> -->
          </h5>
        </div>
        
        	<div class="w3-justify">
				<TABLE style="width:100%">
				  <thead>
				    <TR>
				      <TH><div style="margin:10px">No</div></TH>
				      <Th><div style="margin:10px">작성자</div></Th>
				      <Th><div style="margin:10px">제목</div></Th>
				      <Th><div style="margin:10px">작성날짜</div></Th>
				      <Th><div style="margin:10px">조회수</div></Th>
				      <Th><div style="margin:10px">파일명</div></Th>
				    </tr>
				    <tr>
				  </thead>
			    <c:choose>
			    	<c:when test="${empty bbs_list}">
					    <tbody>
						    <tr>
						    	<td colspan="6">등록된 게시글이 없습니다.</td>
						    </tr>
					    </tbody>
			    	</c:when>
			    	<c:otherwise>
			    		<c:forEach var="bbs_dto" items="${bbs_list }">
					    	<tbody>
					    		<tr>
							    	<td><div style="margin:10px">${bbs_dto.bbsno}</div></td>
							    	<td><div style="margin:10px">${bbs_dto.wname }</div></td>
							    	<td>
								    	<div style="margin:10px">
								    		<c:if test="${bbs_dto.indent > 0 }">
								    			<c:forEach begin="0" end="${bbs_dto.indent-1}">
								    				&nbsp;&nbsp;
								    			</c:forEach>
								    			<img src='${root}/images/re.jpg'>
								    		</c:if>
								    	<a href="javascript:bread('${bbs_dto.bbsno}')">${bbs_dto.title}</a>
								    		<c:if test="${util:compareDay(bbs_dto.wdate)}">
												<img src="${root}/images/new.gif">							    		
								    		</c:if>
<!-- 								    		댓글 개수 -->
								    		<c:set var="rcount" value="${util:rcount(bbs_dto.bbsno,rdao)}"/>
								    		<c:if test="${rcount > 0}">
								    			<span style="color:red">(${rcount })</span>
								    		</c:if>
								    	</div>
							    	</td>
							    	<td><div style="margin:10px">${bbs_dto.wdate}</div></td>
							    	<td><div style="margin:10px">${bbs_dto.viewcnt}</div></td>
							    	<td>
							    		<div style="margin:10px">
											<c:choose>
												<c:when test="${empty bbs_dto.filename}">
													${bbs_dto.filename}
												</c:when>
												<c:otherwise>
													<a href="javascript:bbs_fileDown('${bbs_dto.filename }')"${bbs_dto.filename }>${bbs_dto.filename }</a>
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
		  ${bbs_paging}
        	
        	</div>
      </div>
      <!-- 게시판 목록 보여줄 공간. -->
      <hr>

      <!-- Blog entry -->
      <div class="w3-container w3-white w3-margin w3-padding-large">
        <div class="w3-center">
          <h5><span class="glyphicon glyphicon-film"></span>Imageboard
<!--           <span class="w3-opacity">Image board</span> -->
          </h5>
        </div>

        <div class="w3-justify"><!-- image공간 시작 -->
        	<table class="table table-hover">
				<tr>
					<th>사진</th>
					<th>제목</th>
					<th>이름</th>
					<th>작성날짜</th>
				</tr>
				<c:choose>
					<c:when test="${empty image_list}">
				<tr>
					<td colspan="4">작성된 글이 없습니다.</td>
				</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="image_dto" items="${image_list}">
							<tr>
								<td>
									<a href="javascript:image_filedown('${image_dto.fname}')"${image_dto.fname}>
										<img src="${root}/storage_image/${image_dto.fname}" width="100px" height="80px">
									</a>
								</td>
								<td><a href="javascript:read('${image_dto.ino }')">${image_dto.title }</a></td>
								<td>${image_dto.mname }</td>
								<td>${image_dto.wdate }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
				${image_paging}
        </div><!-- image 공간 끝 -->
      </div>

      <!-- Blog entry -->
       <div class="w3-container w3-white w3-margin w3-padding-large">
	       <div class="w3-center">
		       <h3>I like this picture</h3>
<!-- 		       <h5><span class="w3-opacity">April 7, 2016</span></h5> -->
	       </div>
	
	       <div class="w3-justify">
		       <img src="${root}/w3images/runway.jpg" alt="Runway" style="width:100%" class="w3-padding-16">
	       </div>
       </div><!-- picture end -->
       
         <p class="w3-clear"></p>
         
    </div>

    <!-- About/Information menu -->
    <div class="w3-col l4">
      <!-- About Card -->
      <div class="w3-white w3-margin">
        <img src="${root}/w3images/HanJeongHwan_blue.jpg" style="width:100%">
<%--         <img src="${root}/w3images/HanJeongHwan.jpg" style="width:100%" class="w3-grayscale"> --%>
        <div class="w3-container w3-black">
          <h4>한정환 1995.10.20</h4>
          <p>네, 바로 접니다. 이 홈페이지를 만든 사람</p>
        </div>
      </div>
      <hr>

      <!-- Posts -->
      <div class="w3-white w3-margin">
        <div class="w3-container w3-padding w3-black">
          <h4>Chat room</h4>
        </div>
        	<TABLE class="table table-hover" style="width:100%; ">
			   <c:if test="${empty chat_list}">
					    <tr>
					    	<td colspan="4">등록된 채팅방이 없습니다.</td>
					    </tr>
			   </c:if>
			    <tr>
				  <th>번호</th>
			      <th>채팅방 제목</th>
			      <th>방장</th>
			    </tr>
			<c:forEach var="chat_dto" items="${chat_list}">
			    <tr>
			      <td>${chat_dto.chat_index}</td>
			       <td id="up"><a href="javascript:chat()">${chat_dto.chat_title}</a></td>
			      <td>${chat_dto.chat_nickname}</td>
			    </tr>
			</c:forEach>
		  </TABLE>
      </div>
      <hr>


      <!-- Tags -->
       <div class="w3-white w3-margin">
        <div class="w3-container w3-padding w3-black">
          <h4>Tags</h4>
        </div>
        <div class="w3-container w3-white">
          <p>
            <span class="w3-tag w3-black w3-margin-bottom">잘생김</span>
            <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">#계획적</span>
            <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">#긍정적</span>
            <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">#자신감</span>
            <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">#빼면 시체</span>
            <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">#성실함</span>
            <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">#판타지</span>
            <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">#자존감</span>
            <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">#노력파</span>
            <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">#책이좋아</span>
            <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">#집중력</span>
            <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">#24살</span>
            <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">#노래</span>
            <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">#바다</span>
          </p>
        </div>
      </div>
      <hr>

      <!-- Inspiration -->
      <div class="w3-white w3-margin">
        <div class="w3-container w3-padding w3-black">
          <h4>Inspiration</h4>
        </div>
        <div class="w3-row-padding w3-white">
          <div class="w3-col s6">
            <p><img src="${root}/w3images/jeans.jpg" alt="Jeans" style="width:100%"></p>
            <p><img src="${root}/w3images/team1.jpg" alt="Jeans" style="width:100%"></p>
          </div>
          <div class="w3-col s6">
            <p><img src="${root}/w3images/avatar_hat.jpg" alt="Men in Hats" style="width:100%" class="w3-grayscale"></p>
            <p><img src="${root}/w3images/team4.jpg" alt="Jeans" style="width:100%"></p>
         </div>
        </div>
      </div>
      <hr>

       <div class="w3-white w3-margin">
        <div class="w3-container w3-padding w3-black">
          <h4>Follow Me</h4>
        </div>
        <div class="w3-container w3-xlarge w3-padding">
          <i class="fa fa-facebook-official w3-hover-opacity"></i>
          <i class="fa fa-instagram w3-hover-opacity"></i>
          <i class="fa fa-snapchat w3-hover-opacity"></i>
          <i class="fa fa-pinterest-p w3-hover-opacity"></i>
          <i class="fa fa-twitter w3-hover-opacity"></i>
          <i class="fa fa-linkedin w3-hover-opacity"></i>
        </div>
      </div>
      <hr>
      
      <!-- Subscribe -->
<!--       <div class="w3-white w3-margin">
        <div class="w3-container w3-padding w3-black">
          <h4>Subscribe</h4>
        </div>
        <div class="w3-container w3-white">
          <p>Enter your e-mail below and get notified on the latest blog posts.</p>
          <p><input class="w3-input w3-border" type="text" placeholder="Enter e-mail" style="width:100%"></p>
          <p><button type="button" onclick="document.getElementById('subscribe').style.display='block'" class="w3-button w3-block w3-red">Subscribe</button></p>
        </div>
      </div> -->

    <!-- END About/Intro Menu -->
    </div>

  <!-- END GRID -->
  </div>

<!-- END w3-content -->
</div>

</body>
</html>
