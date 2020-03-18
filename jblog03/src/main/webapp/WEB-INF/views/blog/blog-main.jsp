<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	pageContext.setAttribute("newLine", "\n");
%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<Link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
</head>
<body>
	<div id="container">
		<div id="header">
			<h1><a href="${pageContext.request.contextPath }/${authUser.id}">${blogVo.title }</a></h1>
			<ul>
			<c:choose>
				<c:when test="${empty authUser }">
				<li><a href="${pageContext.request.contextPath }/user/login">로그인</a></li>
				</c:when>
				<c:otherwise>
				<li><a href="${pageContext.request.contextPath }/user/logout" onclick="return logoutChk();">로그아웃</a></li>
				<script type="text/javascript">
					function logoutChk() {
						return confirm("로그아웃 하시겠습니까?");
					}
				</script>
				<li><a href="${pageContext.request.contextPath }/${blogVo.id }/admin/basic">블로그 관리</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
		<div id="wrapper">
			<div id="content">
				<div class="blog-content">
					<h4>${mainPost.title }</h4>
					<p>${fn:replace(mainPost.contents, newLine,"<br>") }<p>
				</div>
				<ul class="blog-list">
					<c:forEach items='${postList }' var='postvo' varStatus='status'>
						<li>
							<a href="${pageContext.request.contextPath }/${authUser.id }/${postvo.categoryNo }/${postvo.no }">${postvo.title }</a>
							<span>${fn:substring(postvo.regDate,0,11) }</span>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>

		<div id="extra">
			<div class="blog-logo">
				<img src="${pageContext.request.contextPath}${blogVo.logo }">
			</div>
		</div>

		<div id="navigation">
			<h2>카테고리</h2>
			<ul>
				<c:forEach items='${list }' var='catevo' varStatus='status'>
					<li><a href="${pageContext.request.contextPath }/${authUser.id }/${catevo.no }">${catevo.name }</a></li>
				</c:forEach>
			</ul>
		</div>
		
		<div id="footer">
			<p>
				<strong>Spring 이야기</strong> is powered by JBlog (c)2016
			</p>
		</div>
	</div>
</body>
</html>