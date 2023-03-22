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
	*{padding:0; margin: 0;}
	header { 
		background-color: #50BCDF; font-size: 10pt; height: 138px;
	}
	header a {text-decoration: none; font-weight: bold;}
	header li {list-style: none;}
	header .gnb{width: 100%;	background-color: #50BCDF;}
	header .gnb ul {
		overflow: hidden;
		width:800px;
		height: 30px;
		line-height: 30px;
		margin: 0 auto;
	}
	header .gnb ul li {	float: right;	margin-right: 30px;}
	header .gnb a { 
		color : #ffffff;
		font-size: 0.9em;
		display: block;
		padding-left:15px;
		padding-right:15px;
	}
	header .logo{
		width:800px; 
		text-align: center;
		margin: 8px auto;
		font-size:2em;
		cursor: pointer; 
		color: white;
		font-weight: bold;
	}
	header .lnb {
	  width: 100%; height: 30px;
		text-align: center;
	}
	header .lnb ul{
		overflow: hidden;
		width:800px;
		margin: 20px auto;
	}
	header .lnb ul>li>a {
		width: 32%;
		margin: 5px;
		float:left;
		line-height: 25px;
		cursor: pointer;
		color: white;
		font-size: 1.2em;
	}
	header .lnb li a {color: #003300;}
	header .lnb li {color: #003300;}
</style>
</head>
<body>
<header>
	<c:if test="${empty member and empty admin}"> <%-- 로그인 전 화면 --%>
		<div class="gnb">
			<ul>
				<li><a href="${conPath }/joinView.do">회원가입</a></li>
				<li><a href="${conPath }/loginView.do">로그인</a></li>
			</ul>
		</div>
		<div class="logo" onclick="location.href='${conPath}/main.do'">
			🆂🅺🆈🆃🅸🅲🅺🅴🆃
		</div>
		<div class="lnb">
			<ul>
				<li>
					<a href="${conPath }/boardList.do">항공예매</a>
				</li>
				<li>
					<a href="${conPath }/boardList.do">예약내역</a>
				</li>
				<li>
					<a href="${conPath }/boardList.do">고객센터</a>
				</li>
			</ul>
		</div>
	</c:if>
	<c:if test="${not empty member and empty admin}"> <%-- 사용자 모드 로그인 화면--%>
		<div class="gnb">
			<ul>
				<li><a href="${conPath }/logout.do">로그아웃</a></li>
				<li><a href="${conPath }/modifyView.do">정보수정</a></li>
				<li><a>${member.mname }님 &nbsp; ▶</a></li>	
			</ul>
		</div>
		<div class="logo" onclick="location.href='${conPath}/main.do'">
			스카이티켓
		</div>
		<div class="lnb">
			<ul>
				<li>
					로그인후메뉴1
				</li>
				<li>
					로그인후메뉴2
				</li>
				<li>
					로그인후메뉴3
				</li>
				<li>
					로그인후메뉴4
				</li>
			</ul>
		</div>
	</c:if>
	<c:if test="${empty member and not empty admin}"> <%-- 관리자 모드 로그인 화면--%>
		<div class="gnb">
			<ul>
				<li><a href="${conPath }/logout.do">관리자모드나가기</a></li>
				<li><a>${admin.aname }님 &nbsp; ▶</a></li>	
			</ul>
		</div>
		<div class="logo" onclick="location.href='${conPath}/allView.do'">
			LOGO
		</div>
		<div class="lnb">
			<ul>
				<li>
					관리자의메뉴1
				</li>
				<li>
					관리자의메뉴2
				</li>
				<li>
					관리자의메뉴3
				</li>
				<li>
					관리자의메뉴4
				</li>
			</ul>
		</div>
	</c:if>
</header>
</body>
</html>