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
	<link href="${conPath }/css/boardContent.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="../Main/header.jsp"/>
	<div id="boardContent_form">
		<table>
			<caption>1:1 문의하기</caption>
			<tr><td>${BoardContent.bsubject }</td></tr>
		</table>
		<table>
			<tr>
				<td>
					<c:if test="${0 eq BoardContent.bindent }">
						${BoardContent.mkname }님 &nbsp;<span class="light">I</span>&nbsp; ${BoardContent.brdate }
					</c:if>
					<c:if test="${0 != BoardContent.bindent }">
						관리자 &nbsp;<span class="light">I</span>&nbsp; ${BoardContent.brdate }
					</c:if>
				</td>
			</tr>
			<tr><td>${BoardContent.bcontent }</td></tr>
			<c:if test="${!empty admin }">
				<tr>
					<td colspan="2" style="font-size:0.8em; text-align: left; padding: 150px 0 0 110px;">
						<c:if test="${0 eq BoardContent.bindent }">
							첨부파일 &nbsp;<span class="light">I</span>&nbsp; 
							<c:if test="${BoardContent.bfile eq null }">
								-
							</c:if>
							<c:if test="${BoardContent.bfile != null }">
								<a href="${conPath }/BoardFile/${BoardContent.bfile }">${BoardContent.bfile }</a>
							</c:if>
						</c:if>
						<c:if test="${0 != BoardContent.bindent }">
							
						</c:if>
					</td>
				</tr>
			</c:if>
			<tr>
				<td colspan="2">
					<c:if test="${not empty admin }">
						<c:if test="${0 eq BoardContent.bindent }">
							<button class="btn" onclick="location.href='boardReplyView.do?bid=${param.bid }&pageNum=${param.pageNum }'">답변</button>
						</c:if>
						<button class="btn" onclick="location.href='boardDelete.do?bid=${param.bid }&pageNum=${param.pageNum }'">삭제</button>	
					</c:if>
					<button class="btn" onclick="location.href='boardList.do?pageNum=${param.pageNum }'">목록</button>
				</td>
			</tr>
		</table>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>