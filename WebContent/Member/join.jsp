<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath }/css/join.css" rel="stylesheet">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script>
  	$(function(){
  		$('input[name="mid"]').keyup(function(){
  			var mid = $(this).val();
  			if(mid.length<2) {
  				$('#idConfirmResult').text('아이디는 2글자 이상');
  			} else {
  				$.ajax({
  					url : '${conPath }/midConfirm.do',
  					type : 'get',
  					data : 'mid='+mid,
  					dataType : 'html',
  					success : function(data){
  						$('#idConfirmResult').html(data);
  					},
  				}); // ajax함수
  			}  // if
  		}); // keyup event(id 중복 확인용)
  		var patternTel = 
  		$('#mtel').keyup(function(){
  			var mtel = $(this).val();
  			$.ajax({
  				url : '${conPath}/mtelConfirm.do',
  				type : 'get',
  				data : 'mtel='+mtel,
  				dataType : 'html',
  				success : function(data) {
  					$('#telConfirmResult').html(data);
  				}
  			}); // ajax 함수
  		}); // keyup event(email 중복 확인용)   		
  		var patternMemail = /^[a-zA-Z0-9_\.]+@[a-zA-Z0-9_]+(\.\w+){1,2}$/;
  		$('input[name="memail"]').keyup(function(){
  			var memail = $(this).val();
  			if(!memail.match(patternMemail)){
  				$('#emailConfirmResult').html('<b>메일 형식을 지켜 주세요</b>');
  			}else{
  				$.ajax({
  					url : '${conPath}/memailConfirm.do',
  					type : 'get',
  					data : 'memail='+memail,
  					dataType : 'html',
  					success : function(data){
  						$('#emailConfirmResult').html(data);
  					},
  				});
  			}
  		}); // keyup event(email 중복 확인용)
  		var patternPw = /^[A-Za-z0-9]{6,12}$/;
  		$('#mpw, #mpwChk').keyup(function(){
  			var mpw = $('#mpw').val();
  			var pwChk = $('#mpwChk').val();  			
  			if(!mpw.match(patternPw)) {
  				$('#pwChkResult').text('숫자 또는 문자 6~12자리 이내로 입력해주세요'); 
  			} else if(mpw == pwChk) {
  				$('#pwChkResult').text('비밀번호 일치');
  			} else {
  				$('#pwChkResult').text('비밀번호 불일치');
  			}
  		}); // keyup event(비밀번호 일치 확인용)
  		
  		$('form').submit(function(){
  	  		var idConfirmResult  = $('#idConfirmResult').text().trim();
  	  		var pwChkResult      = $('#pwChkResult').text().trim();
  	  		var telConfirmResult   = $('#telConfirmResult').text().trim();
  	  		var emailConfirmResult = $('#emailConfirmResult').text().trim();
  	  		if(idConfirmResult != '사용 가능한 ID입니다') {
  	  			alert('ID를 확인하세요');
  	  			return false; // submit 제한
  	  		} else if(pwChkResult != '비밀번호 일치') {
  	  			alert('비밀번호를 확인하세요');
  	  			$('#mpw').focus();
  	  			return false;
  	  		} else if(telConfirmResult != '사용 가능한 연락처입니다') {
  	  			alert('연락처를 확인하세요');
  	  			$('#mtel').focus();
  	  			return false;
  	  		} else if(emailConfirmResult != '사용 가능한 E-Mail입니다') {
  	  			alert('이메일을 확인하세요');
  	  			$('#memail').fucos();
  	  			return false;
  	  		}
  		});
  		
  	});
  </script>
  <script>
		$( function() {
		  $( "#datepicker" ).datepicker({
		 	 dateFormat: "yy-mm-dd",
		 	 dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		 	 changeMonth: true,  // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		 	 changeYear: true,   // 년을 바꿀수 있는 셀렉트 박스를 표시한다.
		    showMonthAfterYear: true,
		    yearSuffix: '년',
		    showOtherMonths: true, // 현재 달이아닌 다른 달 날짜를 회색으로 표시한다.
		    minDate: new Date(1920, 1 - 1, 1), // 1920년 1월 일을 최소 날짜로 세팅
		    maxDate: 'y', // 현재 날짜 이전만 선택 가능
		    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		  });
		} );
   </script>
</head>
<body>
	<jsp:include page="../Main/header.jsp"/>
	<div id="joinForm_wrap">
		<form action="${conPath }/join.do" method="post" enctype="multipart/form-data">
			<div id="join_title">회원가입</div>
			<table>
				<tr>
					<th><label for="mid">아이디</label></th>
					<td>
						<input type="text" name="mid" id="mid" class="mid" required="required">
						<div id="idConfirmResult"> &nbsp; &nbsp; &nbsp; </div>
					</td>
				</tr>
				<tr>
					<th><label for="mpw">비밀번호</label></th>
					<td><input type="password" name="mpw" id="mpw" class="mpw" required="required"></td>
				</tr>
				<tr>
					<th><label for="mpwChk">비밀번호 확인</label></th>
					<td>
						<input type="password" name="mpwChk" id="mpwChk" class="mpwChk" required="required">
						<div id="pwChkResult"> &nbsp; &nbsp;  &nbsp; </div>
					</td>
				</tr>
				<tr>
					<th><label for="mname">한글이름</label></th>
					<td><input type="text" name="mkname" id="mkname" class="mkname" required="required"></td>
				</tr>
				<tr>
					<th><label for="mname">영문이름</label></th>
					<td><input type="text" name="mename" id="mename" class="mename" required="required"></td> 
				</tr>
				<tr>
					<th><label for="mtel">연락처</label></th>
					<td>
						<input type="text" name="mtel" id="mtel" class="mtel" required="required">
						<div id="telConfirmResult"> &nbsp; &nbsp; &nbsp; </div>
					</td>
				</tr>
				<tr>
					<th><label for="memail">이메일</label></th>
					<td>
						<input type="text" name="memail" id="memail" class="memail" required="required">
						<div id="emailConfirmResult"> &nbsp; &nbsp; &nbsp; </div>
					</td>
				</tr>			
				<tr>
					<th>생년월일</th>
					<td><input type="text" name="mbirth" id="datepicker" class="mbirth" required="required"></td>
				</tr>
				<tr>
					<th><label for="mgender">성별</label></th>
					<td>
						<input type='radio' name='mgender' value='M'/>남성
						<input type='radio' name='mgender' value='F'/>여성
					</td>
				</tr>
				<tr>
					<th><label for="mname">국적</label></th>
					<td><input type="text" name="mnation" id="mnation" class="mnation" required="required"></td>
				</tr>
				<tr>
				</tr>
				<tr>
					<td colspan="2" id="lasttd">
						<input type="submit" value="가입하기" class="joinBtn_style">
						<input type="button" value="취소" class="joinBtn_style" onclick="location.href='history.back()'">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>













