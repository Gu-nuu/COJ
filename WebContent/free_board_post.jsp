<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 게시글</title>
<link rel="stylesheet" type="text/css" href="css/free_board_post_style.css">
</head>
<body>
<%@ include file="uservalid.jsp" %>
<%@ include file="navbar.jsp"%>
<%
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		String sql = "";
		int count=0;
		int i=Integer.parseInt(request.getParameter("id"));
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcurl = "jdbc:mysql://localhost:3306/cse_community?serverTimezone=UTC";
			conn = DriverManager.getConnection(jdbcurl,"root","0000");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			sql="select count(*) as cnt from free where ref="+i;
			rs=stmt.executeQuery(sql);
			rs.next();
			count = rs.getInt("cnt");
			count-=1;
			sql="select * from free where ref="+i+" order by id asc";
			rs=stmt.executeQuery(sql);
		}
		catch(Exception e) {
		   out.println("DB 연동 오류입니다.:"+e.getMessage());
		}
		
		if(!rs.next()){
			
			%><script>alert("잘못된 접근");
				location.href="free_board.jsp";</script><%
		}
		if(rs.getString("title")==null){
			%><script>alert("잘못된 접근");
			location.href="free_board.jsp";</script><%
		}
	%>
    <div class="body-box">
        <div class="content">
            <div id="body-left" class="design">
                <div id="title" class="title-design">
                    <h1>오늘도 밤새니?</h1>
                </div>
                <div id="user-info" class="clearfix">
                    <div class="noline-design user-name"><%=rs.getString("writer") %></div>
                    <%if(session.getAttribute("id")!=null && session.getAttribute("id").equals(rs.getString("writer_id"))){%>
                    <div class="btn-2" name="delete" onclick="del('<%=rs.getInt("id")%>')"><a>삭제❌</a></div><!--href 채워주세요!-->
                    <div class="btn-2" name="modify" onclick="linked('free_board_modify.jsp?id=<%=rs.getInt("id")%>')"><a>수정✍</a></div><!--href 채워주세요!-->
                    <%} %><div class="noline-design"><%=rs.getString("time") %></div>
                </div>
                <div id="post" class="design">
                    <div id="post-title"><%=rs.getString("title") %></div>
                    <div id="post-content"><%=rs.getString("content") %></div>
                    <div id="pic-align">
                        <div id="pic">
                            <div class="pic-design noline-design clearfix">
                                <img style="width:100%;"src="free/<%=rs.getString("image")%>" onerror="this.style.display='none'"/>
                            </div>
                        </div>
                    </div>
                    <br><!--form....?-->
                    <div id="count" class="clearfix">
                        <div class="info-design-left noline-design">좋아요 <%=rs.getInt("heart") %></div>
                        <div class="info-design-left noline-design">댓글 <%=count %></div>
                        <div class="btn-2" name="heart"><a href="free_heart-db.jsp?id=<%=i %>">좋아요👍</a></div><!--href 채워주세요!-->
                    </div>
                </div>
                <form action="free_board_reply.jsp" method="post">
                    <div id="write" class="design clearfix">
                        <div id="user-info" class="clearfix">
                            <div class="write-username"><% if(session.getAttribute("name")!=null) {%><%=session.getAttribute("name")%><%} %></div>
                        </div>
                        <div id="write-text">
                            <textarea name="reply" placeholder="댓글을 입력해주세요" class="reply-design noline-design" rows="4" cols="85" required></textarea>
                        </div>
                        <div><input  type="submit" id="reply-button" class="btn-2"value="댓글 달기"></div>
                        <input type="hidden" name="ref" value="<%=i%>">
                    </div>
                </form>
                <%
                	while(rs.next()){
                %>
                <div id="reply-post" class="design clearfix">
                    <div id="user-info" class="clearfix">
                        <div class="write-username"><%=rs.getString("writer") %></div>
                    </div>
                    <div id="show-reply" class="design clearfix">
                       	 <%=rs.getString("content") %>
                    </div>
                </div>
                <%}%>
            </div>
            <%
            sql="select * from free where id=ref order by heart desc ";
            rs = stmt.executeQuery(sql);
            int id=0;
        	int ref;
        	String title,writer,writer_id,content,image,time;
        	int heart,reply;
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
                            <div class="info-design-right noline-design" style="color:rgb(204,102,51);" >🗨 <%= reply %></div>
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
    	function del(id){
    		if(confirm("글을 삭제하시겠습니까?")){
    			location.href="free_board_delete.jsp?id="+id;
    		}
    	}
    </script>
</body>
</html>