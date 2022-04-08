<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//한글 인코딩
	request.setCharacterEncoding("utf-8");
	//요청받은 값변경
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	System.out.println(guestbookNo+"<-updateGuestbookForm guestbookNo");//디버깅

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateGuestbookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h1>수정할 방명록</h1>
		<form method="post" action="updateGuestbookAction.jsp">
			<table class="table table-hover">
				<tr>
					<td class="table-success">guestbookNo</td>
					<td class="table-danger">
						<input type="number" name="guestbookNo" value="<%=guestbookNo%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="table-success">guestbookContent</td>
					<td class="table-danger">
						<textarea rows="7" cols="50" name="guestbookContent"></textarea>
					</td>
				</tr>
				<tr>
					<td class="table-success">guestbookPw</td>
					<td class="table-danger">
						<input type="password" name="guestbookPw">
					</td>
				</tr>	
			</table>
				<div>
					<button type="submit" class="btn btn-primary">수정</button><br>
				</div>
		</form>
	</div>
</body>
</html>