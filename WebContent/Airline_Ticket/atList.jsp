<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath }/css/atList.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
	<script>
		$(document).ready(function(){
			$('tr').click(function(){
				var atid = $(this).children().eq(0).text().trim().substring();
				var soldout = $(this).children().eq(4).text().trim();
				if(soldout == '예약 매진' && ${empty admin}) {
					alert('예약 매진되었습니다');
				} else if(${empty member} && ${empty admin}) {
					alert('로그인 후 이용 가능합니다');
					location.href="loginView.do";
				} else if(${not empty admin}){
					if(confirm(atid + ' 편명의 항공권을 삭제하시겠습니까?')) {
						location.href = '${conPath }/atDelete.do?atid='+atid;
					}
					return;
				} else if(${not empty member}) {
					if(confirm(atid + ' 편명의 항공권을 예매하시겠습니까?')) {
						location.href = '${conPath }/mtReserveView.do?atid='+atid;
					}
					return;
				}
			});
		});
	</script>
</head>
<body>
	<c:set var="SUCCESS" value="1"/>
	<c:set var="FAIL" value="0"/>
	<c:if test="${rightView != 1 }">
		<script>
			alert('정상적인 접근이 아닙니다');
		</script>
	</c:if>
	<jsp:include page="../Main/header.jsp"/>
	<div id="atlist_form">
		<table>
			<caption>
				<img src="icon/takeoff.png">
				<c:if test="${not empty schActname and not empty schDctname }">
					${schActname } <img src="icon/rightarrow.png"> ${schDctname }
				</c:if>
			</caption>
			<tr>
				<td>편명</td><td>출발</td><td></td><td>도착</td><td>정상운임</td>
			</tr>
			<c:if test="${list.size() eq 0 }">
				<tr><td colspan="6">-</td></tr>
			</c:if>
			<c:if test="${list.size() != 0 }">
				<c:forEach var="dto" items="${list }">
					<tr>
						<td>
							${dto.atid } <br>
						</td>
						<td>
							<span style="font-size: 1.3em;">
								<fmt:formatDate value="${dto.atatime }" pattern="yy-MM-dd(E) HH:mm"/><br>
							</span>
							${dto.actname }(${dto.actcode })
						</td>
						<td>
							<img src="icon/rightarrow2.png"> <br>
							<span style="font-size: 13px; font-weight: bold; color: #742351;">${dto.plcom }</span>
						</td>
						<td>
							<span style="font-size: 1.3em;">
								<fmt:formatDate value="${dto.atdtime }" pattern="yy-MM-dd(E) HH:mm"/><br>
							</span>
							${dto.dctname }(${dto.dctcode })
						</td>						
						<td>
							<c:if test="${dto.plseat > 5}">
								<span style="font-size: 1.1em; color: #212529;">KRW</span>
								<b style="font-size: 1.2em; color: #50BCDF;">
									<fmt:formatNumber value="${dto.atprice }" pattern="##,###,###"/>
								</b>
								<b>&nbsp; </b>
							</c:if>
							<c:if test="${dto.plseat <= 5 and dto.plseat > 0}">
								<span style="font-size: 1.1em;">KRW</span>
								<b style="font-size: 1.2em; color: #50BCDF;">
									<fmt:formatNumber value="${dto.atprice }" pattern="##,###,###"/>
								</b><br>
								<b style="font-size: 0.9em; color: #742351;">잔여 ${dto.plseat }석!</b>
							</c:if>
							<c:if test="${dto.plseat eq 0}">
								<b style="font-size: 1.2em; color: #742351;">예약 매진</b>
							</c:if>
						</td>					
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<div class="paging">
			<c:if test="${startPage > BLOCKSIZE }">
				{<a href="${conPath }/atList.do?pageNum=${startPage-1}&schActname=${schActname }&schDctname=${schDctname }&schAtatime=${schAtatime }">이전</a>}
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<c:if test="${i eq pageNum }">
					[<b class="blue">${i }</b>]
				</c:if>
				<c:if test="${i != pageNum }">
					[<a href="${conPath }/atList.do?pageNum=${i}&schActname=${schActname }&schDctname=${schDctname }&schAtatime=${schAtatime }">${i }</a>]
				</c:if>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				{<a href="${conPath }/atList.do?pageNum=${endPage+1}&schActname=${schActname }&schDctname=${schDctname }&schAtatime=${schAtatime }">다음</a>}
			</c:if>
		</div>
		<div id="caution">
			<ul>
				<li>
					예약과 동시에 항공권을 구매하셔야 합니다. (예약만 불가)
				</li>
				<li>
					해당일에 운항편이 없거나 만석인 경우, 공란("-")으로 표시됩니다.
				</li>
				<li>
					유류할증료와 세금/제반요금은 구매일/환율에 따라 변경될 수 있습니다.
				</li>
				<li>
					항공 운임은 출발지 국가/지역의 통화를 기준으로 책정되며, 결제 시 해당 환율이 적용됩니다.
				</li>
				<li>
					상기 스케줄은 정부인가(해외 정부 포함) 조건으로, 부득이한 사유로 예고 없이 변경될 수 있습니다.
				</li>
			</ul>
		</div>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>




















