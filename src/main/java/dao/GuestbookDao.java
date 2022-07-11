package dao;
import java.util.ArrayList;
import vo.Guestbook;
import java.sql.*;

public class GuestbookDao {
	// 생성자 메서드
	public GuestbookDao() {}
	
	//updateGuestbookForm.jsp에서 호출
	public Guestbook selectGuestbookOne(int guestbookNo) throws Exception {
		Guestbook guestbook = null;
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://3.34.127.124:3306/blog";
		String dbuser = "root";
		String dbpw = "mariadb1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent FROM guestbook WHERE guestbook_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, guestbookNo);
		System.out.println(stmt + "<-- sql selectGuestbookOne");
		rs = stmt.executeQuery();
		if(rs.next()) {
			guestbook = new Guestbook(); // 생성자 메서드
			guestbook.setGuestbookNo(rs.getInt("guestbook")); 
			guestbook.setGuestbookContent(rs.getString("guestbookContent"));
			
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return guestbook;
	}
	//updateGuestbookAction.jsp 에서 호출
	//이름 - updateGuestbook
	//반환값 - 수정한 행의 수 반환
	//입력매개변수 guestbookNo, guestbookContent, guestbookPw 3개 -> 하나의 타입 매개변수로 받고싶다
	//-> Gusetbook 타입을 사용
	public int updateGuestbook(Guestbook guestbook) throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://3.34.127.124:3306/blog";
		String dbuser = "root";
		String dbpw = "mariadb1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "UPDATE guestbook SET guestbook_content=? WHERE guestbook_no=? AND guestbook_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, guestbook.getGuestbookContent());
		stmt.setInt(2, guestbook.getGuestbookNo());
		stmt.setString(3, guestbook.getGuestbookPw());
		System.out.println(stmt+"<-- sql updateGuestbook");
		row = stmt.executeUpdate();
				
		stmt.close();
		conn.close();
		
		return row;
	}
	//삭제(deleteGuestbook)프로세스 deleteGuestbookAction.jsp 호출
	//이름 - deleteGuestbook
	//반환값 - 삭제한 행의 수 반환 -> 0 수정실패, 1 수정 성공 -> int
	//입력 매개값 - gusetbookNo, guestbookPw 2개 -> int, String 타입을 사용(Guestbook타입을 사용해도 됨)
	public int deleteGuestbook(int guestbookNo, String guestbookPw)throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://3.34.127.124:3306/blog";
		String dbuser = "root";
		String dbpw = "mariadb1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "DELETE FROM guestbook WHERE guestbook_no=? AND guestbook_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, guestbookNo);
		stmt.setString(2, guestbookPw);
		System.out.println(stmt+"<--sql deleteGuestbook");
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
	
	
	//입력
	//GuestbookDao guestbookDao = new GuestbookDao();
	//Guestbook guestbook = new Guestbook();
	//guestbookDao. insertGuestbook(guestbook); 호출
	public void insertGuestbook(Guestbook guestbook) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		
		String dburl = "jdbc:mariadb://3.34.127.124:3306/blog";
		String dbuser = "root";
		String dbpw = "mariadb1234";
		String sql = "INSERT INTO guestbook(guestbook_content, writer, guestbook_pw, create_date, update_date) VALUES(?,?,?,NOW(),NOW())";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, guestbook.getGuestbookContent());
		stmt.setString(2, guestbook.getWriter());
		stmt.setString(3, guestbook.getGuestbookPw());
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("입력성공");
		} else {
			System.out.println("입력실패");
		}
		stmt.close();
		conn.close();
	}

	//guestbook 전체 행의 수를 반환하는 메서드
	public int selectGuestbookTotalRow() throws Exception{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		//데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://3.34.127.124:3306/blog";
		String dbuser = "root";
		String dbpw = "mariadb1234";
		String sql = "SELECT COUNT(*) cnt FROM guestbook";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		
		//전체 행을 반환하는 데이터베이스 구현 부 ! 
		return row;
	}
	
	//guestbook list를 n행씩 반환하는 메서드
	public ArrayList<Guestbook> selectGuestbookListByPage(int beginRow, int rowPerPage)throws Exception{
		ArrayList<Guestbook> list = new ArrayList<Guestbook>();
		//guestbook 10행 반환되도록 구현
		Class.forName("org.mariadb.jdbc.Driver");
		
		//데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://3.34.127.124:3306/blog";
		String dbuser = "root";
		String dbpw = "mariadb1234";
		String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, writer, create_date createDate FROM guestbook ORDER BY create_date DESC LIMIT ?, ?";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		//데이터 베이스 로직 끝
		
		//데이터 변환 (가공)
		while(rs.next()){
			Guestbook g = new Guestbook();
			g.setGuestbookNo(rs.getInt("guestbookNo"));
			g.setGuestbookContent(rs.getString("guestbookContent"));
			g.setWriter(rs.getString("writer"));
			g.setCreateDate(rs.getString("createDate"));
			list.add(g);

		}
		
		//데이터 베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
}
