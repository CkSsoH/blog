package dao;


import java.sql.*;
import java.util.ArrayList;

import vo.Photo;

public class PhotoDao {
	
	// 이미지 이름을 반환하는 메서드
	public String selectPhotoName(int photoNo) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver"); //드라이버 로딩
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs =null;
		
		//db접속
		conn = DriverManager.getConnection("jdbc:mariadb://3.34.127.124:3306/blog","root","java1234");

		String PhotoName = "SELECT photo_name WHERE photo_no=?";
		stmt= conn.prepareStatement(PhotoName);
		stmt.setInt(1, photoNo);
		
		return PhotoName;
		
	}
	
	// 이미지 입력
	public void insertPhoto(Photo photo) throws Exception{
		// 구현
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://3.34.127.124:3306/blog"; 
		String dbuser = "root"; 
		String dbpw = "java1234";
		// 불러오기
		String sql = "INSERT INTO photo(photo_name, photo_original_name, photo_type, photo_pw, writer, create_date, update_date)VALUES(?, ?, ?, ?, ?, NOW(), NOW())";
		
		// 객체의 멤버변수에 있는 정보 저장
		String photoName = photo.getPhotoName();
		String photoOriginalName = photo.getPhotoOriginalName();
		String photoType = photo.getPhotoType();
		String photoPw = photo.getPhotoPw();
		String writer = photo.getWriter();
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); // DB접속
		stmt = conn.prepareStatement(sql); // sql작성
		// ?에 값들 저장
		stmt.setString(1, photoName);
		stmt.setString(2, photoOriginalName);
		stmt.setString(3, photoType);
		stmt.setString(4, photoPw);
		stmt.setString(5, writer);
		
		System.out.println("sql insertPhoto : " + stmt); // 디버깅
		
		rs = stmt.executeQuery(); // sql ResultSet형태로 저장
		
		if(rs.next()) { // 데이터가 있으면 각 객체에 저장 후 DB에 저장
			photoName = rs.getString("photo_name");
			photoOriginalName = rs.getString("photo_original_name");
			photoType = rs.getString("photo_type");
			photoPw = rs.getString("photo_pw");
			writer = rs.getString("writer");
		}
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
	}
	
	// 이미지 삭제
	public int deletePhoto(int photoNo, String photoPw)throws Exception { 
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://3.34.127.124:3306/blog"; 
		String dbuser = "root";
		String dbpw = "java1234"; 
		String sql = "DELETE FROM photo WHERE photo_no=? AND photo_pw=?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql); 
		// ?에 값 저장
		stmt.setInt(1, photoNo);
		stmt.setString(2, photoPw);
		System.out.println(stmt + "<--PhotoDaoDelete stmt"); // 디버깅
		
		row = stmt.executeUpdate(); 
		System.out.println(row + "<-삭제 확인"); // 디버깅
		
		// 반납
		stmt.close();
		conn.close();
		return row;
	}
	
	// 전체 행의 수
	public int selectPhotoTotalRow() throws Exception {
		int total = 0; // 총 행의 갯수 저장하는 변수 선언
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://3.34.127.124:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		String sql = "SELECT COUNT(*) cnt FROM photo";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		if(rs.next()) { // 데이터가 있을때
			total = rs.getInt("cnt");
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return total;
	}
	
	// 이미지 목록
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Photo> list = new ArrayList<Photo>(); // ArrayList<Photo> 객체 생성
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://3.34.127.124:3306/blog";
		String dbuser = "root"; 
		String dbpw = "java1234"; 
		String sql = "SELECT photo_no photoNo, photo_name photoName, photo_original_name photoOriginalName, photo_type photoType, photo_pw photoPw, writer, create_date createDate, update_date updateDate FROM photo ORDER BY create_date DESC LIMIT ?, ?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql); 

		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		System.out.println(stmt + "<--PhotoDaoList stmt"); 
		
		rs = stmt.executeQuery();
		
		//list 저장
		while(rs.next()) {
			Photo photo = new Photo(); 
			photo.setPhotoNo(rs.getInt("photoNo"));
			photo.setPhotoName(rs.getString("photoName"));
			photo.setPhotoOriginalName(rs.getString("photoOriginalName"));
			photo.setPhotoType(rs.getString("photoType"));
			photo.setPhotoPw(rs.getString("photoPw"));
			photo.setWriter(rs.getString("writer"));
			photo.setCreateDate(rs.getString("createDate"));
			photo.setUpdateDate(rs.getString("updateDate"));
			list.add(photo); 
		}
		
		
		// 반납
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}

	
	// 이미지 하나 상세보기
	public Photo selectPhotoOne(int photoNo) throws Exception {
		Photo photo = null; // 객체 생성 준비
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://3.34.127.124:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		String sql = "SELECT photo_no photoNo, photo_name photoName, writer, create_date createDate, update_date updateDate FROM photo WHERE photo_no=?";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		
		System.out.println(stmt + "<--PhotoDaoOne stmt");
		
		rs = stmt.executeQuery();
		
		if(rs.next()) { 
			photo = new Photo();
			photo.setPhotoNo(rs.getInt("photoNo"));
			photo.setPhotoName(rs.getString("photoName"));
			photo.setWriter(rs.getString("writer"));
			photo.setCreateDate(rs.getString("createDate"));
			photo.setUpdateDate(rs.getString("updateDate"));
		}

		rs.close();
		conn.close();
		stmt.close();

		return photo;
	}
}