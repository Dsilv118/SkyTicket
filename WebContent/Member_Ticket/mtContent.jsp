<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath }/css/mtContent.css" rel="stylesheet">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script>
  	$(function(){
  		// submit 조건
  		$('form').submit(function(){
  	  		var mtseat 		= $('#mtseat').val().trim();
  	  		var mtservice = $('#mtservice').val().trim();
  	  		var plseat    = ${TicketContent.plseat };
  	  		if(mtseat > plseat){
  	  			alert('현재 남은 좌석수보다 초과해서 예매하셨습니다. 남은 좌석 수 : ' + plseat);
  	  			$('#mtseat').focus();
  	  			return false;
  	  		} else if(mtservice.length > 30){
  	  			alert('요청사항은 30자 이내로 입력해주세요');
  	  			$('#mtservice').focus();
  	  			return false;
  	  		}
  		});  		
  	});
  </script>
</head>
<body>
	<jsp:include page="../Main/header.jsp"/>
	<div id="reserveviewForm_wrap">
		<form action="${conPath }/mtDelete.do?pageNum=${param.pageNum }" method="post">
			<input type="hidden" name="atid" value="${ATicketContent.atid }">
			<input type="hidden" name="rvnum" value="${ATicketContent.rvnum }">
			<input type="hidden" name="mtseat" value="${ATicketContent.mtseat }">
			<input type="hidden" name="mid" value="${ATicketContent.mid }">
			<div id="reserveview_title" class="left">
				<img src="icon/Ticket.png" alt="비행기 아이콘" style="width: 42px; height: 42px;">
				e-티켓 확인증
				<span class="lightgray">e-Ticket itinerary</span>
			</div>
			<table>
				<tr>
					<th><label for="actname">출발 <span class="lightgray">Departure</span></label></th>
					<th style="width: 140px;"></th>
					<th><label for="plname">도착 <span class="lightgray">Arrival</span></label></th>
					<th><label for="plcom">편명 <span class="lightgray">Flight</span></label></th>
				</tr>
				<tr>
					<td>
						<span class="blue">${ATicketContent.actcode }</span> <br>
						${ATicketContent.actname } <br>
						<span class="bold">
							<fmt:formatDate value="${ATicketContent.atatime}" pattern="yy-MM-dd(E) HH:mm"/> <br>
						</span>
						&nbsp
					</td>
					<td style="width: 140px; text-align: center;">
						<img src="icon/mtplane.png" alt="비행기 아이콘">
					</td>
					<td>
						<span class="blue">${ATicketContent.dctcode }</span> <br>
						${ATicketContent.dctname } <br>
						<span class="bold">
							<fmt:formatDate value="${ATicketContent.atdtime}" pattern="yy-MM-dd(E) HH:mm"/> <br>
						</span>
						&nbsp
					</td>					
					<td>
						<span class="blue">${ATicketContent.atid }</span> <br>
						Operated by ${ATicketContent.plcomcode } <br>
						<span class="bold">${ATicketContent.plcom }</span> <br>
						${ATicketContent.plname }
					</td>
				</tr>
				<tr>
					<th><label for="mkname">탑승자 이름</label></th>
					<td colspan="4">
						${ATicketContent.mkname }
					</td>					
				</tr>
				<tr>
					<th><label for="plname">탑승 인원</label></th>
					<td colspan="4">
						${ATicketContent.mtseat }
					</td>
				</tr>
				<tr>
					<th><label for="plseat">요청 사항</label></th>
					<td colspan="4">
						${ATicketContent.mtservice }
					</td>
				</tr>
				<tr>
					<td colspan="4" id="lasttd">
						<input type="submit" value="예약취소" class="reserveBtn_style">
						<input type="button" value="뒤로가기" class="reserveBtn_style" onclick="history.back()">
					</td>
				</tr>
			</table>
			<div id="caution">
				<ul>
					<li>
						e-Ticket 확인증은 탑승수속/입출국/세관 통과시 요구될 수 있으므로 전 여행기간동안 반드시 소지하시기 바랍니다.
					</li>
					<li>
						e-Ticket 확인증의 이름과 여권상의 이름은 반드시 일치해야 합니다.
					</li>
					<li>
						e-Ticket 확인증을 위/변조시 법적 책임이 따를 수 있습니다.
					</li>
				</ul>
			</div>
		</form>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>