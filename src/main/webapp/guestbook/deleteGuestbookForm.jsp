<%@page import="vo.Guestbook"%>
<%@page import="dao.GuestbookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 삭제할 번호 받아오기
	int guestbookNo= Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookPw = request.getParameter("guestbookPw");
	

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deleteGuestbookForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
			<h1 class="text-info">삭제할 방명록</h1>
		<form method="post" action="<%=request.getContextPath()%>/guestbook/deleteGuestbookAction.jsp">
			<table class="table table-hover">
				<tr>
					<td class="table-success">번호</td>
					<td class="table-danger" ><input type="text" name="guestbookNo" value="<%=guestbookNo%>" readonly="readonly"></td>
					<td class="table-success">비밀번호</td>
					<td class="table-danger" ><input type="password" name="guestbookPw" ></td>
				</tr>
				<tr>
					<td colspan="4"><button type="submit" class="btn btn-danger">삭제</button></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>