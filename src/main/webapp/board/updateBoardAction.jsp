<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"%>
<%@ page import ="vo.*" %>
<% 
	//한글 입력 인코딩
	request.setCharacterEncoding("utf-8"); 
	
	//updateBoardForm 입력값 받아오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String categoryName = request.getParameter("categoryName"); 
	String boardTitle = request.getParameter("boardTitle"); 
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	
	//받아온 값 묶기
	Board board = new Board();
	board.boardNo = boardNo;
	board.categoryName = categoryName; 
	board.boardTitle = boardTitle; 
	board.boardContent = boardContent; 
	board.boardPw = boardPw; 
	
	//마리아 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("updateBoardAction 마리아 드라이버 로딩 성공");
	
	//마리아 DBMS 접속
	Connection conn = null; 
	String dburl = "jdbc:mariadb://localhost:3306/blog"; 
	String dbuser = "root"; 
	String dbpw = "java1234"; 
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + "<--updateBoardAction conn");
	
	/*
		UPDATE board Set
		category_name =?,
		board_title = ?,
		board_content = ?,
		update_date = now()
		WHERE board_no =? AND board_pw =? 
	*/
	
	//쿼리 저장
	String Sql = "UPDATE board SET category_name=?, board_title=?, board_content=?, update_date=now() WHERE board_no=? AND board_pw";
	PreparedStatement stmt = conn.prepareStatement(Sql);
	//? 에 들어갈 값 저장
	stmt.setString(1, categoryName);
	stmt.setString(2, boardTitle);
	stmt.setString(3, boardContent);
	stmt.setInt(4, boardNo);
	stmt.setString(5, boardPw);
	
	// 몇행입력했는지 리턴
	int row = stmt.executeUpdate();
	
	if(row == 0) {// 행 저장 실패
		System.out.println("수정실패"); 
		response.sendRedirect(request.getContextPath() +"/board/updateBoardForm.jsp?boardNo=" + board.boardNo); //다시 Form으로 돌아감
	} else if (row == 1) {
		System.out.println("수정성공"); 
		response.sendRedirect(request.getContextPath()+"/board/boardOne.jsp?boardNo=" + board.boardNo); //상세보기로 감
	} else { 
		System.out.println("Error");
	}
	
	//연결 종료
	conn.close(); 
%>