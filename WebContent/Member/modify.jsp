<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath }/css/modify.css" rel="stylesheet">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script>
  	$(function(){
  	// keyup event(tel 중복 확인용) 
  		var patternTel = /^\d{3}-\d{3,4}-\d{4}$/;
  		var dbmtel = '${member.mtel }'
  		$('#mtel').keyup(function(){
  			var mtel = $(this).val().trim();
  			if(mtel == "" || mtel == dbmtel) {
  				$('#telConfirmResult').html('&nbsp; &nbsp; &nbsp;');
  			} else if(!mtel.match(patternTel)) {
  				$('#telConfirmResult').html('<b>전화번호 형식을 지켜주세요</b>');
  			} else {
	  			$.ajax({
	  				url : '${conPath}/mtelConfirm.do',
	  				type : 'get',
	  				data : 'mtel='+mtel,
	  				dataType : 'html',
	  				success : function(data) {
	  					$('#telConfirmResult').html(data);
	  				}
	  			}); // ajax 함수
  			}
  		}); 
  		// keyup event(email 중복 확인용)   		
  		var patternMemail = /^[a-zA-Z0-9_\.]+@[a-zA-Z0-9_]+(\.\w+){1,2}$/;
  		var dbmemail = '${member.memail }'
  		$('input[name="memail"]').keyup(function(){
  			var memail = $(this).val().trim();
  			if(memail=="" || memail == dbmemail){
  				$('#emailConfirmResult').html('&nbsp; &nbsp; &nbsp;');
  			} else if(!memail.match(patternMemail)){
  				$('#emailConfirmResult').html('<b>메일 형식을 지켜 주세요</b>');
  			} else{
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
  		}); 
  		// // keyup event(pw 일치 확인용) 
  		var patternPw = /^[A-Za-z0-9]{6,12}$/;
  		$('#mpw, #mpwChk').keyup(function(){
  			var mpw = $('#mpw').val().trim();
  			var pwChk = $('#mpwChk').val().trim();  			
  			if(!mpw.match(patternPw)) {
  				$('#pwChkResult').html('<b>숫자 또는 문자 6~12자리 이내로 입력해주세요</b>'); 
  			} else if(mpw=="" || pwChk=="") {
  				$('#pwChkResult').html('&nbsp; &nbsp; &nbsp;');
  			} else if(mpw == pwChk) {
  				$('#pwChkResult').text('비밀번호 일치');
  			} else {
  				$('#pwChkResult').html('<b>비밀번호 불일치</b>');
  			} 
  		}); 
  		// submit 조건
  		$('form').submit(function(){
  	  		var pwChkResult         = $('#pwChkResult').text().trim();
  	  		var telConfirmResult    = $('#telConfirmResult').text().trim();
  	  		var inputMtel           = $('#mtel').value();
  	  		var emailConfirmResult  = $('#emailConfirmResult').text().trim();
  	  		var inputMemail         = $('#memail').value();
  	  		if(pwChkResult == '숫자 또는 문자 6~12자리 이내로 입력해주세요') {
  	  			alert('비밀번호를 확인하세요');
  	  			$('#mpw').focus();
  	  			return false;
  	  		} else if(dbmtel != inputMtel || telConfirmResult == '중복된 연락처입니다') {
  	  			alert('연락처를 확인하세요');
  	  			$('#mtel').focus();
  	  			return false;
  	  		} else if(dbmemail != inputMemail || emailConfirmResult == '중복된 E-Mail입니다') {
  	  			alert('이메일을 확인하세요');
  	  			$('#memail').fucos();
  	  			return false;
  	  		}
  		});  		
  	});
   </script>
</head>
<body>
	<jsp:include page="../Main/header.jsp"/>
	<div id="modifyForm_wrap">
		<form action="${conPath }/modify.do" method="post">
			<input type="hidden" name="dbMpw" value="${member.mpw }">
			<div id="modify_title">정보수정</div>
			<table>
				<tr>
					<th><label for="mid">아이디</label></th>
					<td>
						<input type="text" name="mid" id="mid" class="mid" value="${member.mid }" 
									 readonly="readonly" style="background-color: #FFFFFF">
					</td>
				</tr>
				<tr>
					<th><label for="oldMpw">현재 비밀번호</label></th>
					<td><input type="password" name="oldMpw" id="oldMpw" class="oldMpw" required="required"></td>
				</tr>
				<tr>
					<th><label for="mpwChk">새 비밀번호</label></th>
					<td>
						<input type="password" name="mpw" id="mpw" class="mpw">
						<div id="pwChkResult"> &nbsp; &nbsp; &nbsp; </div>
					</td>
				</tr>
				<tr>
					<th><label for="mkname">한글이름</label></th>
					<td><input type="text" name="mkname" id="mkname" class="mkname" value="${member.mkname }" required="required"></td>
				</tr>
				<tr>
					<th><label for="mename">영문이름</label></th>
					<td><input type="text" name="mename" id="mename" class="mename" value="${member.mename }" required="required"></td> 
				</tr>
				<tr>
					<th><label for="mtel">연락처</label></th>
					<td>
						<input type="text" name="mtel" id="mtel" class="mtel" value="${member.mtel }" required="required">
						<div id="telConfirmResult"> &nbsp; &nbsp; &nbsp; </div>
					</td>
				</tr>
				<tr>
					<th><label for="memail">이메일</label></th>
					<td>
						<input type="text" name="memail" id="memail" class="memail" value="${member.memail }" required="required">
						<div id="emailConfirmResult"> &nbsp; &nbsp; &nbsp; </div>
					</td>
				</tr>			
				<tr>
					<th>생년월일</th>
					<td><input type="text" name="mbirth" id="datepicker" class="mbirth" value="${member.mbirth }" required="required"></td>
				</tr>
				<tr>
					<th><label for="mgender">성별</label></th>
					<td>
						<c:if test="${member.mgender eq 'M' }">
							<input type='radio' name='mgender' value='M' checked="checked"/> 남자
							<input type='radio' name='mgender' value='F'/> 여자						
						</c:if>
						<c:if test="${member.mgender eq 'F' }">
							<input type='radio' name='mgender' value='M'/> 남자
							<input type='radio' name='mgender' value='F' checked="checked"/> 여자						
						</c:if>
					</td>
				</tr>
				<tr>
					<th><label for="mname">국적</label></th>
					<td><input type="text" name="mnation" id="mnation" class="mnation" required="required" value="${member.mnation }"></td>
				</tr>
				<tr>
				</tr>
				<tr>
					<td colspan="2" id="lasttd">
						<input type="submit" value="정보수정" class="btn">
						<input type="button" value="이전" class="btn" onclick="history.back()">
					</td>
				</tr>
			</table>
			<p><a href="withdrawal.do">회원탈퇴</a></p>
		</form>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>


