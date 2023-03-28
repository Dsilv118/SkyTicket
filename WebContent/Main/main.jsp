<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath }/css/main.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
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
		    minDate: 0,
		    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		  });
		} );
   </script>
</head>
<body>
	<c:if test="${not empty next }">
		<script>
			location.href = '${conPath}/${next}';
		</script>
	</c:if>
	<c:if test="${not empty modifyResult }">
		<script>alert('${modifyResult }');</script>
	</c:if>
	<c:if test="${not empty modifyErrorMsg }">
		<script>
			alert('${modifyErrorMsg }');
			history.back();
		</script>
	</c:if>
	<c:if test="${not empty loginErrorMsg }">
		<script>
			alert('${loginErrorMsg}');
			history.back();
		</script>
	</c:if>
	<c:if test="${not empty withdrawalResult }">
		<script>	
			alert('${withdrawalResult}');
		</script>
	</c:if>
	<jsp:include page="../Main/header.jsp"/>
	<div id="#main_content">
		<div style="text-align: center;">
			<img src="img\AD.png" alt="광고 이미지" style="width: 1000px; cursor: pointer;">
		</div>
		<div id="schTicket">
			<form action="atList.do" method="post">
				<table>
					<tr>
						<td colspan="4" style="text-align: left; font-size: 1.5em; padding-left: 12px;">
							<b style="cursor: pointer;">편도<img src="icon/arrow.png" alt="화살표 이미지"></b>&nbsp; &nbsp; 
							<b style="cursor: pointer;">성인<img src="icon/arrow.png" alt="화살표 이미지"></b>
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" name="actname" id="actname" placeholder="출발 도시">
						</td>
						<td>
							<input type="text" name="dctname" id="dctname" placeholder="도착 도시">
						</td>
						<td>
							<input type="text" name="atatime" id="datepicker" placeholder="가는 날짜">
						</td>
						<td style="padding-right: 35px;">
							<input type="submit" value="검색" class="btn" >
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<div id="Main_photo">
		<table>
			<caption>추천 항공권</caption>
			<tr>
				<td>
					<img src="img/ROM.png" alt="로마 이미지"> <br><br> 
					<span class="route">서울 / 인천 → 로마</span> <br> 
					<span class="price">KRW <b class="lightpurple">1,532,400</b></span>
				</td>
				<td>
					<img src="img/BKK.png" alt="방콕 이미지"> <br><br> 
					<span class="route">서울 / 김포 → 방콕</span> <br> 
					<span class="price">KRW <b class="lightpurple">326,200</b></span>
				</td>
				<td style="height: 150px;">
					<img src="img/CEB.png" alt="세부 이미지"> <br><br> 
					<span class="route">서울 / 인천 → 세부</span> <br> 
					<span class="price">KRW <b class="lightpurple">469,800</b></span>
				</td>		
				<td>
					<img src="img/GVA.png" alt="스위스 제네바 이미지"> <br><br> 
					<span class="route">서울 / 인천 → 제네바</span> <br> 
					<span class="price">KRW <b class="lightpurple">1,149,800</b></span>
				</td>		
			</tr>
		</table>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>