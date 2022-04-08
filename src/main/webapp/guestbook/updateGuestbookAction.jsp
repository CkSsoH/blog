<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.GuestbookDao" %>
<%	
	//한글 인코딩
	request.setCharacterEncoding("utf-8");
	//요청받은 값 저장
	String guestbookContent = request.getParameter("guestbookContent");
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookPw= request.getParameter("guestbookPw");
	//디버깅
	System.out.println(guestbookContent+"<-updateGuestbookAction content");
	System.out.println(guestbookNo+"<-updateGuestbookAction No");
	System.out.println(guestbookPw+"<-updateGuestbookAction Pw");
	//묶어서 처리
	Guestbook guestbook = new Guestbook();
	guestbook.guestbookContent = guestbookContent;
	guestbook.guestbookNo = guestbookNo;
	guestbook.guestbookPw = guestbookPw;
	//guestbookdao호출
	GuestbookDao guestbookDao = new GuestbookDao();
	int row = guestbookDao.updateGuestbook(guestbook);
	
	if(row == 0) { //행 수정 0개시
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath()+"/guestbook/updateGuestbookForm.jsp?guestbookNo="+guestbook.guestbookNo);
	} else if(row == 1) { //행 1 성공시
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
	} else { 
		System.out.println("Error");
	}
%>