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
	페이지를 찾을 수 없습니다.
	
	유효하지 않은 요청입니다.
	접근하고자하는 블로그 아이디가 존재하지 않습니다.
	블로그 아이디를 확인 후 다시 접근하시기 바랍니다.
	
	<a href="${pageContext.request.contextPath }">JBLOG HOME</a>
</body>
</html>