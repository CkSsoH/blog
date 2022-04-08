<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%
	// 입력값 받아오기 
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	
	Board board = new Board();
	board.boardNo = boardNo;
	board.boardPw = boardPw;
	
	//1) 마리아 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("deleteBoardAction 마리아 드라이버 로딩 성공");
	
	//2) 마리아 DBMS 접속 ( 접속할 주소, 이름, 패스워드 입력 )
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";
	String dbuser = "root";
	String dbpw = "java1234";
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + "<--deleteBoardAction conn");
	
	//3) 쿼리 저장
	PreparedStatement stmt = conn.prepareStatement("delete from board where board_no=? and board_pw =?");
	System.out.println(stmt + "<--deleteBoardAction stmt");
	//? 에 들어갈 값 저장
	stmt.setInt(1, boardNo);
	stmt.setString(2, boardPw);
	
	// 몇행입력했는지 리턴
	int row = stmt.executeUpdate();
	
	if(row == 1){// 1행 성공시 삭제 성공
		System.out.println("삭제 성공");
		response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
	} else {// 아니면 에러
		System.out.println("Error");
	}
	
	// 연결 종료
	conn.close();
%>