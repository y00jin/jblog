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
			<h1><a href="${pageContext.request.contextPath }/${blogVo.id}">${blogVo.title }</a></h1>
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
					<c:if test="${blogVo.id eq authUser.id }">
						<li><a href="${pageContext.request.contextPath }/${blogVo.id }/admin/basic">블로그 관리</a></li>
					</c:if>
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
							<a href="${pageContext.request.contextPath }/${blogVo.id }/${postvo.categoryNo }/${postvo.no }">${postvo.title }</a>
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
				<li><a href="${pageContext.request.contextPath }/${blogVo.id }">- 전체보기</a></li>
				<li> </li>
				<li> </li>
				<c:forEach items='${list }' var='catevo' varStatus='status'>
					<c:choose>
						<c:when test="${catevo.countPost == 0 }">
							<li><a href="" onclick="return noPost();">- ${catevo.name }</a></li>
							<script type="text/javascript">
								function noPost() {
									return alert("카테고리 내에 글이 존재하지 않습니다");
								}
							</script>
						</c:when>
						<c:otherwise>
							<li><a href="${pageContext.request.contextPath }/${blogVo.id }/${catevo.no }">- ${catevo.name }</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</div>
		
		<div id="footer">
			<p>
				<strong>${blogVo.title }</strong> is powered by JBlog (c)2016,2017,2018,2019,2020
			</p>
		</div>
	</div>
</body>
</html>