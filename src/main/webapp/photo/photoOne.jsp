<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.PhotoDao"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%
	PhotoDao photoDao = new PhotoDao(); //메소드생성
	
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	
	Photo photo = photoDao.selectPhotoOne(photoNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container"><!-- 화면(고정너비 컨텐츠 사용할거임) -->
		<!-- 메인 메뉴 시작-->
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
		<!-- 메인 메뉴 끝 -->
		<div class ="container p-3 my-3 bg-dark text-white"> <!-- 상단타이틀 -->
			<h1>이미지 목록</h1>
		</div>
		<table class="table table-hover">
			<tr>
				<td class="table-success">photo</td>
				<td class="table-danger">
					<img src="<%=request.getContextPath()%>/upload/<%=photo.getPhotoName()%>" style="max-width: 100%; height: auto;">
				</td>
			</tr>
			<tr>
				<td class="table-success">photoNo</td>
				<td class="table-danger"><%=photo.getPhotoNo()%></td>
			</tr>
			<tr>
				<td class="table-success">photoName</td>
				<td class="table-danger"><%=photo.getPhotoName()%></td>
			</tr>
			<tr>
				<td class="table-success">createDate</td>
				<td class="table-danger"><%=photo.getCreateDate()%></td>
			</tr>
			<tr>
				<td class="table-success">updateDate</td>
				<td class="table-danger"><%=photo.getUpdateDate()%></td>
			</tr>
		</table>
		<div class="btn-group ">
			<a href="<%=request.getContextPath() %>/photo/deletePhotoForm.jsp?photoNo=<%=photoNo%>" class="btn btn-outline-danger">삭제</a>
		</div>
	</div>
</body>
</html>