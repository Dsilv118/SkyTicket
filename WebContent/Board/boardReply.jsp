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
	<link href="${conPath }/css/boardReply.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="../Main/header.jsp"/>
	<div id="boardReply_Form">
		<form action="${conPath }/boardReply.do" method="post">
			<input type="hidden" name="pageNum" value="${param.pageNum }">
			<input type="hidden" name="bid" value="${BoardReply.bid }"> 
			<input type="hidden" name="mid" value="${BoardReply.mid }"> <!-- 원글 -->
			<input type="hidden" name="bgroup" value="${BoardReply.bgroup }"> <!-- 원글 -->
			<input type="hidden" name="bstep" value="${BoardReply.bstep }"> <!-- 원글 -->
			<input type="hidden" name="bindent" value="${BoardReply.bindent }" > <!-- 원글 -->  
			<table>
				<caption>
					1:1 문의하기
				</caption>
				<tr>
					<td>
						<input type="text" name="bsubject" id="bsubject"
									 required="required" value="${BoardReply.bid }번의 답변입니다"
									 readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>
						<textarea rows="5" cols="50" name="bcontent" 
											placeholder="답변 내용을 입력해주세요"
						></textarea>
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="답변글쓰기" class="btn">
						<input type="reset" value="취소" class="btn" onclick="history.back()">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>