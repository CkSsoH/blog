<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%
	// boardList 에서 boardTitle에 걸어둔 링크클릭시 불러오는 boardNo 형변환
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	System.out.println(boardNo + "<--boardOne boardNo"); 
	
	//1) 마리아 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("boardOne 마리아 드라이버 로딩 성공");
	
	//2) 마리아 DBMS 접속 ( 접속할 주소, 이름, 패스워드 입력 )
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";
	String dbuser = "root";
	String dbpw = "java1234";
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + "<--boardOne conn");
	
	//▶▶ boardList 에서 불로온 쿼리 도 보이게 할 거임 
	String categorySql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
	ResultSet categoryRs = categoryStmt.executeQuery();
	System.out.println(categoryRs + "<--boardOne categoryRs"); 
	
	// 쿼리에 결과를 Category, Board VO로 저장할 수 없음 (count() 불러올 수없음) -> HashMap을 사용해서 저장할 것 
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	while(categoryRs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("categoryName", categoryRs.getString("categoryName"));
		map.put("cnt", categoryRs.getInt("cnt"));
		categoryList.add(map);
	}
	
	
	// 다시 상세보기 쿼리 
	//3) 불러올 쿼리 저장 (board_pw 제외 상세 페이지로 불러올 거임)
	PreparedStatement stmt = conn.prepareStatement("select board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, create_date createDate, update_date updateDate from board where board_no = ?");
	stmt.setInt(1, boardNo);
	
	//4) 쿼리 결과 리턴
	ResultSet rs = stmt.executeQuery();
	
	//5) ArrayList로 변경
	Board board = null;
	if(rs.next()){ 	// next() 다음에 읽을 값들이 존재하면 true, 존재하지 않으면 false
		board = new Board();
		board.boardNo = rs.getInt("boardNo");
		board.categoryName = rs.getString("categoryName");
		board.boardTitle = rs.getString("boardTitle");
		board.boardContent = rs.getString("boardContent");
		board.createDate = rs.getString("createDate");
		board.updateDate = rs.getString("updateDate");
	}
	//2-2) 접속 종료 해주기
	conn.close();
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
								for( HashMap<String,Object> m : categoryList){
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
							<td class="table-danger"><%=board.boardNo %></td>
						</tr>
						<tr>
							<td class="table-success">categoryName</td>
							<td class="table-danger"><%=board.categoryName %></td>
						</tr>
						<tr>
							<td class="table-success">boardTitle</td>
							<td class="table-danger"><%=board.boardTitle %></td>
						</tr>
						<tr>
							<td class="table-success">boardContent</td>
							<td class="table-danger"><%=board.boardContent %></td>
						</tr>
						<tr>
							<td class="table-success">createDate</td>
							<td class="table-danger"><%=board.createDate %></td>
						</tr>
						<tr>
							<td class="table-success">updateDate</td>
							<td class="table-danger"><%=board.updateDate %></td>
						</tr>
					</table>
					<div>
						<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=board.boardNo%>" class="btn btn-primary" role="button">수정</a>
						<a href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%=board.boardNo%>" class="btn btn-danger" role="button">삭제</a>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>