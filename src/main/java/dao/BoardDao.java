package dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import vo.Board;
import vo.Guestbook;
public class BoardDao {
	public BoardDao() {} //생성자 메소드
	//1.사이드 - 카데고리 목록 출력
	public ArrayList<HashMap<String,Object>> categoryList() throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		//드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		//maria db접속
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mariadb://3.34.127.124:3306/blog","root","java1234");
		System.out.println(conn + " : conn결과");//디버깅
		
		String sql="SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();

		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("categoryName", rs.getString("categoryName"));
			map.put("cnt", rs.getInt("cnt"));
			list.add(map);
		}
		rs.close();
		stmt.close();
		conn.close();//db종료
		return list;
		
	}
	//2.게시물 목록
	public ArrayList<Board> boardList(int beginRow, int rowPerPage, String categoryName) throws Exception{
		ArrayList<Board> list = new ArrayList<Board>();
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		//데이터베이스 자원 준비
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = DriverManager.getConnection("jdbc:mariadb://3.34.127.124:3306/blog","root","java1234");

		if(categoryName == "") { //카테고리 이름이 공백일때
			sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow); 
			stmt.setInt(2, rowPerPage); //행개수
		} else {
			sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName); //받아온 값 사용
			stmt.setInt(2, beginRow); 
			stmt.setInt(3, rowPerPage);
			System.out.println("게시물목록 boardStmt : " + stmt); //디버깅
		}
		
		//쿼리결과 저장
		rs = stmt.executeQuery();
		System.out.println("게시물목록 boardRs : " + rs); //디버깅
		
		//Board타입, ArrayList생성
		while(rs.next()) { //다음행이 있을때 true반환 없으면 false반환
			Board b = new Board(); //board객체 생성
			b.setBoardNo(rs.getInt("BoardNo"));//게시물번호
			b.setCategoryName(rs.getString("categoryName"));//카테고리 이름 값 불러오기
			b.setBoardTitle(rs.getString("boardTitle"));//제목 불러오기
			b.setCreateDate(rs.getString("createDate"));//생성날짜 불러오기
			list.add(b); //리스트에 추가
			
			System.out.println(rs.getInt("boardNo")+ " ");//게시물 번호
			System.out.println(rs.getString("categoryName")+ " ");//카테고리 이름
			System.out.println(rs.getString("boardTitle")+ " ");//게시물 제목
			System.out.println(rs.getString("createDate")+ " ");//생성날짜
		}
		
		rs.close();
		stmt.close();
		conn.close();//db종료
		return list;
		
	}
	
	//3.입력 - 카테고리 목록 선택 
	public ArrayList<String> selectCatecoryList(String categoryName) throws Exception{
		//ArraList
		ArrayList<String> list = new ArrayList<String>();
		//드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		//db연결
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		//db접속
		conn = DriverManager.getConnection("jdbc:mariadb://3.34.127.124:3306/blog","root","java1234");
		System.out.println(conn + " : conn결과");//디버깅
		
		//쿼리문 가져와서 저장
		String sql = "SELECT category_name categoryName FROM category order by category_name ASC";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		// 데이터 변환(가공)
		while(rs.next()) {
			list.add(rs.getString("categoryName"));
		}	
		rs.close();
		stmt.close();
		conn.close();//db종료
		
		return list;
	}
	//4.전체행 수 반환 - 게시물 리스트
	public int selectBoardTotalRow()throws Exception {
		
	int totalRow = 0; //select count(*) from board; ->전체행의 개수
	Class.forName("org.mariadb.jdbc.Driver");
	//데이터베이스 자원 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	conn = DriverManager.getConnection("jdbc:mariadb://3.34.127.124:3306/blog","root","java1234");
	
	String sql ="SELECT COUNT(*) cnt FROM board";
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	if(rs.next()) {
		totalRow = rs.getInt("cnt");
	}
	rs.close();
	stmt.close();
	conn.close();//db종료
	return totalRow;
}
	//5.10행씩 반환 - 게시물리스트
	public ArrayList<Board> selectBoardListByPage(int beginRow, int rowPerPage) throws Exception{
		ArrayList<Board> list = new ArrayList<Board>();
		//드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		
		//데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = DriverManager.getConnection("jdbc:mariadb://3.34.127.124:3306/blog","root","java1234");
		//쿼리문 저장
		String sql = "SELECT board_no BoardNo,category_name categoryName,board_title boardTitle, board_content boardContent,board_pw boardPw, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		// 데이터 변환(가공)
		while(rs.next()) {
			Board b = new Board();
			b.setBoardNo(rs.getInt("boardNo"));
			b.setCategoryName(rs.getString("categoryName"));
			b.setBoardTitle(rs.getString("boardTitle"));
			b.setBoardContent(rs.getString("boardContent"));
			b.setBoardPw(rs.getString("boardPw"));
			b.setCreateDate(rs.getString("createDate"));
			list.add(b);
			}
		
		// 데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	//6. 게시물 상세보기
		public Board selectBoardOne(int boardNo) throws Exception{
			Board board = null;
			
			Class.forName("org.mariadb.jdbc.Driver"); //드라이버 로딩
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs =null;
			//db접속
			conn = DriverManager.getConnection("jdbc:mariadb://3.34.127.124:3306/blog","root","java1234");
			System.out.println("conn 접속 성공"+conn);
			//쿼리문 저장
			String sql="SELECT board_no boardNo, category_name categoryName, board_title boardTitle,board_content boardContent, create_date createDate, update_date updateDate FROM board where board_no=?";
			stmt= conn.prepareStatement(sql);
			stmt.setInt(1, boardNo);
			rs = stmt.executeQuery();
			
			if(rs.next()){ //다음줄에 있으면 true
				board = new Board(); //board객체 생성
				//객체에 값가져와서 저장?
				board.setBoardNo(rs.getInt("boardNo")); //번호 가져오기
				board.setCategoryName(rs.getString("categoryName")); //카테고리 이름 가져오기
				board.setBoardTitle(rs.getString("boardTitle")); //제목가져오기
				board.setBoardContent(rs.getString("boardContent")); //내용
				board.setCreateDate(rs.getString("createDate")); // 최초생성날짜
				board.setUpdateDate(rs.getString("updateDate"));//수정날짜
			}
			
			rs.close();
			stmt.close();
			conn.close();
			
			return board;
		}
	
	//7.입력
	public void insertBoard(Board board) throws Exception{
		Class.forName("org.mariadb.jdbc.Driver"); //드라이버 로딩
		Connection conn = null;
		PreparedStatement stmt = null;
		
		//db접속
		conn = DriverManager.getConnection("jdbc:mariadb://3.34.127.124:3306/blog","root","java1234");
		//쿼리문 저장
		String sql ="INSERT INTO board(category_name, board_title,board_content,board_pw,create_date,update_date) VALUES(?,?,?,?,NOW(),NOW())";
		stmt = conn.prepareStatement(sql); //쿼리문 실행 저장
		//?에 값 저장
		stmt.setString(1, board.getCategoryName());
		stmt.setString(2, board.getBoardTitle());
		stmt.setString(3, board.getBoardContent());
		stmt.setString(4, board.getBoardPw());
		
		int row = stmt.executeUpdate(); //입력된 행의 수
		//디버깅
		if(row ==1) {
			System.out.println("입력성공");
		}else {
			System.out.println("입력실패");
		}
		stmt.close();
		conn.close();
	}
	//8.수정
	//updateForm
	public int updateForm(Board board) throws Exception {
		//드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		//db접속
		conn = DriverManager.getConnection("jdbc:mariadb://3.34.127.124:3306/blog","root","java1234");
		//쿼리문 저장
		String sql="UPDATE board SET category_name =?, board_title = ?, board_content = ?, update_date = NOW()  WHERE board_no = ? AND board_pw = ?";
		stmt= conn.prepareStatement(sql);
		stmt.setString(1, board.getCategoryName());
		stmt.setString(2, board.getBoardTitle());
		stmt.setString(3, board.getBoardContent());
		stmt.setInt(4, board.getBoardNo());
		stmt.setString(5, board.getBoardPw());
		
		int row = stmt.executeUpdate(); //몇행인지 리턴
		if(row == 1) {
			System.out.println("수정성공");
		}else {
			System.out.println("수정실패");
		}
		
		stmt.close();
		conn.close();
		
		return row;
	}
	//9.삭제
	public int deleteBoard(int boardNo, String boardPw) throws Exception {
		int row= 0;
		
		//드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		//db접속
		conn = DriverManager.getConnection("jdbc:mariadb://3.34.127.124:3306/blog","root","java1234");
		
		//쿼리문 저장
		String sql="DELETE FROM board WHERE board_no=? and board_pw =?";
		stmt= conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		stmt.setString(2, boardPw);
		System.out.println("delete Stmt:" + stmt);
		row=stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
		
	}
	
}