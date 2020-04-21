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
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/ejs/ejs.js"></script>
<script>
var listItemTemplate = new EJS({
	url: "${pageContext.request.contextPath }/assets/js/ejs/list-item-template.ejs"
});

var listTemplate = new EJS({
	url: "${pageContext.request.contextPath }/assets/js/ejs/list-template.ejs"
});

var messageBox = function(title, message, callback) {
	$("#dialog-message p").text(message);
	$("#dialog-message")
		.attr("title",title)
		.dialog({
			modal: true,
		    buttons: {
		    	Ok: function() {
		          $(this).dialog("close");
		        }
		    },
		    close: callback
		});
}

var fetchList = function() {
	$.ajax({
		url: '${pageContext.request.contextPath }/${authUser.id }/admin/category/list',
		async: true,
		type: 'get',
		dataType: 'json',
		data: '',
		success: function(response){
			console.log(response);
			if(response.result != "success") {
				console.error(response.message);
				return;
			}		
			var imgUrl = '${pageContext.request.contextPath }/assets/images/delete.jpg';
			var noDelete = '삭제불가';
			
			response.data.url = imgUrl;
			response.data.noDelete = noDelete;
			
			var html = listTemplate.render(response);
			$(".admin-cat").append(html);
		},
		error: function(xhr, status, e) {
			console.error(status + ":" + e);
		}
	});
}

$(function() {
	var dialogDelete = $("#dialog-delete").dialog({
		autoOpen: false,
		resizable: false,
		height: "auto",
		width: 400,
		modal: true,
		buttons: {
			"삭제": function() {
				var no = $("#hidden-no").val();
				$.ajax({
					url: '${pageContext.request.contextPath }/${authUser.id }/admin/category/delete/' + no,
					async: true,
					type: 'delete',
					dataType: 'json',
					data: '',
					success: function(response){
						$(".admin-cat tr td").remove();
						dialogDelete.dialog('close');
						fetchList();
					},
					error: function(xhr, status, e) {
						console.error(status + ":" + e);
					}
				});
			},
			"취소": function() {
				$(this).dialog("close");
			}
		},
		close: function() {
			$("#hidden-no").val('');
			$('#dialog-delete-form p.validateTips.error').hide();
		}
	});
	
	$("#insert-category").submit(function(event){
		event.preventDefault();
		
		var vo = {};
		vo.name = $("#category-name").val();
		if(vo.name == '') {
			messageBox('카테고리 추가', '카테고리 이름은 필수 항목입니다.', function() {
				$("#category-name").focus();
			});
			return;
		}
		vo.description = $("#category-description").val();
		
		$.ajax({
			url: '${pageContext.request.contextPath }/${authUser.id }/admin/category',
			async: true,
			type: 'post',
			dataType: 'json',
			contentType: 'application/json',
			data: JSON.stringify(vo),
			success: function(response){
				if(response.result != "success") {
					console.error(response.message);
					return;
				}		
				
				// rendering			
				var imgUrl = '${pageContext.request.contextPath }/assets/images/delete.jpg';
				var deleteLink = '';
				
				response.data.url = imgUrl;
				response.data.deleteLink = deleteLink;
				var html = listItemTemplate.render(response.data);
				$(".admin-cat tr td").remove();
				fetchList();
				
				// form reset
				$("#insert-category")[0].reset();
			},
			error: function(xhr, status, e) {
				console.error(status + ":" + e);
			}
		});
		
	});
	
	$(document).on('click', '.admin-cat tr td a', function(event) {
		event.preventDefault();
		console.log('******this:' + $(this).href);
		var no = $(this).data('no');
		$('#hidden-no').val(no);
		console.log("++++click : " + no);
		dialogDelete.dialog("open");
	});
	
	// 처음 리스트 가져오기
	fetchList();
	console.log("table tr 갯수 : " + $(".admin-cat tr").length);
});
</script>
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
					<tr id="plus">
						<th>번호</th>
						<th>카테고리명</th>
						<th>포스트 수</th>
						<th>설명</th>
						<th>삭제</th>      			
					</tr>
				</table>
      			<h4 class="n-c">새로운 카테고리 추가</h4>
      			<form id="insert-category" method="post">
			      	<table id="admin-cat-add">
			      		<tr>
			      			<td class="t">카테고리명</td>
			      			<td><input type="text" id="category-name" name="name"></td>
			      		</tr>
			      		<tr>
			      			<td class="t">설명</td>
			      			<td><input type="text" id="category-description" name="description"></td>
			      		</tr>
			      		<tr>
			      			<td class="s">&nbsp;</td>
			      			<td><input type="submit" value="카테고리 추가"></td>
			      		</tr>      		      		
			      	</table> 
      			</form>
			</div>
		</div>
		<div id="dialog-delete" title="카테고리 삭제" style="display: none">
			<p>
				<span class="ui-icon ui-icon-alert"
					style="float: left; margin: 12px 12px 20px 0;"></span>
					해당 카테고리를 삭제하시겠습니까?
			</p>
			<form>
					<input type="hidden" id="hidden-no" value="">
					<input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
  			</form>
		</div>
		<div id="footer">
			<p>
				<strong>${blogVo.title }</strong> is powered by JBlog (c)2016,2017,2018,2019,2020
			</p>
		</div>
	</div>
</body>
</html>