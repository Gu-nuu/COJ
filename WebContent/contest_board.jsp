<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head><title>공모전 게시판 페이지</title></head>
    <link rel="stylesheet" type="text/css" href="css/contest_board_style.css">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>
    <body>
    <%@ include file = "navbar.jsp" %>
    <%
    	int id=0, ref=0, heart, reply;
    	String sql, title, writer, writer_id, content, image, time;
    	Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		if(request.getParameter("id") != null )
			id = Integer.parseInt(request.getParameter("id"));
		
		int id2 = id+8;
    
    	try{
			Class.forName("com.mysql.jdbc.Driver");
   			String jdbcurl = "jdbc:mysql://localhost:3306/cse_community?serverTimezone=UTC";
   			conn = DriverManager.getConnection(jdbcurl, "root", "0000");
   			stmt = conn.createStatement();
   			sql = "select * from contest where id=ref order by id desc limit "+id+", "+id2;
   			rs = stmt.executeQuery(sql);
		}
		catch(Exception e){
			out.println("DB 연동 오류입니다.:" + e.getMessage());
		}
    %>
        <div id="body-box">
            <div class="content">
                <div id="body-left" class="design clearfix">
                	<div class="inner-content">
                		<div class="title">
                    	<div id="head-title" class="head-title-design">
                        	<h1>스펙 UP!</h1>
                    	</div>
                    	</div>
                    <div class="clearfix">
                        <div id="head-new" class="btn-contest button">
                            <a href="contest_board_insert.jsp">글 작성</a>
                        </div>
                    </div>
                    <div id="list" class="flex-container noline-design">
                            <%
                            	while(rs.next())
                            	{
                            		id = rs.getInt("id");
                            		ref = rs.getInt("ref");
                            		title = rs.getString("title");
                            		writer = rs.getString("writer");
                            		writer_id = rs.getString("writer_id");
                            		content = rs.getString("content");
                            		image = rs.getString("image");
                            		time = rs.getString("time"); 
                            		heart = rs.getInt("heart");
                            		reply = rs.getInt("reply");
                            %>
                            <div class="design post" onclick="go_post(<%=id %>)">
                            <div class="clearfix">
                            	<div class="head">
                                <div id="post-title" class="noline-design text">
                                    <%=title %>
                                </div>
                                </div>
                                <div id="post-image">                              
                                    <img style="width:100%;" src="contest/<%=image%>" onerror="this.style.display='none';">                              
                                </div>
                                <div id="post-text" class="noline-design text">
                                    <%=content %>
                                </div>
                                <div id="info" class="clearfix">
                                    <div id="post-time" class="noline-design info-left text"><%=time %></div>
                                    <div id="post-writer" class="noline-design info-left text"><%=writer %></div>
                                    <div id="post-reply" class="noline-design info-right" style="color:rgb(204,102,51);">🗨 <%=reply %></div>
                                    <div id="post-liked" class="noline-design info-right">👍 <%=heart %></div>
                                    
                                </div>
                            
                            </div>
                        </div>
                        <%
                            } 
                        %>
                    </div>
                    <div class="clearfix">
                        <div id="next" class="button btn-contest" onclick="go_next(<%=id2%>)">
                           	 다음
                        </div>
                    </div>                  
                </div>
             </div>
                <div id="body-right" class="box noline-design">
                    <div id="head-title" class="head-title-design">
                        <h2>좋아요 TOP</h2>
                    </div>
                    <br>
                    <div id="list">
               		<% 
               			sql = "select * from contest where id=ref order by heart desc";
               			rs = stmt.executeQuery(sql);
               		
               			while(rs.next()&&rs.getRow()<=3)
               			{
               				id = rs.getInt("id");
                			ref = rs.getInt("ref");
                			title = rs.getString("title");
                			writer = rs.getString("writer");
                			writer_id = rs.getString("writer_id");
                			content = rs.getString("content");
                			image = rs.getString("image");
                			time = rs.getString("time"); 
                			heart = rs.getInt("heart");
                			reply = rs.getInt("reply");
               		%>
                    	<div id="post" class="design" onclick="go_post(<%=id%>)">
                        	<div id="inner-title" class="noline-design text">
                            	<%=title %>
                        	</div>
                        <div id="post-image" class="">
                        	<img style="width:100%;" src="contest/<%=image%>" onerror="this.style.display='none';">
                        </div>
                        <div id="post-text" class="noline-design ">
                           		 <%=content %>
                        </div>
                        <div id="info" class="clearfix">
                            <div id="post-writer" class="noline-design info-left"><%=writer %></div>
                            <div id="post-reply" class="noline-design info-right" style="color:rgb(204,102,51);">🗨 <%=reply %></div>
                            <div id="post-liked" class="noline-design info-right">👍 <%=heart %></div>
                        </div>
                    </div>
                    <%
               			}
                    %>
                    </div>
                </div>
            </div>
        </div>
       <%@include file = "footer.jsp" %>
    </body>
    <script>
        function go_post(id) {
            location.href = "contest_board_post.jsp?id="+id;
        }       
        function go_next(id2) {
        	location.href = "contest_board.jsp?id="+id2;
        }
    </script>
</html>