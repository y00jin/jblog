<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	pageContext.setAttribute("newLine", "\n");
%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

#error_content {
	margin: 0;
	padding: 0;
}

#error_content * {
	margin: 0;
	padding: 0;
	color: #444;
	list-style: none;
	font-size: 12px;
	line-height: normal;
	font-family: 돋움, Dotum, 굴림, Gulim, Helvetica, Sans-serif;
}

#error_content img {
	border: none;
}

#error_content a {
	text-decoration: none;
	color: #444;
}

#error_content a:visited {
	text-decoration: none;
	color: #666;
}

#error_content a:hover {
	text-decoration: underline;
}

#error_content {
	width: 350px;
	_width /**/: 510px;
	height: 220px;
	_height: 208px;
	margin: 0 auto;
	margin-top: 80px;
	padding: 0 0 0 300px;
	border: 1px solid #e5e5e5;
	background: #FFF
		url(/jblog03/assets/images/errorEong.jpg) no-repeat;
	text-align: left;
}

#error_content h2 {
	margin: 48px 0 14px 0;
	padding: 0;
}

#error_content p {
	margin: 0;
	padding: 0;
	color: #888;
	font: 12px/1.5em 돋움, Dotum, Helvetica, sans-serif;
}

#error_content p.btn {
	padding: 15px 0 0 1px;
	font-size: 0;
}

#error_content p.btn a {
	color:#1555d9; font-weight:bold; text-decoration:none;
}
</style>
</head>
<body>
	<div id="error_content">
		<h2>"페이지를 찾을 수 없습니다"</h2>
		<div class="content">
			<p> 유효하지 않은 요청입니다.<br /> 접근하고자하는 블로그 아이디가 존재하지 않습니다.<br /> 
			블로그 아이디를 확인 후 다시 접근하시기 바랍니다.
			</p>
		</div>
		<p class="btn">
			<a href="${pageContext.request.contextPath }">JBLOG HOME</a>
		</p>
	</div>
</body>
</html>