<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="dao.BoardDao"%>
<%@ page import = "vo.*" %>
<%
	//한글 입력 인코딩
	request.setCharacterEncoding("utf-8");
	
	//DAO객체생성
	BoardDao boardDao = new BoardDao();
	
	//insertBoardTForm 입력 값 불러오기
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	System.out.println("categoryName ->" + categoryName);
	System.out.println("boardTitle ->" + boardTitle);
	System.out.println("boardContent ->" + boardContent);
	System.out.println("boardPw ->" + boardPw);
	
	//요청해서 넘겨진 값들을 가공해서 하나의 변수로 묶기
	Board board = new Board();
	board.setCategoryName(categoryName);//카테고리 이름
	board.setBoardTitle(boardTitle); //제목
	board.setBoardContent(boardContent); //내용
	board.setBoardPw(boardPw); //비밀번호
	
	//호출
	boardDao.insertBoard(board);
	
	// 입력 후 boardList 로 이동
	response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
%>