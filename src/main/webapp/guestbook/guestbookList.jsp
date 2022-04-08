<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dao.GuestbookDao" %>
<%@ page import="vo.Guestbook" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	
	GuestbookDao guestbookDao = new GuestbookDao();
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);
	
	int lastPage=0;
	int totalCount = guestbookDao.selectGuestbookTotalRow();
	lastPage =(int)(Math.ceil((double)totalCount / (double)rowPerPage));//Math.ceil 올림..
	// if 문 써도 됨 (이렇게 쓰면 그냥 한줄에 써도 될 수 있는 장점이 있음)
	/* 위 Math.ceil 과 같은 식임
	
	lastPage = totalCount / rowPerPage;
	if(totalCount % rowPerPage != 0){
		lastPage++;
	}
	*/
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>guestbookList</title>
	<!-- bootstrap 4 불러와서 사용하겠음 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container"><!-- 화면(고정너비 컨텐츠 사용할거임) -->
		<!-- 메인 메뉴 upMenu로 이동했음 -->
		<!-- include 는 다른페이지가져오기 -->
		<jsp:include page="/inc/upMenu.jsp"></jsp:include> 
		<div class ="container p-3 my-3 bg-dark text-white"> <!-- 상단타이틀 -->
			<h1> guestbook </h1>
		</div>

		<!-- 메인 메뉴 종료 -->
		
	<%
		for(Guestbook g : list){
	%>
		<table class="table table-hover">
			<tr>
				<td class="table-success" ><%=g.writer %></td>
				<td class="table-success" style="text-align:right"><%=g.createDate %></td>
			</tr>
			<tr>
				<td colspan="2" class="table-danger">
				<%=g.guestbookContent %></td>
			</tr>
		</table>
		<div style="text-align:right">
			<a href="<%=request.getContextPath()%>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=g.guestbookNo%>" class="btn btn-primary" role="button">수정</a>
			<a href="<%=request.getContextPath()%>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=g.guestbookNo%>" class="btn btn-danger" role="button">삭제</a>
		</div>
	<%	
		}
	%>
		</br>
	<%
		if(currentPage > 1){
	%>
			<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage-1%>" class="btn btn-dark" role="button">이전</a>
	<%		
		}
	
		if(currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage+1%>" class="btn btn-dark" role="button">다음</a>
	<%
		}
	%>
	
		<!-- 방명록 입력 -->
		<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp">
			<table border="1">
				<tr>
					<td class="table-success">글쓴이</td>
					<td><input type="text" name="writer"></td>
					<td class="table-success">비밀번호</td>
					<td><input type="password" name="guestbookPw"></td>
				</tr>
				<tr>
					<td colspan="4" class="table-danger"><textarea name="guestbookContent" rows="2" cols="60"></textarea></td>
				</tr>
				<tr>
			</table>
			<button type="submit" class="btn btn-success">입력</button>
		</form>
	</div>
</body>
</html>




