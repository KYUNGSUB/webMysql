<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%! 
	private static final String DRIVER_CLASS = "com.mysql.cj.jdbc.Driver"; // MySQL Java JDBC 드라이버 클래스
	private static final String URL = "jdbc:mysql://localhost:3306/madang?serverTimeZone=Asia/Seoul";
	private static final String USERNAME = "madang";
	private static final String PASSWORD = "madang";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마당서점 도서목록</title>
<style>
	table {
		border-collapse: collapse;
	}
	td, th {
		padding: 10px;
	}
</style>
</head>
<body>
	<h1>마당서점 도서목록</h1>
	<table border=1>
		<tr>
			<th>bookid</th>
			<th>bookname</th>
			<th>publisher</th>
			<th>price</th>
		</tr>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try {
		//1. JDBC 드라이버 클래스를 가져온다. 드라이버 객체를 로딩
		Class.forName(DRIVER_CLASS);
		//2. DBMS에 접속을 해서 Connection을 획득
		conn = DriverManager.getConnection(URL, USERNAME, PASSWORD); // 로그인해서 접속을 하나 만든다.
		//3. Statement 객체를 얻어 온다.
		stmt = conn.createStatement(); // SQL을 작성할 수 있는 클래스를 얻는다.
		//4. 질의를 해서 결과를 가져온다.
		rs = stmt.executeQuery("select * from book"); // DBMS에 질의를 하고 결과가 rs에 저장됨
		while (rs.next()) { // 가지고 온 모든 튜플(열)에 대하여 반복 : rs.next()가 null일 때까지 반복 실행
%>
		<tr>
<%
			int bookid = rs.getInt(1); // 첫번째 컬럼의 정보를 얻어 온다.
			String bookname = rs.getString(2);
			String publisher = rs.getString(3);
			int price = rs.getInt(4);
			System.out.printf("%3d%20s\t%s\t%d\n", bookid, bookname, publisher, price); // console 창에 출력
%>
			<td><%= bookid %></td>
			<td><%= bookname %></td>
			<td><%= publisher %></td>
			<td><%= price %></td>
		</tr>
<%
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) {
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
%>
	</table>
</body>
</html>