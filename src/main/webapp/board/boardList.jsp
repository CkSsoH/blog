<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%	

	// [0304 추가] boardList 페이지 시작시 실행하면 최근 10개의 목록을 보여주고 1페이지로 설정
	int currentPage = 1; // 현재 페이지의 기본값이 1페이지
	//[0304 추가] 이전이나 다음 링크를 통해서 실행 되게 할때 
	if(request.getParameter("currentPage") != null){ //이전, 다음 링크를 통해서 들어왔다면
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + "<--currentPage"); // 이전,다음 확인 디버깅
	
	//이전, 다음링크에서 null 값을 넘기는 것이 불가능해서 null-->공백으로 치환해서 코드를 처리
	String categoryName = ""; //null 이 아니라 공백으로 만들기
	if(request.getParameter("categoryName") != null){ 
		categoryName = request.getParameter("categoryName");
	}
	
	//페이지 바뀌면 끝이 아니고, 가지고 오는 데이터가 변경되어야 한다.
	/*
		알고리즘 (▶ 아래 썼던 LIMIT 도 ?,? 로 수정 필요 !!)
		SELECT 쿼리에서 마지막에 LIMIT ?, 10 갖고 생각해보면 (0~9 임) ★★ 마리아 DB 기준임!!
		currentPage		beginRow
		1				0  (부터 10개 = 0~9)
		2				10 (부터 10개 = 10~19)
		3				20
		4				30
		
		? <-- (currentPage - 1) * 10 으로 넣으면 되겠음 ★★ 마리아 DB 기준임 (0행부터 시작)!!
		? <-- (currentPage) * 10 으로 넣으면 되겠음     ★★ 오라클은 1행부터임 !!
	*/
	int rowPerPage = 10; // 한페이지에 보고싶은 갯수를 변수에 저장해서 사용하기
	int beginRow = (currentPage - 1) * rowPerPage ; 
	// 현재 페이지가 변경되면 beginRow도 변경된다 -> 가져오는 데이터 페이지가 변경된다.
	
	
	
	//------------------------------
	//String categoryName = request.getParameter("categoryName");	위로 옮김 [0304]
	
	// 마리아 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	
	// 연결
	Connection conn = null;
	// 데이터 베이스 이름 적어야함 (blog)
	String dburl = "jdbc:mariadb://localhost:3306/blog";
	String dbuser = "root";
	String dbpw = "java1234";
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	// 연결 확인
	System.out.println(conn+"<--conn");
	
	// alias 사용  (자바에서 이름이랑 비슷하게 categoryName 로함)
	// 쿼리 저장
	String categorySql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
	
	// 쿼리 실행 후 결과값 리턴
	ResultSet categoryRs = categoryStmt.executeQuery();
	
	// 쿼리에 결과를 Category, Board VO로 저장할 수 없다. -> HashMap을 사용해서 저장하자!
		ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
		while(categoryRs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("categoryName", categoryRs.getString("categoryName"));
			map.put("cnt", categoryRs.getInt("cnt"));
			categoryList.add(map);
		}
		
	// boardList
	String boardSql = null;
	PreparedStatement boardStmt = null;
	// [0304]  if(categoryName == null) { 이였는데 아래로 수정 (널이면 안되니깐)
	if(categoryName.equals("")) {
		boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
		boardStmt = conn.prepareStatement(boardSql);
		boardStmt.setInt(1, beginRow);
		boardStmt.setInt(2, rowPerPage);
	} else {
		boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT ?, ?";
		boardStmt = conn.prepareStatement(boardSql);
		boardStmt.setString(1, categoryName);
		boardStmt.setInt(2, beginRow);
		boardStmt.setInt(3, rowPerPage);
		}
	ResultSet boardRs = boardStmt.executeQuery();
	ArrayList<Board> boardList = new ArrayList<Board>();
	while(boardRs.next()) {
		Board b = new Board();
		b.boardNo = boardRs.getInt("boardNo");
		b.categoryName = boardRs.getString("categoryName");
		b.boardTitle = boardRs.getString("boardTitle");
		b.createDate = boardRs.getString("createDate");
		boardList.add(b);
	}

		
		
	//--------------------------[0304]
	int totalRow = 0; // totalRow 계산하는 쿼리 ▼
					  // select count(*) from board;
	String totalRowSql = "SELECT COUNT(*) cnt FROM board";
	PreparedStatement totalRowStmt = conn.prepareStatement(totalRowSql);
	ResultSet totalRowRs = totalRowStmt.executeQuery();
	
	if(totalRowRs.next()) {
		totalRow = totalRowRs.getInt("cnt");
		System.out.println(totalRow + "<--totalRow(1000)");
	}

	int lastPage = 0;
	if(totalRow % rowPerPage == 0){ //나누어 떨어지면
		lastPage = totalRow / rowPerPage;
	} else { //나누어 떨어지지 않는다면 (소수점이있다면)
		lastPage = (totalRow / rowPerPage) + 1;
	}
	conn.close();
