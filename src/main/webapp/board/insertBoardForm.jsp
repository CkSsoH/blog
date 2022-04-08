<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%
	//마리아 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("insertBoardForm 드라이버 로딩 성공");

	//마리아 접속
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";
	String dbuser = "root";
	String dbpw = "java1234";
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	
	//불러올 쿼리 저장 (categoryName)
	String sql = "SELECT category_name categoryName FROM category ORDER BY category_name ASC";
	PreparedStatement stmt = conn.prepareStatement(sql);
	//쿼리 결과 리턴
	ResultSet rs = stmt.executeQuery();
	//ArrayList 로 변경 
	ArrayList<String> list = new ArrayList<String>();
	while(rs.next()) {
		list.add(rs.getString("categoryName"));
	}
	// 출력문에 글입력 누르면 categoryName 을 선택 할 수 있도록 만들기 (아래 작성)
	

	conn.close();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertBoardForm</title>
		<!-- 
		<style type="text/css">
			table, td {
				border: 1px solid #B5B2FF;
			}
		</style>
		 -->
		<!-- bootstrap 4 불러와서 사용하겠음 -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	</head>
	<body>
		<div class="container"><!-- 화면(고정너비 컨텐츠 사용할거임) -->
			<h1 class="text-info">글입력</h1>
			<form method="post" action="<%=request.getContextPath()%>/board/insertBoardAction.jsp">
				<table class="table table-hover">
					<tr>
						<td class="table-success">cetegoryName</td>
						<td class="table-danger">
							<select name="categoryName">
		 					<%
		 						for(String s : list) {
							%>
								<option value="<%=s%>"><%=s%></option>
							<%      
								}
							%>
							</select>
						</td>
					</tr>
					<tr>
						<td class="table-success">boardTitle</td>
						<td class="table-danger">
							<input type = "text" name = "boardTitle">
						</td>
					</tr>
			         <tr>
						<td class="table-success">boardContent</td>
						<td class="table-danger">
							<input type = "text" name = "boardContent">
						</td>
					</tr>
					<tr>
						<td class="table-success">boardPw</td>
						<td class="table-danger">
							<input type = "password" name = "boardPw">
						</td>
					</tr>
					<tr>
						<td colspan="2">
						<button type="submit" class="btn btn-primary">입력</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>