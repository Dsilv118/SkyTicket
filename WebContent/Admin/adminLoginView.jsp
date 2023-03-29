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
	<link href="${conPath }/css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="../Main/header.jsp"/>
	<div id="login_form">
		<form action="adminLogin.do" method="post">
			<table>
				<caption>관리자 로그인</caption>
				<tr>
					<td>
						<input type="text" name="adid" id="adid" required="required" autofocus="autofocus" value="${mid }" placeholder="아이디">
					</td>
				</tr>
				<tr>
					<td>
						<input type="password" name="adpw" id="adpw" required="required" placeholder="비밀번호">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="로그인" class="btn">
					</td>
				</tr>
			</table>
			<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<a href="loginView.do">일반회원 로그인</a></p>
		</form>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>