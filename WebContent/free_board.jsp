<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<title>자유게시판</title>
<link rel="stylesheet" type="text/css" href="css/free_board_style.css">
<script src ="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function free_f(link){
		location.href=link;
	}
</script>
</head>

<body>
	<%
	int id=0;
	int ref;
	String title,writer,writer_id,content,image,time;
	int heart,reply;
	String sql=null;
    Connection conn =null;
    Statement stmt = null;
    ResultSet rs=null;
    if(request.getParameter("id")!=null)
    	id=Integer.parseInt(request.getParameter("id"));
    int id2=id+10;
    try{
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcurl = "jdbc:mysql://localhost:3306/cse_community?serverTimezone=UTC";
        conn = DriverManager.getConnection(jdbcurl,"root","0000");
        stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        sql="select * from free where id=ref order by id desc limit "+id+", "+id2;
        rs = stmt.executeQuery(sql);
     }catch(Exception e){
        out.print("DB 연동 오류입니다.:" + e.getMessage());
    }
    %>
    
    <%@ include file="navbar.jsp"%>
	
    <div class="body-box">
        <div class="content">
            <div id="body-left" class="design">
                <div id="title" class="title-design">
                    <h1>오늘도 밤새니?</h1>
                </div>
                <div id="write-button" class="clearfix">
                    <div class="btn-2"><a href="free_board_insert.jsp">글 작성</a></div>
                </div>
                <div class="list noline-design">
                <%
                while(rs.next())
                {
                	id=Integer.parseInt(rs.getString("id"));
                	ref=Integer.parseInt(rs.getString("ref"));
                	title=rs.getString("title");
                	writer=rs.getString("writer");
                	writer_id=rs.getString("writer_id");
                	content=rs.getString("content");
                	image=rs.getString("image");
                	time=rs.getString("time");
                	heart=rs.getInt("heart");
                	reply=rs.getInt("reply");
                %>
                    <div id="post-right" class="design" onclick="free_f('free_board_post.jsp?id=<%=id%>')">
                        <div id="inner" class="noline-design clearfix">
                            <div id="inner-title" class="noline-design"><%= title %></div>
                            <div class="noline-design"><img src="free/<%= image %>" onerror="this.style.display='none';" id="pic"/></div>
                            <div id="inner-text" class="noline-design"><%= content %></div>
                        </div>
                        <div id="info clearfix">
                            <div class="info-design-left noline-design"><%= time %></div>
                            <div class="info-design-left noline-design"><%= writer %></div>
                            <div class="info-design-right noline-design" style="color:rgb(204,102,51);">🗨 <%= reply %></div>
                            <div class="info-design-right noline-design">👍 <%= heart %></div>
                        </div>
                    </div>
                <%
                }
                %>
                </div>
                <div id="move-button" class="clearfix">
                    <div class="btn-2"><a href="free_board.jsp?id=<%= id %>">다음</a></div>
                </div>
            </div>
            <%
            sql="select * from free where id=ref order by heart desc ";
            rs = stmt.executeQuery(sql);
            %>
            <div id="body-right" class="design">
                <div id="sidebar-title" class="title-design">
                    <h2>좋아요 TOP</h2>
                </div>
                <div class="list">
             <%
                while(rs.next() && rs.getRow()<=4)
                {
                	id=Integer.parseInt(rs.getString("id"));
                	ref=Integer.parseInt(rs.getString("ref"));
                	title=rs.getString("title");
                	writer=rs.getString("writer");
                	writer_id=rs.getString("writer_id");
                	content=rs.getString("content");
                	time=rs.getString("time");
                	heart=rs.getInt("heart");
                	reply=rs.getInt("reply");
             %>
                    <div id="post-left" class="design" onclick="linked('free_board_post.jsp?id=<%=id %>')">
                        <div id="inner" class="design clearfix">
                            <div id="inner-title" class="noline-design"><%= title %></div>
                            <div id="inner-text" class="noline-design"><%= content %></div>
                        </div>
                        <div id="info clearfix">
                            <div class="info-design-left noline-design"><%= writer %></div>
                            <div class="info-design-right noline-design" style="color: rgb(204,102,51);">🗨 <%= reply %></div>
                            <div class="info-design-right noline-design">👍 <%= heart %></div>
                        </div>
                    </div>
                <%
                }
                %>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="footer.jsp" %>
    <script>
    	function linked(link){
    		location.href=link;
    	}
    </script>
</body>

</html>