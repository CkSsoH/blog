<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.BoardDao"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%
	//dao메서드 생성
	BoardDao boardDao = new BoardDao(); 

	// boardOne(상세보기)에서 수정버튼 누르면 해당 번호 불러오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	
	//수정전 값 
	Board board = boardDao.selectBoardOne(boardNo);
	
	// categoryRs -> categoryList 이동하도록 한것 
	ArrayList<String> categoryList = boardDao.selectCatecoryList("categoryName");
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateBoardForm</title>
		<!-- 
		<style>
			table, td {border : 1px solid green;}
		</style>
		 -->
		<!-- bootstrap 4 불러와서 사용하겠음 -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	</head>
	<body>
		<div class="container"><!-- 화면(고정너비 컨텐츠 사용할거임) -->
			<h1 class="text-info">수정할 항목</h1>
			<form method="post" action="<%=request.getContextPath()%>/board/updateBoardAction.jsp">
				<table class="table table-hover">
					<tr>
						<td class="table-success">boardNo</td> <!-- 수정페이지에서 boardNo는 읽기 전용(수정불가)  -->
						<td class="table-danger"><input type="text" name="boardNo" value="<%=board.getBoardNo()%>" readonly="readonly"></td>
					</tr>
					<tr>
						<td class="table-success">categoryName</td>
						<td class="table-danger">
							<select name="categoryName">
								<%
									for(String s : categoryList) {
										if(s.equals(board.getCategoryName())) { 
								%>
											<option selected="selected" value="<%=s%>"><%=s%></option>
								<%
										} else {
								%>
											<option value="<%=s%>"><%=s%></option>
								<%		
										}
									}
								%>
							</select>
						</td>
					</tr>
					<tr>
						<td class="table-success">boardTitle</td>
						<td class="table-danger"><input type="text" name="boardTitle" value="<%=board.getBoardTitle()%>"></td>
					</tr>
					<tr>
						<td class="table-success">boardContent</td>
						<td class="table-danger">
							<textarea rows="5" cols="50" name="boardContent"><%=board.getBoardContent()%></textarea>
						</td>
					<tr>	
						<td class="table-success">boardPw</td>
						<td class="table-danger"><input type="password" name="boardPw"></td>
					</tr>
					<tr>
						<td colspan="2">
						<button type="submit" class="btn btn-primary">수정</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>