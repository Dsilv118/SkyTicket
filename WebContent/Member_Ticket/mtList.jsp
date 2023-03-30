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
	<link href="${conPath }/css/mtList.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
	<script>
		$(document).ready(function(){
			$('tr').click(function(){
				var rvnum = $(this).children().eq(0).text().trim();
				if(! isNaN(Number(rvnum))) {
					location.href = '${conPath }/mtContent.do?rvnum='+rvnum+'&pageNum=${pageNum}';
				}
			});
		});
	</script>
</head>
<body>
	<c:if test="${not empty deleteResult }">
		<script>alert("${deleteResult }");</script>
	</c:if>
	<jsp:include page="../Main/header.jsp"/>
	<div id="mtList_form">
		<table>
			<caption>
				${member.mkname }님의 예약 내역
			</caption>
			<tr>
				<td>예약번호</td><td>편명</td><td>출발날짜</td><td>도착날짜</td>
			</tr>
			<c:if test="${list.size() eq 0 }">
				<tr><td colspan="6">예약 내역이 없습니다</td></tr>
			</c:if>
			<c:if test="${list.size() != 0 }">
				<c:forEach var="dto" items="${list }">
					<tr>
						<td>${dto.rvnum }</td>
						<td>
							${dto.atid }
						</td>
						<td>
							<fmt:formatDate value="${dto.atatime }" pattern="yy-MM-dd(E) HH:mm"/><br>
						</td>						
						<td>
							<fmt:formatDate value="${dto.atdtime }" pattern="yy-MM-dd(E) HH:mm"/><br>
						</td>					
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<div class="paging">
			<c:if test="${startPage > BLOCKSIZE }">
				{<a href="${conPath }/mtList.do?pageNum=${startPage-1}&mid=${member.mid }">이전</a>}
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<c:if test="${i eq pageNum }">
					[<b>${i }</b>]
				</c:if>
				<c:if test="${i != pageNum }">
					[<a href="${conPath }/mtList.do?pageNum=${i}&mid=${member.mid }">${i }</a>]
				</c:if>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				{<a href="${conPath }/mtList.do?pageNum=${endPage+1}&mid=${member.mid }">다음</a>}
			</c:if>
		</div>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>
