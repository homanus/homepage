<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8"/>
   <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
   <title>jQuery Mobile</title>
   <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css"/>
   <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
   <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
   <script type="text/javascript">
   function gohome(){
	   var url = "${root}";
	   location.href=url;
   }
   
   var result;
   
   $(function(){
	   $("#value_big").click(function(){
		   result = "a";
	   })
	   $("#value_small").click(function(){
		   result = "b";
	   })
	   //\=======================================
	   $("#value_fly").click(function(){
		   result += "a";
	   })
	   $("#value_landing").click(function(){
		   result += "b";
	   })
	   $("#value_Be_buried").click(function(){
		   result += "c";
	   })
	   //==========================================
	   $("#value_biger").click(function(){
		   result += "a";
	   })
	   $("#value_smaller").click(function(){
		   result += "b";
	   })
	   //===========================================
	   $("#value_connect").click(function(){
		   result += "a";
	   })
	   $("#value_far").click(function(){
		   result += "b";
	   })
	   //===========================================
	   $("#b").click(function(){
		   if(result=="aaaa"||result=="baaa"||result=="bbaa"||result=="baba"||result=="baab"){
			 $("#gag").css("display","");
		   }else if(result=="abaa"||result=="acaa"||result=="aaba"||result=="abba"||result=="acba"){
			 $("#leader").css("display","");
		   }else if(result=="acbb"||result=="bbba"||result=="bbbb"||result=="abab"||result=="abbb"){
			 $("#leader").css("display","");
		   }else if(result=="aaab"||result=="acab"||result=="aabb"||result=="babb"){
			 $("#tough").css("display","");
		   }else if(result=="bbab"||result=="bcab"||result=="bcbb"){
			 $("#Serious").css("display","");  
		   }else if(result=="bcaa"||result=="bcba"){
			 $("#Be_tough").css("display",""); 
		   }
	   })
	   $("#i").click(function(){
		   if(result=="aaaa"||result=="baaa"||result=="bbaa"||result=="baba"||result=="baab"){
			 $("#gag").css("display","");
		   }else if(result=="abaa"||result=="acaa"||result=="aaba"||result=="abba"||result=="acba"){
			 $("#leader").css("display","");
		   }else if(result=="acbb"||result=="bbba"||result=="bbbb"||result=="abab"||result=="abbb"){
			 $("#leader").css("display","");
		   }else if(result=="aaab"||result=="acab"||result=="aabb"||result=="babb"){
			 $("#tough").css("display","");
		   }else if(result=="bbab"||result=="bcab"||result=="bcbb"){
			 $("#Serious").css("display","");  
		   }else if(result=="bcaa"||result=="bcba"){
			 $("#Be_tough").css("display",""); 
		   }
	   })
	   $("#r").click(function(){
		   if(result=="aaaa"||result=="baaa"||result=="bbaa"||result=="baba"||result=="baab"){
			 $("#gag").css("display","");
		   }else if(result=="abaa"||result=="acaa"||result=="aaba"||result=="abba"||result=="acba"){
			 $("#leader").css("display","");
		   }else if(result=="acbb"||result=="bbba"||result=="bbbb"||result=="abab"||result=="abbb"){
			 $("#leader").css("display","");
		   }else if(result=="aaab"||result=="acab"||result=="aabb"||result=="babb"){
			 $("#tough").css("display","");
		   }else if(result=="bbab"||result=="bcab"||result=="bcbb"){
			 $("#Serious").css("display","");  
		   }else if(result=="bcaa"||result=="bcba"){
			 $("#Be_tough").css("display",""); 
		   }
	   })
	   $("#d").click(function(){
		   if(result=="aaaa"||result=="baaa"||result=="bbaa"||result=="baba"||result=="baab"){
			 $("#gag").css("display","");
		   }else if(result=="abaa"||result=="acaa"||result=="aaba"||result=="abba"||result=="acba"){
			 $("#leader").css("display","");
		   }else if(result=="acbb"||result=="bbba"||result=="bbbb"||result=="abab"||result=="abbb"){
			 $("#leader").css("display","");
		   }else if(result=="aaab"||result=="acab"||result=="aabb"||result=="babb"){
			 $("#tough").css("display","");
		   }else if(result=="bbab"||result=="bcab"||result=="bcbb"){
			 $("#Serious").css("display","");  
		   }else if(result=="bcaa"||result=="bcba"){
			 $("#Be_tough").css("display",""); 
		   }
	   })
	   
		   
   })
   
   </script>
