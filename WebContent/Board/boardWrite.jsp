<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="${conPath }/css/boardWrite.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
		$(function(){
			$('form').submit(function(){
				var bsubject = $('#bsubject').val().trim();
				if(bsubject.length > 15) {
					alert('제목은 15글자 이하로 입력해주세요');
					return false;
				}
			});
		});
	</script>
</head>
<body>
	<jsp:include page="../Main/header.jsp"/>
	<div id="boardwrite_form">
		<form action="boardWrite.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="mid" value="${member.mid }">
			<input type="hidden" name="mkname" value="${member.mkname }">
			<table>
				<caption>
					1:1 문의하기
				</caption>
				<tr>
					<td>
						<input type="text" name="bsubject" id="bsubject"
									 required="required" placeholder="15글자 이하로 제목을 입력해주세요" 
									 autofocus="autofocus">
					</td>
				</tr>
				<tr>
					<td>
						<textarea rows="5" cols="50" name="bcontent" 
											placeholder="문의하실 내용을 입력해주세요 &#13;&#10;파일을 첨부해주시면 더 자세한 답변을 받으실 수 있습니다"
						></textarea>
					</td>
				</tr>
				<tr>
					<td>
						<input type="file" name="bfile">
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="글쓰기" class="btn">
						<input type="button" value="취소" class="btn" onclick="history.back()">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>