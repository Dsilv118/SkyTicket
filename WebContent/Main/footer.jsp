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
		width: 100%; 
		height:200px;  
		background-color: #F1F3F5;
	}
	footer #footer_wrap {
		width: 1000px;
		margin: 0 auto;
		padding-top: 25px;
		color: #50BCDF;
		font-weight: bold;
		font-size: 0.9em;
		text-align: center;
	}
	footer #float_left {
		overflow: hidden;
		text-align: center;
		margin-bottom: 15px;
	}
	#address {
		color: gray;
		float: left;
		text-align: left;
		margin-left: 201px;
	}
	footer #icon img {
		width: 32px;
		height: 32px;
	}
	#icon img {
		cursor: pointer;
	}
	footer #footer_text {
		color: gray;
	}
</style>
</head>
<body>
	<footer>
		<div id="footer_wrap">
			<div id="float_left">
				<div id="address">
					(주)스카이티켓 <br>
					서울특별시 강서구 방화3동 999 공항타워 5층 <br>
					고객센터 9999-9999 (09:00~19:00) <br>
				</div>		
				<br>		
				<div id="icon">
					<a href="http://www.facebook.com"><img src="icon/facebook.png"></a> &nbsp; &nbsp;
					<a href="http://www.youtube.com"><img src="icon/youtube.png"></a> &nbsp; &nbsp;
					<a href="http://www.instagram.com"><img src="icon/instagram.png"></a> &nbsp; &nbsp;
				</div>
			</div>
			<br>
			<span id="footer_logo">🆂🅺🆈🆃🅸🅲🅺🅴🆃  &nbsp;</span>
			<span id="footer_text">Copyright© SkyTicket.Corp All rights reserved.</span>
		</div>
	</footer>
</body>
</html>