</head>
<body>
	<div data-role="page" id="page1" data-position="fixed">
		<div data-role="header">
			<h1>심리테스트</h1>
		</div>
		<div data-role="content">
			 <div align="center" style="margin-top: 100px;"><h1>여러분의 심리를 알아보세요!</h1></div>
			 <a href="#test1" data-role="button">심리테스트1</a>
			 <a href="#test2" data-role="button" data-transition="slide">심리테스트2</a>
			 <a href="#test3" data-role="button">심리테스트3</a>
			 <a href="javascript:gohome()" data-role="button">홈으로</a>
		 </div>
	 </div>
	 
	 
	 
	<!-- 1 시작 -->
	<div data-role="dialog" id="test1" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트 1/5</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/unnamed1.jpg" width="100%" height="100%">
	<h3>사막에 있는 당신! UFO를 보았습니다.<br>
	UFO의 크기는 어떨까요?</h3>
	</div>
	<a href="#big-2-5" data-role="button" id="value_big">크다</a>
	<a href="#big-2-5" data-role="button" id="value_small">작다</a>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	
	
	<!-- big-2/5 -->
	<div data-role="dialog" id="big-2-5" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트2/5</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/unnamed2.jpg" width="100%" height="100%">
	<h3>지금 그 UFO의  상태는 어떤가요?</h3>
	</div>
	<a href="#big-3-5" data-role="button" id="value_fly">날아다닌다</a>
	<a href="#big-3-5" data-role="button" id="value_landing">사막위에 착륙한 상태</a>
	<a href="#big-3-5" data-role="button" id="value_Be_buried">모래에 파뭍혀있는 상태</a>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	
	
	<!-- big3/5 -->
	<div data-role="dialog" id="big-3-5" data-position="fixed">
	<div data-role="header">
	<h1>심리 테스트3/5</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/unnamed3.jpg" width="100%" height="100%">
	<h3>UFO주변에서 사다리가 있네요?<br>사다리의 크기는 어떨까요?</h3>
	</div>
	<a href="#big-4-5" data-role="button" id="value_biger">크다</a>
	<a href="#big-4-5" data-role="button" id="value_smaller">작다</a>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	
	
	<!-- big4/5 -->
	<div data-role="dialog" id="big-4-5" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트4/5</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/unnamed4.jpg" width="100%" height="100%">
	<h3>그 사다리는 지금 어디에 있나요?</h3>
	</div>
	<a href="#big-5-5" data-role="button" id="value_connect">UFO와 연결되어 있다.</a>
	<a href="#big-5-5" data-role="button" id="value_far">UFO와 떨어져 있다.</a>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	
	<!-- big5/5 -->
	<div data-role="dialog" id="big-5-5" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트5/5</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/unnamed5.jpg" width="100%" height="100%">
	<h3>마지막! 하늘을 올려다 본 당신이 본 것은 무엇일까요?</h3>
	</div>
	<a href="#big-bird-end" data-role="button" id="b">새</a>
	<a href="#big-bird-end" data-role="button" id="i">태양</a>
	<a href="#big-bird-end" data-role="button" id="r">달</a>
	<a href="#big-bird-end" data-role="button" id="d">구름</a>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	
	<div data-role="dialog" id="big-bird-end" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트 결과</h1>
	</div>
	<div data-role="content">
	
		<div id="gag" style="display: none">
		<img src="${root}/m_Psychological_testing_image/smile.jpg" width="100%" height="100%">
		<h1>[개그본능]</h1>
		<h3>이 재미있고 유쾌한 것을 어떻게 지금까지 숨기고 있었는지 모르겠네요.<br>
		실제로 배꼽을 빠지게 할 정도의 개그본능을 가지고 있습니다!<br>
		텔레비전의 개그 프로그램을 보면서 한 번도 웃지 않은 경험이 많으시죠?<br>
		이게 다~ 당신이 가지고 있는 개그 본능이 너무나도 강력하기 때문입니다.<br>
		본인 스스로가 제일 웃기지만, 분위기상 스스로 억제하고 있네요.<br>
		당신의 개그본능이 점점 무르익고 있어요!!<br>
		슬슬 이 개그본능을 꺼내볼까요?
		</h3>
		<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
		</div>
		
		<div id="leader" style="display: none">
		<img src="${root}/m_Psychological_testing_image/leader.jpg" width="100%" height="100%">
		<h1>「리더십</h1>
		<h3>
		이 좋은 것을 왜 아직까지 숨기고 있는지 모르겠네요.<br>
		카리스마와 부드러움을 겸비한 리더십을 가지고 있습니다!<br>
		'나라면 이렇게 했을텐데' 라는 생각을 많이 하는 편이지만<br>
		지금은 앞장서기 보다는 뒤에서 조용히 사태를 파악하고 있네요.<br>
		아직은 때가 아니라는 생각인가요? 당신의 리더십이 점점 무르익고 있어요!!<br>
		슬슬 이 리더십을 꺼내볼까요?<br>
		뒷모습만 봐도 이유없이 따르고 싶은 리더십을 가지고 있네요~~<br>
		결과를 공유하고 당신의 리더십을 알고 있는 친구를 태그해보세요!<br>
		</h3>
		<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
		</div>
		
		<div id="tough" style="display: none">
		<img src="${root}/m_Psychological_testing_image/tough.jpg" width="100%" height="100%">
		<h1>「터프함」</h1>
		<h3>
		이 박력있는 것을 어떻게 지금까지 숨기고 있었는지 모르겠네요.<br>
		거칠지만 끈기 있는 터프함을 가지고 있습니다!<br>
		야성미 넘치는 터프함을 발휘하고 싶은 때가 한, 두 번이 아니군요~<br>
		배려심이 많아 당신의 터프함을 보여주기 보다는 부드러운 모습으로<br>
		상대방을 편안하게 만들고 있습니다. 당신의 터프함이 점점 무르익고 있어요!<br>
		슬슬 이 터프함을 꺼내 반전매력을 뽐내볼까요?<br>
		박력 쩔어! 어떻게 숨기고 살아요~ 이제는 당신의 터프함을 알려주세요!!<br>
		결과를 공유하고 당신의 터프함을 알고 있는 친구를 태그해보세요!<br>
		</h3>
		<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
		</div>
		
		<div id="Serious" style="display: none">
		<img src="${root}/m_Psychological_testing_image/Serious.jpg" width="100%" height="100%">
		<h1>「진지함」</h1>
		<h3>
		이 좋은 것을 왜 아직까지 숨기고 있는지 모르겠네요.<br>
		항상 고민하고 생각하는 진지함을 가지고 있습니다!<br>
		텔레비전의 개그 프로그램을 보면서 한 번도 웃지 않은 경험이 많으시죠?<br>
		이게 다~ 당신이 가지고 있는 진지함이 너무나도 강력하기 때문입니다.<br>
		주변으로부터 진지충이라는 말을 듣기 싫어 숨기고 있지만,<br>
		실제로는 매우 사려깊으며 논리적인 생각을 매우 진지하게 하고 있습니다.<br>
		당신의 진지함이 점점 무르익고 있어요!! 슬슬 이 진지함을 꺼내볼까요?<br>
		수많은 생각과 고민 끝에 나온 당신의 말이나 행동 하나하나 버릴 것이 없네요~<br>
		결과를 공유하고 당신의 진지함을 알고 있는 친구를 태그해보세요!<br>
		</h3>
		<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
		</div>
		
		<div id="Be_tough" style="display: none">
		<img src="${root}/m_Psychological_testing_image/Be_tough.jpg" width="100%" height="100%">
		<h1>「까칠함」</h1>
		<h3>
		왜 지금까지 숨기고 있는지 모르겠네요.<br>
		시크하고 도도한 느낌이 물씬 나는 까칠함을 가지고 있습니다!<br>
		실제로는 매우 까칠하지만 타인을 배려하는 마음에 절대 이 까칠함을<br>
		꺼내지 않고 있네요~ 그러나 이제는 슬슬 꺼내도 될 것 같아요!<br>
		까칠함도 매력이 되는 시대잖아요? 당신이 가진 까칠함이 매력 포인트를<br>
		조금 더 올려줄겁니다~ 당신의 까칠함이 무르익고 있어요!!<br>
		슬슬 이 까칠함을 꺼내볼까요?<br>
		겉은 부드러운데 속은 까칠까칠한 반전 매력의 소유자네요~~<br>
		결과를 공유하고 당신의 까칠함을 알고 있는 친구를 태그해보세요!<br>
		</h3>
		<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
		</div>
	</div>
	</div>
	
	
	
	
	
	
	
	
	
	<!-- 심리테스트2 -->
	 <div data-role="dialog" id="test2" data-position="fixed">
	<div data-role="header">
	<h1>간단한 심리테스트_Elevator</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/Ele.jpg" width="100%" height="100%">
	<h3>Q.당신은 지금 엘리베이터 앞에 있습니다.<br>
	엘리베이터를 기다리는 당신,<br>
	현재의 모습은 어떤가요?</h3>
	<a href="#A" data-role="button">A.발을 동동 구르고 있다</a>
	<a href="#B" data-role="button">B.게속 엘리베이터 버튼을 누르고 있다</a>
	<a href="#C" data-role="button">C.주변을 둘러보거나 안내판 등을 보고 있다</a>
	<a href="#D" data-role="button">D.그냥 바닥을 쳐다보고 있다</a>
	<a href="#E" data-role="button">E.엘리베이터 LED화면을 계속 보면서<br>'문 열리지마자 타야지' 생각하고 있다.</a>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	</div>
	
	
	
	
	<div data-role="dialog" id="A" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트 결과_Elevator</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/sin.jpg" width="100%" height="100%">
	<h3>A. 다소 예민하고 신경질적이다.<br>
	예술적으로 소질이 있어 특기가 생긴다.</h3>
	</div>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	
	<div data-role="dialog" id="B" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트 결과_Elevator</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/hang.jpg" width="100%" height="100%">
	<h3>B. 생각을 오래 하기보다는 몸을 먼저 움직이는 행동력이 강한사람이다.<br>
	어떤 하나의 일에 집중하게 되면 다른 것들은 눈에 잘 안들어와서 한가지 일을<br>
	제외하고 다른 것들은 소홀히 하는 경우가 있다.<br>
	다만, 행동적이고 재치가 있어 사람들에게 인기가 좋다<br></h3>
	</div>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	
	<div data-role="dialog" id="C" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트 결과_Elevator</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/warm.jpg" width="100%" height="100%">
	<h3>C. 마음이 따듯하며 온화하고 인기가 많다.<br>
	하지만 자신의 결점에 대해 알려지는 것을 꺼려해 사람들과<br>
	벽을 쌓는 경우가 있다. 이로인해 사람들은<br>
	이 사람을 냉정하다고 오해하기도 한다.<br>
	인맥은 넓지 않으나 한명이라도 깊게 관계를 맺어하는 성향으로<br>
	이공계쪽에 잘 어울린다.<br>
	</h3>
	</div>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	
	<div data-role="dialog" id="D" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트 결과_Elevator</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/bele.jpg" width="100%" height="100%">
	<h3>D. 다소 소극적이기 하지만 상당히 솔직함을 가지고 있다.<br>
	타인을 믿는다거나 좋아하게 되는데에 있어 거부감을 느끼지 않기 때문에<br>
	대인관계가 넓고 다툼이 적다<br>
	</h3>
	</div>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	
	<div data-role="dialog" id="E" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트 결과_Elevator</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/row.jpg" width="100%" height="100%">
	<h3>E. 안정적인 것을 좋아해 큰 리스크를 안고 무리하게 진행하지 않는다.<br>
	어떤 인간관계에 있어 문제가 있어도 합리적으로 어긋난 것을 하지 않는 편이다.<br>
	감정적으로 해결하기 보다는 이성적으로,<br>
	논리적으로 행동하기 때문에 사람들이 많이 따르는 편이다<br>
	</h3>
	</div>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	<!-- 심리테스트2 END -->
	
	<!-- 심리테스트3 Start -->
	<div data-role="dialog" id="test3" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트3_Travel</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/Travel.jpg" width="100%" height="100%">
	<h3>Q.친구들과 여행을 떠난 당신,<br>
	여행지에 도착해서 당신이 찍은 사진은?</h3>
	<a href="#A-1" data-role="button">A.얼굴만 클로즈업한 셀카</a>
	<a href="#B-1" data-role="button">B.나는 보일듯 말듯 배경사진</a>
	<a href="#C-1" data-role="button">C.친구들과 익살스러운 단체사진</a>
	<a href="#D-1" data-role="button">D.관광지 배경에 독사진</a>
	<a href="#E-1" data-role="button">E.풍경만 있는 사진</a>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	</div>
	
	
	<div data-role="dialog" id="A-1" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트 결과3_Travel</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/self.jpg" width="100%" height="100%">
	<h3>
	A. 얼굴만 클로즈업한 셀카 를 선택한 당신은 ?<br>
	뭐든지 열심히 하려는 행동파!<br>
	통솔력 리더쉽이 있고 자신감 넘치고 활기찬 성격으로<br>
	다른사람 주목받기를 좋아합니다<br>
	또한, 완벽추구 성격으로 쉽게 만족하지 못하는 타입<br>
	</h3>
	</div>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	<div data-role="dialog" id="B-1" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트 결과3_Travel</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/bagu1.jpg" width="100%" height="100%">
	<h3>
	B. 나는 보일듯 말듯 배경사진을 선택한 당신은 ?<br>
	감수성이 풍부한 낭만파<br>
	남의 말을 잘들어주고 고민을 함께나누며 힘이되어주는 좋은사람입니다.<br>
	감정기복이 심해 그때그때 변화의 휩쓸리기 쉬운 타입<br>
	</h3>
	</div>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	<div data-role="dialog" id="C-1" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트 결과3_Travel</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/danche.jpg" width="100%" height="100%">
	<h3>
	C. 친구들과 익살스러운 단체사진 을 선택한 당신은 ?<br>
	둥글둥글 무난하게 살고 싶어하는 평범파<br>
	원만한 대인관계를 원하고 성실하고 예의바르고 성격이 좋아 인기가 좋습니다<br>
	그리고 다른사람을 많이 의식하고 마음속 상처를 숨기는 타입<br>
	</h3>
	</div>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	<div data-role="dialog" id="D-1" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트 결과3_Travel</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/dok.jpg" width="100%" height="100%">
	<h3>
	D. 관광지 배경에 독사진 을 선택한 당신은 ?<br>
	무조건 열심히 더높이 미래지향파<br>
	목표가 크고 성취욕이 높아 스스로가 엄격하고 성실합니다<br>
	그리고 다른사람에 대한 비판적 태도가 있고 불만이 많은 타입입니다.<br>
	</h3>
	</div>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	<div data-role="dialog" id="E-1" data-position="fixed">
	<div data-role="header">
	<h1>심리테스트 결과3_Travel</h1>
	</div>
	<div data-role="content">
	<img src="${root}/m_Psychological_testing_image/pung.jpg" width="100%" height="100%">
	<h3>
	E. 풍경만 있는 사진 을 선택한 당신은 ?<br>
	혼자있고 싶은 날이 많은 고독파<br>
	사람보다는 온라인이나 반려동물과 함께 하는 것을<br>
	선호하고 타인에대한 편견이 없고 주변을 신경쓰지 않습니다.<br>
	다소 차갑고 냉정한 이미지로 비춰 질수 있는 타입<br>
	</h3>
	</div>
	<a href="${root}/etc/m_Psychological_testing" data-role="button">심리테스트 메인으로</a>
	</div>
	<!-- 심리테스트3 END -->
</body>
</html>