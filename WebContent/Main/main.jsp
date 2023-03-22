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
	<div id="schTicket">
		<form action="atList.do" method="post">
			<table>
				<tr>
					<td>하이</td><td>하이</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../Main/footer.jsp"/>
</body>
</html>