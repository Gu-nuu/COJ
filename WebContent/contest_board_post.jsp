<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공모전 게시판 게시글</title>
<link rel="stylesheet" type="text/css" href="css/contest_board_post_style.css">
</head>
<body>
<%@ include file = "uservalid.jsp" %>
<%@ include file = "navbar.jsp" %>
<%
	String id = request.getParameter("id");

	Connection conn = null;
	Statement stmt = null, for_user=null;
	ResultSet rs = null, user=null;
	String title="", writer="", writer_id="", content ="", image="", time="";
	int heart=0, reply=0;
	
	String r_writer="", r_writer_id="", r_content=""; 
	int r_heart=0, r_reply=0;
	
	String id_right="";

	try{
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcurl = "jdbc:mysql://localhost:3306/cse_community?serverTimezone=UTC";
			conn = DriverManager.getConnection(jdbcurl, "root", "0000");
			stmt = conn.createStatement();
			for_user = conn.createStatement();
			String sql = "select * from contest where id='"+id+"'and id = ref";
			rs = stmt.executeQuery(sql);
	}
	catch(Exception e){
		out.println("DB 연동 오류입니다.:" + e.getMessage());
	}
	
	while(rs.next())
	{
		title = rs.getString("title");
		writer = rs.getString("writer");
		writer_id = rs.getString("writer_id");
		content = rs.getString("content");
		image = rs.getString("image");
		time = rs.getString("time");
		heart = rs.getInt("heart");
		reply = rs.getInt("reply");
	}
%>
    <div class="body-box">
        <div class="content">
            <div id="body-left" class="design">
                <div id="title" class="title-design">
                    <h1>스펙 UP!</h1>
                </div>
                <div id="user-info" class="clearfix">
                    <div class="noline-design user-name">작성자 : <%=writer %></div>
                    <% 
                    	if(session.getAttribute("id") != null)
                    	{                    		
                    		if(session.getAttribute("id").toString().equals(writer_id))
                    		{ 
                    			%>
                    			<div class="btn-contest" name="delete" onclick="del('<%=id%>')"><a>삭제:❌</a></div><!--href 채워주세요!-->
                    			<div class="btn-contest" name="modify" onclick="linked('contest_board_modify.jsp?id=<%=id%>')"><a>수정:✍</a></div><!--href 채워주세요!-->
                    <%		}
                    	}		%>                                     
                    <div class="noline-design">작성날짜 : <%=time %></div>
                </div>
                <div id="post" class="design">
                    <div id="post-title"><%=title %></div>
                    <div id="post-content"><%=content %></div>
                    <div id="pic-align">
                        <div id="pic">
                            <div class="pic-design clearfix">
                                <img style="width:100%;" src="contest/<%=image %>" onerror="this.style.display='none';"/><!--src 채워주세요!-->
                            </div>                           
                        </div>
                    </div>
                    <br><!--form....?-->
                    <div id="count" class="clearfix">
                        <div class="info-design-left noline-design">좋아요 <%=heart %></div>
                        <div class="info-design-left noline-design">댓글 <%=reply %></div>                         
                        <div class="btn-contest" name="heart"><a href="contest_heart-db.jsp?id=<%=id%>">좋아요👍</a></div><!--href 채워주세요!-->                                         
                    </div>
                </div>
                <form action="contest_reply_insert-db.jsp" method="post"><!--form 채워주세요!-->
                    <div id="write" class="design clearfix">
                        <div id="user-info" class="clearfix">  
                        <%
                        	String user_id="";
                        	String user_name="";
                        	
                        	if(session.getAttribute("id")!=null)
                        	{
                        		user_id = session.getAttribute("id").toString();

                        		user = for_user.executeQuery("select * from user where id='"+user_id+"'");
                        		
                        		while(user.next())
                        		{	
                        			user_name = user.getString("name");
                        		}
                        	}
                        %>                   
                            <div class="write-username"><%=user_name %></div>
                        </div>
                        <div id="write-text">
                            <textarea name="content" placeholder="댓글을 입력해주세요" class="reply-design noline-design" rows="4" cols="85" required></textarea>
                        </div>
                        <input type="submit" id="reply-button" class="btn-contest" value="댓글달기"/>
                        <input type="hidden" name="ref" value="<%=id %>"/>
                        <input type="hidden" name="writer_id" value="<%=user_id %>"/>
                        <input type="hidden" name="writer" value="<%=user_name %>"/>
                    </div>
                </form>
                <%
                	rs = stmt.executeQuery("select * from contest where ref='"+id+"' and id != ref order by id asc");
                
                	while(rs.next())
                	{
                		r_writer = rs.getString("writer");
                		r_content = rs.getString("content");
                	
                %>
                <div id="reply-post" class="design clearfix">                    
                    <div id="user-info" class="clearfix">
                        <div class="write-username"><%=r_writer %></div>
                    </div>
                    <div id="show-reply" class="design clearfix">
                       <%=r_content %>
                    </div>
                </div>
                <%  } %>
            </div>
            <div id="body-right" class="design">
                <div id="sidebar-title" class="title-design">
                    <h2>TOP 좋아요</h2>
                </div>
                <div class="list clearfix">
                <%
                	rs = stmt.executeQuery("select * from contest where id=ref order by heart desc limit 3");
                	while(rs.next())
                	{
                		id_right = rs.getString("id");
                		title = rs.getString("title");
                		image = rs.getString("image");
                		content = rs.getString("content");
                		writer = rs.getString("writer");
                		heart = rs.getInt("heart");
                		reply = rs.getInt("reply");
                	
                %>               
                    <div id="post-left" class="design" onclick="go_post(<%=id_right%>)">
                        <div id="inner" class="design clearfix">
                            <div id="inner-title" class="noline-design"><%=title %></div>
                            <div id="inner-pic" class="noline-design"><img style="width:100%;" src="contest/<%=image%>" onerror="this.style.display='none'"></div>
                            <div id="inner-text" class="noline-design"><%=content %></div>
                        </div>
                        <div id="inner-info" class="clearfix">
                            <div class="info-design-left noline-design"><%=writer %></div>
                            <div class="info-design-right noline-design" style="color:rgb(204,102,51);">🗨 <%=reply %> </div>
                            <div class="info-design-right noline-design">👍 <%=heart %></div>
                        </div>
                    </div>
                 <% } %>
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
	
	function linked(link){
		location.href = link;
	}
	
	function del(id){
		if(confirm("글을 삭제하시겠습니까?")){
			location.href="contest_board_delete.jsp?id="+id;
		}
	}
</script>
</html>