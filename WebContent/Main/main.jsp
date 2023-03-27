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
	<link href="${conPath }/css/main.css" rel="stylesheet" type="text/css">
	<script src="https://code.jquery.com/jquery-3.6.4.js"></script>
</head>
<body>
	<c:if test="${not empty next }">
		<script>
			location.href = '${conPath}/${next}';
		</script>
	</c:if>
	<c:if test="${not empty modifyResult }">
		<script>alert('${modifyResult }');</script>
	</c:if>
	<c:if test="${not empty modifyErrorMsg }">
		<script>
			alert('${modifyErrorMsg }');
			history.back();
		</script>
	</c:if>
	<c:if test="${not empty loginErrorMsg }">
		<script>
			alert('${loginErrorMsg}');
			history.back();
		</script>
	</c:if>
	<c:if test="${not empty withdrawalResult }">
		<script>	
			alert('${withdrawalResult}');
		</script>
	</c:if>
	<jsp:include page="../Main/header.jsp"/>
	<div id="main_wrap">
		<div style="text-align: center;">
			<img src="img\AD.png" alt="광고 이미지" style="width: 1000px;">
		</div>
		<div id="schTicket">
			<form action="atList.do" method="post">
				<table>
					<tr>
						<td colspan="4" style="text-align: left; font-size: 1.5em; font-weight: bold;">
							편도  &nbsp; &nbsp; 성인
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" name="actname" placeholder="출발 도시">
						</td>
						<td>
							<input type="text" name="dctname" placeholder="도착 도시">
						</td>
						<td>
							<input type="text" name="atatime" placeholder="가는 날짜">
						</td>
						<td style="text-align: left;">
							<input type="submit" value="검색" class="btn" >
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>