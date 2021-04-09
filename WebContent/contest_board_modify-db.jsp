<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    // 파일이 저장되는 경로
    String path = getServletContext().getRealPath("contest");
%>

<%
    int size = 1024 * 1024 * 10; // 저장가능한 파일 크기
    String file = ""; // 업로드 한 파일의 이름(이름이 변경될수 있다)
    String originalFile = ""; // 이름이 변경되기 전 실제 파일 이름
    MultipartRequest  multi = null;
    // 실제로 파일 업로드하는 과정
    try{
        multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

        Enumeration files = multi.getFileNames();
        String str = (String)files.nextElement(); // 파일 이름을 받아와 string으로 저장

        file = multi.getFilesystemName(str); // 업로드 된 파일 이름 가져옴
        originalFile = multi.getOriginalFileName(str); // 원래의 파일이름 가져옴

    } catch (Exception e) {
        e.printStackTrace();
    }

%>
<%
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	String sql_update;
	
	String id = multi.getParameter("id");
	
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcurl = "jdbc:mysql://localhost:3306/cse_community?serverTimezone=UTC";
			conn = DriverManager.getConnection(jdbcurl,"root","0000");
			stmt = conn.createStatement();
			String sql = "select * from contest where id='"+id+"'";
			rs = stmt.executeQuery(sql);
			
		}
		catch(Exception e) {
		   out.println("DB 연동 오류입니다.:"+e.getMessage());
		}
		
		if(file==null)
		{
			sql_update= "update contest set title='"+multi.getParameter("title")+"', content='"+multi.getParameter("content")+"' where id = '"+id+"'";
		}
		else
		{
			sql_update= "update contest set title='"+multi.getParameter("title")+"', content='"+multi.getParameter("content")+"', image='"+file+"' where id = '"+id+"'";
		}
		
		
		try {
			stmt.executeUpdate(sql_update);		
		}
		catch(Exception e) {
		   out.println("DB 연동 오류입니다.:"+e.getMessage());
		}
		
%>

<script>
	location.href = "contest_board_post.jsp?id=<%=id%>";
</script>
</body>
</html>