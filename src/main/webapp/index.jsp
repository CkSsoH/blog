<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Index</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<div class ="container p-3 my-3 bg-dark text-white"> <!-- 상단타이틀 -->
			<h1> home </h1>
		</div>
		<table class="table table-hover">
			<tr>
				<td class="table-success"><a href="<%=request.getContextPath()%>/board/boardList.jsp">게시판</a></td>
			</tr>
			<tr>
				<td class="table-danger"><a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp">방명록</a></td>
			</tr>
			<tr>
				<td class="table-success"><a href="<%=request.getContextPath()%>/photo/photoList.jsp">사진</a></td>
			</tr>
		</table>
	</div>
</body>
</html>