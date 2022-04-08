<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%
	// boardOne(상세보기)에서 수정버튼 누르면 해당 번호 불러오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	
	//마리아 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("updateBoardForm 마리아 드라이버 로딩 성공");
	
	//마리아 DBMS 접속 (접속할 주소, 이름, 패스워드 입력)
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog"; 
	String dbuser = "root"; 
	String dbpw = "java1234"; 
	conn = DriverManager.getConnection(dburl,dbuser,dbpw);
	System.out.println(conn + "<--updateBoardForm conn");
	
	//불러올 쿼리 저장 (board 테이블 불러올거임)
	String sql = "select board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, board_pw boardPw, create_date createDate, update_date updateDate from board WHERE board_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	System.out.println(stmt + "<--updateBoardForm stmt"); 
	stmt.setInt(1,boardNo); 
	
	//쿼리 결과 리턴
	ResultSet rs = stmt.executeQuery(); 
	System.out.println(rs + "<--updateBoardForm rs"); 
	
	//ArrayList 로 변경
	Board board = null;
	if(rs.next()) { // true값일때만 커서 옮기면서
		board = new Board(); // board값 담을 새로운 리스트 생성
		board.boardNo = rs.getInt("boardNo");
		board.categoryName = rs.getString("categoryName");
		board.boardTitle =  rs.getString("boardTitle");
		board.boardContent = rs.getString("boardContent");
		board.createDate =  rs.getString("createDate");
		board.updateDate =  rs.getString("updateDate");
	}
	
	
	//category 목록불러오기 위한 쿼리(수정페이지에서 select로 option선택 할 수 있도록 만들기 위함)
	//category 테이블에서 category_name만 불러올거임
	String categorySql = "SELECT category_name categoryName FROM category";
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
	
	//쿼리 결과값 리턴
	ResultSet categoryRs = categoryStmt.executeQuery();
	System.out.println(categoryRs + "<--updateBoardForm categoryRs"); 
	
	// categoryRs -> categoryList 이동하도록 한것 
	ArrayList<String> categoryList = new ArrayList<String>();
	while(categoryRs.next()) { 
		categoryList.add(categoryRs.getString("categoryName"));
	}
	
	//연결 종료
	conn.close();
	
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
						<td class="table-danger"><input type="text" name="boardNo" value="<%=board.boardNo%>" readonly="readonly"></td>
					</tr>
					<tr>
						<td class="table-success">categoryName</td>
						<td class="table-danger">
							<select name="categoryName">
								<%
									for(String s : categoryList) {
										if(s.equals(board.categoryName)) { 
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
						<td class="table-danger"><input type="text" name="boardTitle" value="<%=board.boardTitle%>"></td>
					</tr>
					<tr>
						<td class="table-success">boardContent</td>
						<td class="table-danger">
							<textarea rows="5" cols="50" name="boardContent"><%=board.boardContent%></textarea>
						</td>
					<tr>	
						<td class="table-success">boardPw</td>
						<td class="table-danger"><input type="password" name="boardPw" value=""></td>
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