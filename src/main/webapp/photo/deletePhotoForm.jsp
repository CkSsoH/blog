<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.PhotoDao"%>
<%@ page import="vo.*" %>
<%
	// 번호, 비밀번호 받아오기
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoPw = request.getParameter("photoPw");

	// 디버깅
	System.out.println(photoNo + "<--deletePhotoForm photoNo");
	System.out.println(photoPw + "<--deletePhotoForm photoPw");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deletePhotoForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container bg-dark">
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<div class="container"><!-- 화면(고정너비 컨텐츠 사용할거임) -->
			<div class ="container p-3 my-3 bg-dark text-white"> <!-- 상단타이틀 -->
				<h1> 이미지 삭제 </h1>
			</div>
			<form method="post" action="<%=request.getContextPath()%>/photo/deletePhotoAction.jsp">
				<table class="table table-hover">
					<tr>
						<td class="table-success">번호</td>
						<td class="table-danger"><input class="text-center" type="text" name="photoNo" value="<%=photoNo%>" readonly="readonly"></td>
						<td class="table-success">비밀번호</td>
						<td class="table-danger"><input type="password" name="photoPw" value="photoPw"></td>
					</tr>
					<tr>
						<td colspan="4">
							<button type="submit" class="btn btn-danger float-right">삭제</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>