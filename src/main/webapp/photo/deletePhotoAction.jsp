<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"  %>
<%@ page import = "java.io.*" %>
<%
	// 1) 테이블 데이터 삭제 <-- photoNo 필요
	// 2) upload 폴더에 이미지 삭제 <- photoName 알아야함

	//값가져오기
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoPw = request.getParameter("photoPw");
	//디버깅
	System.out.println(photoNo+"<--deletePhotoAction.photoNo");
	System.out.println(photoPw+"<--deletePhotoAction.photoPW");
	
	PhotoDao photoDao = new PhotoDao();
	String photoName = photoDao.selectPhotoName(photoNo); //사진이름 함수 호출
	
	//1) 테이블 데이터 삭제
	int delRow = photoDao.deletePhoto(photoNo, photoPw);
	
	//2) 폴더 이미지 삭제
	if(delRow == 1){ //테이블 데이터 삭제 성공
		String path = application.getRealPath("upload"); //application(현재프로젝트)안의 upload 폴더의 실제 폴더 경로를
		File file = new File(path+"\\"+photoName); // 이미지 파일을 불러온다. java.io.File  
		file.delete(); // 이미지 파일을 삭제
		// 페이지 이동 만들기...
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");
	}else {
		System.out.println("삭제실패");
		//페이지 이동 만들기..
		response.sendRedirect(request.getContextPath()+"/photo/deletePhotoForm.jsp");
	}
%>

    