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
	footer {
		width: 1000px; 
		height:100px; 
		margin: 250px auto 0; 
		background-color: #FFFFFF;
	}
	footer #footer_conts, footer #footer_conts{
		color: #50BCDF;
		font-weight: bold;
		font-size: 0.9em;
		text-align: center;
	}
	footer #footer_conts p:first-child {
		font-weight: bold; height: 30px; line-height: 30px;
	}
	footer #footer_text {
		color: #000000;
		font-size: 0.8em;
	}
</style>
</head>
<body>
	<footer>
		<div id="footer_conts">
			<span id="footer_logo">🆂🅺🆈🆃🅸🅲🅺🅴🆃  &nbsp;</span>
			<span id="footer_text">Copyright© SkyTicket.Corp All rights reserved.</span>
		</div>
	</footer>
</body>
</html>