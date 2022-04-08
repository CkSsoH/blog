<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%@ page import = "java.util.*"%>
<%@ page import = "java.sql.*" %>
<%
	//한글 안깨지도록 인코딩
	request.setCharacterEncoding("utf-8"); 
	
	//객체생성
	GuestbookDao guestbookDao = new GuestbookDao(); 
	
	//입력값 받아오기
	String guestbookContent = request.getParameter("guestbookContent");
	String writer = request.getParameter("writer");
	String guestbookPw = request.getParameter("guestbookPw");
	
	//디버깅
	System.out.println(writer + "<--writer");
	System.out.println(guestbookPw + "<--guestbookPw");
	System.out.println(guestbookContent + "<--guestbookContent");
	
	//묶어주기
	Guestbook guestbook = new Guestbook();
	guestbook.writer = writer;
	guestbook.guestbookPw = guestbookPw;
	guestbook.guestbookContent = guestbookContent;
	
	//호출
	guestbookDao.insertGuestbook(guestbook);
	
	// 불러온값 저장 후 guestbookList 페이지로이동
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp"); 
	
%>