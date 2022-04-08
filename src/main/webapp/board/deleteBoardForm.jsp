<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	//해당 번호 불러오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>deleteBoardForm</title>
		 <!-- bootstrap 4 불러와서 사용하겠음 -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	</head>
	<body>
		<div class="container"><!-- 화면(고정너비 컨텐츠 사용할거임) -->
			<!-- category별 게시글 링크 메뉴 -->
			<h1 class="text-info">삭제할 게시글</h1>
			<form method="post" action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp">
				<table class="table table-hover">
					<tr>
						<td class="table-success">boardNo</td>
						<td class="table-danger"><input type="text" name="boardNo" value="<%=boardNo %>" readonly="readonly">
					</tr>
					<tr>
						<td class="table-success">boardPw</td>
						<td class="table-danger"><input type="password" name ="boardPw" ></td>
					</tr>
					<tr>
						<td colspan="2">
						<button type="submit" class="btn btn-danger">삭제</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>