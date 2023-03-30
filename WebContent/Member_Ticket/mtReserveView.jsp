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
	<link href="${conPath }/css/mtReserveView.css" rel="stylesheet">
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
		<form action="${conPath }/mtReserve.do" method="post">
			<input type="hidden" name="mid" value="${member.mid }">
			<input type="hidden" name="atid" value="${atid }">
			<div id="reserveview_title" class="left">
				<img src="icon/mtplane2.png" alt="비행기 아이콘" style="width: 42px; height: 42px;">
				여정
				<span class="lightgray">itinerary</span>
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
						<span class="blue">${TicketContent.actcode }</span> <br>
						${TicketContent.actname } <br>
						<span class="bold">
							<fmt:formatDate value="${TicketContent.atatime}" pattern="yy-MM-dd(E) HH:mm"/> <br>
						</span>
						&nbsp
					</td>
					<td style="width: 140px; text-align: center;">
						<img src="icon/mtplane.png" alt="비행기 아이콘">
					</td>
					<td>
						<span class="blue">${TicketContent.dctcode }</span> <br>
						${TicketContent.dctname } <br>
						<span class="bold">
							<fmt:formatDate value="${TicketContent.atdtime}" pattern="yy-MM-dd(E) HH:mm"/> <br>
						</span>
						&nbsp
					</td>					
					<td>
						<span class="blue">${TicketContent.atid }</span> <br>
						Operated by ${TicketContent.plcomcode } <br>
						<span class="bold">${TicketContent.plcom }</span> <br>
						${TicketContent.plname }
					</td>
				</tr>
				<tr>
					<th><label for="plname">탑승 인원</label></th>
					<td colspan="4">
						<input type="number" name="mtseat" id="mtseat">
					</td>
				</tr>
				<tr>
					<th><label for="plseat">요청 사항</label></th>
					<td colspan="4">
						<input type="text" name="mtservice" id="mtservice" placeholder="요청 사항을 기입해주세요 ex)이유식, 특별식">
					</td>
				</tr>
				<tr>
					<td colspan="4" id="lasttd">
						<input type="submit" value="예매하기" class="reserveBtn_style">
						<input type="button" value="취소" class="reserveBtn_style" onclick="history.back()">
					</td>
				</tr>
			</table>
			<div id="caution">
				<ul>
					<li>
						스케쥴 및 기종은 부득이한 사유로 사전 예고없이 변경될 수 있습니다.
					</li>
					<li>
						할인 또는 무임 항공권의 경우 예약 등급에 따라 마일리지 적립률이 상이하거나 마일리지가 제공되지 않습니다.
					</li>
				</ul>
			</div>
		</form>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>