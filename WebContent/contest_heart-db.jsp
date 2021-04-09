<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>
</head>
<body>
	<%
		boolean duplication = false;
		String user_id="", type="", post_id="", sql; 
		int new_id=0, new_heart=0;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		user_id = session.getAttribute("id").toString(); //좋아요 누른 사람(현재 로그인 중인 사람) 아이디
		post_id = request.getParameter("id"); //게시글 아이디
		type = "contest"; //-------------------------------------------게시판 이름 넣기
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcurl = "jdbc:mysql://localhost:3306/cse_community?serverTimezone=UTC";
			conn = DriverManager.getConnection(jdbcurl,"root","0000");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			sql = "select * from hearts where type='"+type+"' and post_id='"+post_id+"'";
			rs = stmt.executeQuery(sql);
					
		}
		catch(Exception e) {
		   out.println("DB 연동 오류입니다.:"+e.getMessage());
		}
		
		while(rs.next())
		{
			if(user_id.equals(rs.getString("user_id")))
			{
				duplication = true;
				break;
	   		}
		}   

		if(!duplication)
		{ 
			sql = "select max(id) as max_id from hearts";
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				new_id = rs.getInt("max_id");
			}
			new_id++;
			sql = "insert into hearts value('"+new_id+"', '"+type+"', '"+post_id+"','"+user_id+"')";
			stmt.executeUpdate(sql);
			
			sql = "select * from contest where id='"+post_id+"'";//-------------------테이블 이름 바꾸기
			rs = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				new_heart = rs.getInt("heart");
			}
			
			new_heart++;
			sql = "update contest set heart='"+new_heart+"' where id='"+post_id+"'";
			stmt.executeUpdate(sql);
			
			response.sendRedirect("contest_board_post.jsp?id="+post_id);
			
		}
		
		else
		{
			%>
			<script>
				alert("이미 좋아요를 누르셨습니다.");
				location.href = "contest_board_post.jsp?id=<%=post_id%>";
			</script>
			<% 
		}%>
		
</body>
</html>