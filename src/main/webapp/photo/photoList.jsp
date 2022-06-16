<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	//현재 페이지 
	int currentPage = 1;
	
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage")); 
	}
	System.out.println(currentPage+"<--photoList currentPage"); 
	
	// 페이지 알고리즘
	int rowPerPage = 5;
	int beginRow = (currentPage-1) * rowPerPage;

	PhotoDao photoDao = new PhotoDao();
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage);
	
	int totalRow = photoDao.selectPhotoTotalRow(); 
	System.out.println(totalRow + "<--photoList totalRow");
	
	// 마지막 페이지
	int lastPage = 0; 
	if(totalRow % rowPerPage == 0) {
		lastPage = totalRow / rowPerPage;
	} else {
		lastPage = (totalRow / rowPerPage) + 1;
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>photoList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container"><!-- 화면(고정너비 컨텐츠 사용할거임) -->
		<!-- 메인 메뉴 시작-->
		<jsp:include page="/inc/upMenu.jsp"></jsp:include>
		<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
		<!-- 메인 메뉴 끝 -->
		<div class ="container p-3 my-3 bg-dark text-white"> <!-- 상단타이틀 -->
			<h1>이미지 목록</h1>
		</div>
		<table class="table table-hover">
			<tr class="bg-light">
				<%
					// 한행의 5개의 이미지 출력(tr안에 td가 5개)
					// 이미지가 3개  - tr 1 - td 5
					// 이미지가 5개  - tr 1 - td 5
					// 이미지가 10개 - tr 2 - td 10
					// 이미지가 9개  - tr 2 - td 10 
					
					// td의 갯수 5의 배수가 되도록
					// list.size()가 1~5 - td는 5개
					// list.size()가 6~10 - td는 10개
					System.out.println(list.size() + " <- list.size()");
				
					int endIdx = (((list.size()-1)/5)+1)*5; // 5의 배수가 되어야 한다.(한줄에 5개씩 출력하기로...)
					System.out.println(endIdx+" <-- endIdx");
					
				//	for(Photo p : list) { // size()만큼 반복되므로 5의배수가 아닐 수도 있다. 
					for(int i=0; i<endIdx; i++) { // 01234, 0123456789
						// tr을 닫고 새로운 tr 시작
						if(i!=0 && i%5==0) { // 5일때(0을 제외한 5의배수일때) 
				%>
							</tr><tr class="bg-light">
				<%			
						}
					
						if(i<list.size()) {
				%>
							<td>
								<a href="<%=request.getContextPath()%>/photo/photoOne.jsp?photoNo=<%=list.get(i).getPhotoNo()%>">
									<img src="<%=request.getContextPath()%>/upload/<%=list.get(i).getPhotoName()%>" width="100" height="100">
									<!--  상세보기에서는 원본이미지 크기로 -->
								</a>
							</td>
				<%
						} else {
				%>
							<td>&nbsp;</td>
				<%			
						}
					}
				%>
			</tr>
		</table>
		<div style= "text-align:right">
			<a class= "btn btn-primary" href="<%=request.getContextPath()%>/photo/insertPhotoForm.jsp">글작성</a>
		</div>
			<div class="btn-group">
				<!-- 페이지가 if 10페이지였다면 이전:9page, 다음:11page -->
				<%
					if(currentPage >1){ //현재페이지가 1이면 이전페이지가 존재해서는 안된다
				%>
					<a href="<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage-1%>" class="btn btn-outline-info">이전</a> 		
				<%	
					}
				%>
					<!-- 전체 행  마지막 페이지 알아내기
						마지막 페이지 = 전체행 / rowPerPage -->
				<%
					if(currentPage <lastPage){
				%>
					<a href="<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage+1%>" class="btn btn-outline-info">다음</a>
				<% 		
					}
				%>		
				<!-- 다음페이지로 넘어가기 / 세부카테고리 리스트에서도 다음페이지 넘어가게 -->
		</div>
	</div>
</body>
</html>