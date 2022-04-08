<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%
	//한글 입력 인코딩
	request.setCharacterEncoding("utf-8");
	
	//insertBoardTForm 입력 값 불러오기
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	
	//요청해서 넘겨진 값들을 가공해서 하나의 변수로 묶기
	Board board = new Board();
	board.categoryName = categoryName; //카테고리 이름
	board.boardTitle = boardTitle; //제목
	board.boardContent = boardContent; //내용
	board.boardPw = boardPw;
	
	//1) 마리아 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("insertBoardAction 마리아 드라이버 로딩 성공");
	
	//2) 마리아 DBMS 접속 ( 접속할 주소, 이름, 패스워드 입력 )
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";
	String dbuser = "root";
	String dbpw = "java1234";
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + "<--insertBoardAction conn");
	
	/* insertboardAciton 쿼리
	
	INSERT INTO board(category_name,
				category_name,
				board_title,
				board_content,
				board_pw,
				create_date,
				update_date
	) VALUES (
		?, ?, ?, ?, NOW(),NOW()	
	)
	*/
	
	//3) 불러올 쿼리 저장 (board_pw 제외 상세 페이지로 불러올 거임)
	String sql=" INSERT INTO board(category_name, board_title, board_content, board_pw, create_date, update_date) VALUES ( ?, ?, ?, ?, NOW(), NOW())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	//?표에 들어올 값들 저장
	stmt.setString(1, categoryName);
	stmt.setString(2, boardTitle);
	stmt.setString(3, boardContent);
	stmt.setString(4, boardPw);
	
	// 입력 확인 디버깅
	int row = stmt.executeUpdate(); // 몇 행 입력했는지 리턴
	if(row == 1) {
		System.out.println(row + "<--행 입력 성공");
	} else {
		System.out.println("입력실패");
	}
	
	// 2-2) 접속 종료
	conn.close();
	
	// 입력 후 boardList 로 이동
	response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
%>