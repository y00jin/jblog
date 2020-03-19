<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
				<li><a href="">블로그 관리</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
		<div id="wrapper">
			<div id="content" class="full-screen">
				<ul class="admin-menu">
					<li class="selected"><a href="${pageContext.request.contextPath }/${authUser.id }/admin/basic">기본설정</a></li>
					<li><a href="${pageContext.request.contextPath }/${authUser.id }/admin/category">카테고리</a></li>
					<li><a href="${pageContext.request.contextPath }/${authUser.id }/admin/write">글작성</a></li>
				</ul>
		      	<table class="admin-cat">
		      		<tr>
		      			<th>번호</th>
		      			<th>카테고리명</th>
		      			<th>포스트 수</th>
		      			<th>설명</th>
		      			<th>삭제</th>      			
		      		</tr>
					<c:set var='count' value='${fn:length(list) }'/>
					<c:forEach items='${list }' var='catevo' varStatus='status'>
						<tr>
							<td>${count - status.index }</td>
							<td>${catevo.name }</td>
							<td>${catevo.countPost }</td>
							<td>${catevo.description }</td>
							<td>
							<c:choose>
								<c:when test="${catevo.countPost == 0 }">
									<a href="${pageContext.request.contextPath }/${authUser.id }/admin/category/delete/${catevo.no}">
									<img src="${pageContext.request.contextPath}/assets/images/delete.jpg"></a>
								</c:when>
								<c:otherwise>
									삭제 불가
								</c:otherwise>
							</c:choose>
							</td>
						</tr>				  
					</c:forEach>
				</table>
      	
      			<h4 class="n-c">새로운 카테고리 추가</h4>
      			<form action = "${pageContext.request.contextPath }/${authUser.id }/admin/category" method="post">
			      	<table id="admin-cat-add">
			      		<tr>
			      			<td class="t">카테고리명</td>
			      			<td><input type="text" name="name"></td>
			      		</tr>
			      		<tr>
			      			<td class="t">설명</td>
			      			<td><input type="text" name="description"></td>
			      		</tr>
			      		<tr>
			      			<td class="s">&nbsp;</td>
			      			<td><input type="submit" value="카테고리 추가"></td>
			      		</tr>      		      		
			      	</table> 
      			</form>
			</div>
		</div>
		<div id="footer">
			<p>
				<strong>Spring 이야기</strong> is powered by JBlog (c)2016
			</p>
		</div>
	</div>
</body>
</html>