//
	%>
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>boardList</title>
		<!--부트스트랩 부러와서 쓸거로 수정함 [0308]
		<style type="text/css">
			tabel, th, td {
				border: 1px solid pink;
			}
		</style>
		 -->
		<!-- bootstrap 4 불러와서 사용하겠음 -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	</head>
	<body>
		<div class="container"><!-- 화면(고정너비 컨텐츠 사용할거임) -->
			<jsp:include page="/inc/upMenu.jsp"></jsp:include>
			<!-- category별 게시글 링크 메뉴 -->
			<div class ="container p-3 my-3 bg-dark text-white"> <!-- 상단타이틀 -->
				<h1> blog </h1>
			</div>
			<div class="row"> 
				<div class="col-sm-3 bg-light text-dark"><!-- 좌측메뉴 -->
					<ul>
						<%
							for(HashMap<String, Object> m : categoryList) {
						%>
								<li>
									<a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%><span class="badge badge-success"><%=m.get("cnt")%></span></a>
								</li>
						<%		
							}
						%>
					</ul>
				</div>
				<div class="col-sm-9 text-dark">
					<!-- 게시글 리스트 --><!--  메인메뉴 -->
					<h1 class="text-info">게시글 목록(total : <%=totalRow%>)</h1>
					<a href="<%=request.getContextPath()%>/board/insertBoardForm.jsp" class="btn btn-info" role="button">게시글 입력</a>					
					<table class="table table-hover">
						<thead class="table-success">
							<tr>
								<th>categoryName</th>
								<th>boardTitle</th>
								<th>createDate</th>
							</tr>
						</thead>
						<tbody class="table-danger">
							<%
								for(Board b : boardList) {
							%>
									<tr>
										<td><%=b.categoryName%></td>
										<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.boardNo%>"><%=b.boardTitle%></a></td>
										<td><%=b.createDate%></td>
									</tr>
							<%		
								}
							%>
						</tbody>
					</table>
				
					<div><!-- [0304 추가] -->
						<!--페이지가 만약 10페이지였다면 이전을 누르면 9페이지, 다음을 누르면 11페이지가 나와야함 -->
						<!-- 1페이지 이하로 못가게 하려면 -->
						<%
							if(currentPage > 1){// 현재페이지가 1이면 이전페이지가 존재해서는 안된다.
						%>	<!-- 1페이지에서는 이전 버튼이 아예 안나옴 ! -->
								<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>" class="btn btn-primary" role="button">이전</a>	
						<%
							}
						%>
						<!-- 
							전체행 		마지막페이지는?
							10개			1
							11개			2 ( 전체행 11,12...20개 까지는 마지막페이지가 2페이지임)
							21~30		3
							31~40		4
							
							마지막 페이지 = 전체행 / rowPerPage(<-아까위에서 한페이지당 몇개 넣을지 담은 변수)
						 -->
						<%
							if(currentPage < lastPage) {
						%>
								<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>" class="btn btn-success" role="button">다음</a><!--currentPage+ 1 현재페이지 + 1 -->
						<%		
							}
						%>
					</div>
				</div>
			</div>
		</div>
	</body>
	</html>