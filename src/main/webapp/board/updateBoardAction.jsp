<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"%>
<%@ page import ="vo.*" %>
<%@page import="dao.BoardDao"%>
<% 

	
	//한글 입력 인코딩
	request.setCharacterEncoding("utf-8"); 
	
	//dao 메서드 생성
	BoardDao boardDao = new BoardDao(); 
	
	//updateBoardForm 입력값 받아오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String categoryName = request.getParameter("categoryName"); 
	String boardTitle = request.getParameter("boardTitle"); 
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	String updateDate = request.getParameter("updateDate");//수정날짜
	
	//받아온 값 묶기
	Board board = new Board();
	board.setBoardNo(boardNo);
	board.setCategoryName(categoryName); 
	board.setBoardTitle(boardTitle); 
	board.setBoardContent(boardContent); 
	board.setBoardPw(boardPw);
	board.setUpdateDate(updateDate);
	
	// 몇행입력했는지 리턴
	int row = boardDao.updateForm(board);  //update -> dao가져오기
	
	if(row ==0){ //업데이트된 행이 없을때
		response.sendRedirect(request.getContextPath()+"/board/updateBoardForm.jsp?boardNo=" + board.getBoardNo());
		System.out.println("수정실패");
	}else if(row == 1){ //업데이트 행이 있을때
		response.sendRedirect("./boardOne.jsp?boardNo="+board.getBoardNo());
		System.out.println("수정된 행(row):" + row);
		System.out.println("categoryName:" + categoryName);
	}else{
		System.out.println("error");
	}

%>