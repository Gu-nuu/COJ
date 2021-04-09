<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<%
		String ref, writer, writer_id, content;
		
		String sql;
		ref = request.getParameter("ref");
		writer = session.getAttribute("name").toString();
		writer_id = session.getAttribute("id").toString();
		content = request.getParameter("reply");
		int new_id = 0;
		int new_reply = 0;
		
		Connection conn=null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try{
			Class.forName("com.mysql.jdbc.Driver");
   			String jdbcurl = "jdbc:mysql://localhost:3306/cse_community?serverTimezone=UTC";
   			conn = DriverManager.getConnection(jdbcurl, "root", "0000");
   			stmt = conn.createStatement();
   			sql = "select max(id) as max_id , count(*) as cnt from question";
   			rs = stmt.executeQuery(sql);
		}
		catch(Exception e){
			out.println("DB 연동 오류입니다.:" + e.getMessage());
		}
		
		while(rs.next())
		{
			if(rs.getInt("cnt") != 0)
			{
				new_id = rs.getInt("max_id");
			}
		}
		
		new_id++;
		sql = "insert into question values("+new_id+", '"+ref+"', NULL, '"+writer+"','"+writer_id+"', '"+content+"', NULL, NULL, NULL, NULL)";
		
		try{
			stmt.executeUpdate(sql);
		}
		catch(Exception e){
			out.println("DB 연동 오류입니다.:" + e.getMessage());
		}
		
		sql = "select reply from question where id='"+ref+"'";
		
		try{
			rs = stmt.executeQuery(sql);
		}
		catch(Exception e){
			out.println("DB 연동 오류입니다.:" + e.getMessage());
		}
		
		while(rs.next())
			new_reply = rs.getInt("reply");
		
		new_reply++;
		out.print(new_reply);
		sql = "update question set reply='"+new_reply+"' where id = '"+ref+"' and id = ref";
		
		try{
			stmt.executeUpdate(sql);
		}
		catch(Exception e){
			out.println("DB 연동 오류입니다.:" + e.getMessage());
		}
		
		response.sendRedirect("question_board_post.jsp?id="+ref);
	%>
</body>
</html>