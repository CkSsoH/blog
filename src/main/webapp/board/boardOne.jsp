<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@page import="dao.BoardDao"%>
<%
	BoardDao boardDao = new BoardDao(); //dao메소드 생성
	// boardList 에서 boardTitle에 걸어둔 링크클릭시 불러오는 boardNo 형변환
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	System.out.println(boardNo + "<--boardOne boardNo"); 
	
	//boardOne///
	Board board = boardDao.selectBoardOne(boardNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>boardOne</title>
		<!-- [0308] 부트스트렙이용하여 꾸밀거라 생략
		<style type="text/css">
			table, th, td {border : 1px solid #B5B2FF;}
		</style>
		 -->
		 
		 <!-- bootstrap 4 불러와서 사용하겠음 -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	</head>
	<body>
		<div class="container"><!-- 화면(고정너비 컨텐츠 사용할거임) -->
			<div class ="container p-3 my-3 bg-dark text-white"> <!-- 상단타이틀 -->
				<h1> blog </h1>
			</div>
			<div class="row"> <!-- 화면분할거임 -->
				<div class="col-sm-3 bg-light text-dark"><!-- 좌측메뉴 -->
					<!-- ▶▶ boardList에서 만든 카테고리 목록 출력 -->
					<div>
						<ul>
							<%
								for( HashMap<String,Object> m : boardDao.categoryList()){
							%>
								<li>
									<a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%><span class="badge badge-success"><%=m.get("cnt")%></span></a>
								</li>
							<%
								}
							%>
						</ul>
					</div>
				</div>
				<div class="col-sm-9 text-dark">
					<h1 class="text-info">board 상세보기</h1>
					<table class="table table-hover">
						<tr>
							<td class="table-success">boardNo</td>
							<td class="table-danger"><%=board.getBoardNo() %></td>
						</tr>
						<tr>
							<td class="table-success">categoryName</td>
							<td class="table-danger"><%=board.getCategoryName() %></td>
						</tr>
						<tr>
							<td class="table-success">boardTitle</td>
							<td class="table-danger"><%=board.getBoardTitle() %></td>
						</tr>
						<tr>
							<td class="table-success">boardContent</td>
							<td class="table-danger"><%=board.getBoardContent() %></td>
						</tr>
						<tr>
							<td class="table-success">createDate</td>
							<td class="table-danger"><%=board.getCreateDate() %></td>
						</tr>
						<tr>
							<td class="table-success">updateDate</td>
							<td class="table-danger"><%=board.getUpdateDate() %></td>
						</tr>
					</table>
					<div>
						<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=boardNo%>" class="btn btn-primary" role="button">수정</a>
						<a href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%=boardNo%>" class="btn btn-danger" role="button">삭제</a>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>