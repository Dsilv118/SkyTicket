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
	<link href="${conPath }/css/boardList.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
	<script>
		$(document).ready(function(){
			$('tr').click(function(){
				var bid = $(this).children().eq(0).text().trim();
				if(! isNaN(Number(bid))) {
					location.href = '${conPath }/boardContent.do?bid='+bid+'&pageNum=${pageNum}';
				}
			});
		});
	</script>
</head>
<body>
	<c:set var="SUCCESS" value="1"/>
	<c:set var="FAIL" value="0"/>
	<c:if test="${writeResult eq SUCCESS }">
		<script>alert('글쓰기 성공');</script>
	</c:if>
	<c:if test="${writeResult eq FAIL }">
		<script>alert('글쓰기 실패');</script>
	</c:if>
	<c:if test="${not empty deleteResult }">
		<script>alert('${deleteResult }');</script>
	</c:if>
	<c:if test="${replyResult eq SUCCESS }">
		<script>alert('${param.bid }번 답변글 작성 성공');</script>
	</c:if>
	<c:if test="${replyResult eq FAIL }">
		<script>alert('답변글 작성 실패');</script>
		history.back();
	</c:if>
	<jsp:include page="../Main/header.jsp"/>
	<div id="board_form">
		<table>
			<caption>
				1:1 문의하기
			</caption>
			<tr>
				<td>번호</td><td>제목</td><td>작성자</td><td>작성일</td>
			</tr>
			<c:if test="${list.size() eq 0 }">
				<tr><td colspan="6">해당 목록의 글이 없습니다</td></tr>
			</c:if>
			<c:if test="${list.size() != 0 }">
				<c:forEach var="dto" items="${list }">
					<tr>
						<td>${dto.bid }</td>
						<td class="left">
							<c:forEach var="i" begin="1" end="${dto.bindent }">
								<c:if test="${i != dto.bindent }">
									&nbsp; &nbsp; 
								</c:if>
								<c:if test="${i eq dto.bindent }">
									└─
								</c:if>
							</c:forEach> <!-- 답글 들여쓰기 처리 -->
							<%-- <a href="${conPath }/contentView.do?bid=${dto.bid}&pageNum=${pageNum}"> --%>${dto.bsubject }<!-- </a> -->
						</td>
						<td>
							<c:if test="${0 != dto.bindent }">
						 		관리자
							</c:if>
							<c:if test="${0 eq dto.bindent }">
								${dto.mkname }
							</c:if>
						</td>						
						<td>
							<fmt:formatDate value="${dto.brdate }" pattern="yy/MM/dd(E)"/>
						</td>					
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<c:if test="${not empty member}">
			<form action="boardListMs.do" method="post">
				<input type="hidden" name="mid" value="${member.mid }">
				<div class="writebtn">
					<input type="submit" class="btn" value="내 문의글 보기"
							   style="background-color: transparent;  border: 0px transparent solid; color: black; text-decoration: underline;">
					<input type="button" class="btn" value="글쓰기" onclick="location.href='${conPath }/boardWriteView.do'">
				</div>
			</form>
		</c:if>
		<div class="paging">
			<c:if test="${startPage > BLOCKSIZE }">
				{<a href="${conPath }/boardList.do?pageNum=${startPage-1}">이전</a>}
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<c:if test="${i eq pageNum }">
					[<b>${i }</b>]
				</c:if>
				<c:if test="${i != pageNum }">
					[<a href="${conPath }/boardList.do?pageNum=${i}">${i }</a>]
				</c:if>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				{<a href="${conPath }/boardList.do?pageNum=${endPage+1}">다음</a>}
			</c:if>
		</div>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>




















