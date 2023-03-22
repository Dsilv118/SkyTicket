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
<style>
	body { background-color: #ffffff; }
	footer {width: 800px; height:60px; margin: 0 auto; background-color: #ffffff;}
	footer #footer_conts, footer #footer_conts a {
		color: #000000;
		font-weight: blod;
		font-size:0.9em;
		text-align: center;
	}
	footer #footer_conts p:first-child {
		font-weight: bold; height: 30px; line-height: 30px;
	}
</style>
</head>
<body>
	<footer>
		<div id="footer_conts">
			<p>(주)스카이티켓</p> 
			<p>서울특별시 강서구 방화동 9 공항빌딩 1-5F</p>
			<p>Copyright© 2023 tj . All rights reserved.</p>
		</div>
	</footer>
</body>
</html>