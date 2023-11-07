package javaMysql;

import java.sql.Connection; // BookList 클래스에 없는 클래스를 사용하려면 사용하려는 클래스가 어디에
// 있는지 자세한 경로를 알려주어야 한다.(JDK에 있는 라이브러리에 있는 클래스)
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

//실행 클래스 : main() 메소드가 있는 클래스
//Run As-> 2. Java Application 메뉴를 선택하면 Java 실행클래스를 실행할 수 있다.

public class BookList {
	private static final String DRIVER_CLASS = "com.mysql.cj.jdbc.Driver"; // MySQL Java JDBC 드라이버 클래스
	private static final String URL = "jdbc:mysql://localhost:3306/madang?serverTimeZone=Asia/Seoul";
	private static final String USERNAME = "madang";
	private static final String PASSWORD = "madang";

	public static void main(String[] args) { // 프로그램의 시작과 종료
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
// 1. JDBC 드라이버 클래스를 가져온다. 드라이버 객체를 로딩
			Class.forName(DRIVER_CLASS); // JDBC 클래스를 정의
// 2. DBMS에 접속을 해서 Connection을 획득
			conn = DriverManager.getConnection(URL, USERNAME, PASSWORD); // 로그인해서 접속을 하나 만든다.
// 3. Statement 객체를 얻어 온다.
			stmt = conn.createStatement(); // SQL을 작성할 수 있는 클래스를 얻는다.
// 4. 질의를 해서 결과를 가져온다.
			rs = stmt.executeQuery("select * from book"); // DBMS에 질의를 하고 결과가 rs에 저장됨
			while (rs.next()) { // 가지고 온 모든 튜플(열)에 대하여 반복 : rs.next()가 null일 때까지 반복 실행
				int bookid = rs.getInt(1); // 첫번째 컬럼의 정보를 얻어 온다.
				String bookname = rs.getString(2);
				String publisher = rs.getString(3);
				int price = rs.getInt(4);
//Book book = new Book(bookid, bookname, publisher, price);	// 도서 정보가 저장이 된다.
// 지금은 불필요 -> 나중에 사용
				System.out.printf("%2d %-20s%-20s%d\n", bookid, bookname, publisher, price);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) { // 자원 반납
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}