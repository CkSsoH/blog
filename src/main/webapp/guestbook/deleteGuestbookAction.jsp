<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dao.GuestbookDao"%>
<%@page import="vo.*"%>
<%	
	//메서드 생성
	GuestbookDao guestbookDao = new GuestbookDao();
	
	// 번호, pw 받기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookPw = request.getParameter("guestbookPw");
	
	System.out.println(guestbookNo +"<--deleteAction gestbookNo");
	System.out.println(guestbookPw +"<--deleteAction gestbookPw");
	
	//값 묶어서 처리
	Guestbook guestbook = new Guestbook();
	guestbook.setGuestbookNo(guestbookNo);
	guestbook.setGuestbookPw(guestbookPw);
	
	int row = guestbookDao.deleteGuestbook(guestbookNo, guestbookPw);
	
	// 삭제 확인
	if(row == 1) { // 반환값이 1일때
		System.out.println("삭제 성공");
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp"); 
	} else if(row == 0) { // 반환값이 0일때
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath()+"/guestbook/deleteGuestbookForm.jsp?guestbookNo=" + guestbookNo);
	} else { 
		System.out.println("Erorr");
	}
%>
