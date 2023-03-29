<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath }/css/atInsertView.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"></script>
  <script>
  	$(function(){
  		// keyup event(acity) 
  		$('#actname, #dctname').keyup(function(){
  			var actname = $('#actname').val().trim();
  			var dctname = $('#dctname').val().trim(); 
  			if(actname==""){
  				$('#acityConfirmResult').html('&nbsp; &nbsp; &nbsp;');
  			} else {
  				$.ajax({
  					url : '${conPath}/cityConfrim.do',
  					type : 'get',
  					data : 'ctname='+actname,
  					dataType : 'html',
  					success : function(data){
  						$('#acityConfirmResult').html(data);
  					},
  				});
  			}
  		}); 
  		// keyup event(dcity) 
  		$('#dctname').keyup(function(){
  			var dctname = $('#dctname').val().trim(); 
  			if(actname==""){
  				$('#dcityConfirmResult').html('&nbsp; &nbsp; &nbsp;');
  			} else {
  				$.ajax({
  					url : '${conPath}/cityConfrim.do',
  					type : 'get',
  					data : 'ctname='+dctname,
  					dataType : 'html',
  					success : function(data){
  						$('#dcityConfirmResult').html(data);
  					},
  				});
  			}
  		}); 
  		// submit 조건
  		$('form').submit(function(){
  	  		var acityConfirmResult  = $('#acityConfirmResult').text().trim();
  	  		var dcityConfirmResult  = $('#dcityConfirmResult').text().trim();
  	  		var plcom 		= $('#plcom').val().trim();
  	  		var plcomcode = $('#plcomcode').val().trim();
  	  		var plname 		= $('#plname').val().trim();
  	  		var plseat 		= $('#plseat').val().trim();
  	  		var atprice 		= $('#atprice').val().trim();
  	  		if(plcom.length > 15){
  	  			alert('항공사 이름은 15자 이내로 입력해주세요');
  	  			$('#plcom').focus();
  	  			return false;
  	  		} else if(plcomcode.length > 3){
  	  			alert('항공사 코드는 3자 이내로 입력해주세요');
  	  			$('#plcomcode').focus();
  	  			return false;
  	  		} else if(plname.length > 3){
  	  			alert('항공사 이름은 15자 이내로 입력해주세요');
  	  			$('#plname').focus();
  	  			return false;
  	  		} else if(plseat > 999){
  	  			alert('항공기 좌석 수를 다시 확인해주세요');
  	  			$('#plseat').focus();
  	  			return false;
  	  		} else if(acityConfirmResult != '도시 이름이 확인되었습니다') {
  	  			alert('출발 도시 이름을 확인하세요');
  	  		  $('#actname').focus();
  	  			return false; // submit 제한
  	  		} else if(dcityConfirmResult != '도시 이름이 확인되었습니다') {
  	  			alert('도착 도시 이름을 확인하세요');
  	  			$('#dctname').focus();
  	  			return false;
  	  		} else if(atprice.length > 8){
  	  			alert('가격을 다시 확인해주세요');
  	  			$('#atprice').focus();
  	  			return false;
  	  		}
  		});  		
  	});
  </script>
  <script>
		$( function() {
			$(".datetimepicker").datetimepicker({ 
				format: "Y-m-d H:i",
			    changeMonth: true,
			    changeYear: true,
			    showButtonPanel: true,
			    format:'Y-m-d H:i',
			    step: 10,
			    defaultSelect: false,
			    defaultDate: false,
			    onClose: function(ct, $i) {
			        let endDateInput = $("#dateEnd");
			        if($("#dateEnd").val() != ''){
			            let tempStartDate = new Date(ct);
			            let tempEndDate = new Date(endDateInput.val());
			            if(tempStartDate > tempEndDate){
			                endDateInput.val(getFormatDateTime(ct));
			            }
			        }else {
			            endDateInput.val(getFormatDateTime(ct));
			        }
			    },
			    onSelectDate: function(ct, $i){
			        $("#dateEnd").datetimepicker('setOptions', { minDate: ct });
			        $("#dateEnd").datetimepicker('setOptions', { minTime: ct });
			    },
			    onSelectTime: function(ct, $i){
			        $("#dateEnd").datetimepicker('setOptions', { minDate: ct });
			        $("#dateEnd").datetimepicker('setOptions', { minTime: ct });
			    }
			});
		} );
   </script>
</head>
<body>
	<jsp:include page="../Main/header.jsp"/>
	<div id="joinForm_wrap">
		<form action="${conPath }/atInsert.do" method="post">
			<div id="join_title">항공권 등록</div>
			<table>
				<tr>
					<th><label for="plcom">항공사 이름</label></th>
					<td>
						<input type="text" name="plcom" id="plcom" class="plcom" required="required">
					</td>
				</tr>
				<tr>
					<th><label for="plcomcode">항공사 코드</label></th>
					<td>
						<input type="text" name="plcomcode" id="plcomcode" class="plcomcode" 
									 required="required" placeholder="항공사 코드를 입력해 주세요">
					</td>
				</tr>
				<tr>
					<th><label for="plname">항공기 이름</label></th>
					<td>
						<input type="text" name="plname" id="plname" class="plname" required="required">
					</td>
				</tr>
				<tr>
					<th><label for="plseat">항공기 좌석 수</label></th>
					<td><input type="text" name="plseat" id="plseat" class="plseat" required="required"></td>
				</tr>
				<tr>
					<th><label for="actname">출발 도시</label></th>
					<td>
						<input type="text" name="actname" id="actname" class="actname" required="required">
						<div id="acityConfirmResult"> &nbsp; &nbsp; &nbsp; </div>
					</td> 
				</tr>
				<tr>
					<th><label for="dctname">도착 도시</label></th>
					<td>
						<input type="text" name="dctname" id="dctname" class="dctname" required="required">
						<div id="dcityConfirmResult"> &nbsp; &nbsp; &nbsp; </div>
					</td>
				</tr>
				<tr>
					<th><label for="atprice">가격</label></th>
					<td>
						<input type="text" name="atprice" id="atprice" class="atprice" required="required">
					</td>
				</tr>			
				<tr>
					<th>출발 시간</th>
					<td><input type="text" class="datetimepicker" name="atatime" class="attime" required="required"></td>
				</tr>
				<tr>
					<th>도착 시간</th>
					<td><input type="text" class="datetimepicker" name="atdtime" class="attime" required="required"></td>
				</tr>
				<tr>
				</tr>
				<tr>
					<td colspan="2" id="lasttd">
						<input type="submit" value="등록하기" class="joinBtn_style">
						<input type="button" value="취소" class="joinBtn_style" onclick="history.back()">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>


