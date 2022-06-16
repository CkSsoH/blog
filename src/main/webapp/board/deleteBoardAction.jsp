<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import="dao.BoardDao" %>
<%
	BoardDao boardDao = new BoardDao();//dao객체 생성
	// 입력값 받아오기 
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	
	Board board = new Board();
	board.setBoardNo(boardNo);
	board.setBoardPw(boardPw);
	
	int row =  boardDao.deleteBoard(boardNo, boardPw); //삭제 기능 가져오기?
	if(row == 0){ //삭제실패
		response.sendRedirect(request.getContextPath()+"/board/deleteBoardForm.jsp?boardNo=" + board.getBoardNo());
		System.out.println("삭제실패");
	}else if(row == 1){//삭제성공
		response.sendRedirect("./boardList.jsp");
		System.out.println("삭제된 행(row):" + row);
	}else{
		System.out.println("error");
	}

%>