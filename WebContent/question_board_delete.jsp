<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
	<%
		int id;
		String passwd = "", sql, sql1;
		Connection conn = null;
		Statement stmt = null;
		
		id=Integer.parseInt(request.getParameter("id"));
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/cse_community?serverTimezone=UTC";
			conn = DriverManager.getConnection(url,"root","0000");
			stmt = conn.createStatement();
			
				
			sql1="delete from question where ref="+request.getParameter("id");
			stmt.executeUpdate(sql1);
		}
		catch(Exception e){
			out.println("DB 연동 오류입니다.:"+e.getMessage());
		}
	%>
	<script>
		alert("삭제되었습니다.");
		location.href="question_board.jsp";
	</script>
</body>
</html>