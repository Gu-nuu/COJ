<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>명예의 전당</title>
<link rel="stylesheet" type="text/css" href="css/fame_hall_style.css">
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<%
		String sql;
		String most_heart="", most_post="", most_reply="", temp_id="",its_name="";
		Connection conn = null;
		Statement stmt = null, for_user = null;
		ResultSet rs = null, user = null;
		
		int i=0, max=-1, temp_max=0;
	
		try{
			Class.forName("com.mysql.jdbc.Driver");
				String jdbcurl = "jdbc:mysql://localhost:3306/cse_community?serverTimezone=UTC";
				conn = DriverManager.getConnection(jdbcurl, "root", "0000");
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				for_user = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				user = for_user.executeQuery("select * from user");
		}
		catch(Exception e){
			out.println("DB 연동 오류입니다.:" + e.getMessage());
		}
		
	%>
    <div class="body-box">
        <div id="body-header" class="noline-design">
            <div id="title" class="title-design">
                <h1>명예의 전당</h1>
            </div>
        </div>
        <!--자유게시판 부분 --------------------------------------------------------->
        <div id="part" class="noline-design">
            <div id="inner-free" class="design">
                <div id="title-type" class="noline-design">
                    [ 오늘도 밤새니? ]
                </div>
                <div id="body-main">
                    <div id="body-left" class="noline-design">
                        <div class="inner-title">
                            <p>🏆이달의 댓글왕🏆</p>
                        </div>
                        <div class="inner-content-main noline-design">
                            <div class="first">
                                <img src="댓글.png" class="num-design noline-design img-margin-design">
                                <div class="user-emo noline-design">
                                    <h1>👑</h1>
                                </div>
                                <%
                                most_heart = null;
                                most_reply = null;
                                most_post = null;
                                its_name=null;
		                        	 rs = stmt.executeQuery("select * from free order by reply desc limit 1");
		                        	 while(rs.next())
		                        	 {
		                        		 most_reply = rs.getString("writer_id");
		                        	 }
		                        	
		                        	rs = stmt.executeQuery("select * from user where id='"+most_reply+"'");
		                        	while(rs.next())
		                        	{
		                        		its_name = rs.getString("name");
		                        	}
		                        %>
                                <div class="user-id noline-design id-margin-design">학번 : <%=most_reply %></div><!-- 학번 -->
                                <div class="user-name noline-design name-margin-design">이름 : <%=its_name %></div><!-- 이름 -->
                            </div>
                        </div>
                    </div>
                    <div id="body-center" class="noline-design">
                        <div class="inner-title">
                            <p>🏆이달의 좋아요왕🏆</p>
                        </div>
                        <div class="inner-content-main noline-design">
                            <div class="first">
                                <img src="좋아요.png" class="num-design noline-design img-margin-design">
                                <div class="user-emo noline-design">
                                    <h1>👑</h1>
                                </div>
                                <%
                                most_heart = null;
                                most_reply = null;
                                most_post = null;
                                its_name=null;
		                        	 rs = stmt.executeQuery("select * from free order by heart desc limit 1");
		                        	 while(rs.next())
		                        	 {
		                        		 most_heart = rs.getString("writer_id");
		                        	 }
		                        	
		                        	rs = stmt.executeQuery("select * from user where id='"+most_heart+"'");
		                        	while(rs.next())
		                        	{
		                        		its_name = rs.getString("name");
		                        	}
		                        %>
                                <div class="user-id noline-design id-margin-design">학번 : <%=most_heart %></div><!-- 학번 -->
                                <div class="user-name noline-design name-margin-design">이름 : <%=its_name %></div><!-- 이름 -->
                            </div>
                        </div>
                    </div>
                    <div id="body-right" class="noline-design">
                        <div class="inner-title">
                            <p>🏆이달의 게시글왕🏆</p>
                        </div>
                        <div class="inner-content-main noline-design">
                            <div class="first">
                                <img src="게시글.png" class="num-design noline-design img-margin-design">
                                <div class="user-emo noline-design">
                                    <h1>👑</h1>
                                </div>
                                <%      
                                most_heart = null;
                                most_reply = null;
                                most_post = null;
                                its_name=null;
                                max = -1;
                               	user.beforeFirst();
                               	if(stmt.executeQuery("select * from free").next() == true)
                               	{
		                        	while(user.next())
		                        	{
		                        		temp_id = user.getString("id");                       		
		                        		rs = stmt.executeQuery("select count(*) from free where id=ref and writer_id='"+temp_id+"'");
		                        		while(rs.next())
		                        		{
		                        			temp_max = rs.getInt("count(*)");
		                        		}
		                        		
		                        		if(max < temp_max)
		                        		{
		                        			max = temp_max;
		                        			most_post = temp_id;
		                        		}                        	
		                        	} 
		
		                        	if(most_post != null)
		                        	{
		                        		rs = stmt.executeQuery("select * from user where id='"+most_post+"'");
			                        	
			                        	while (rs.next())
			                        	{
			                        		its_name = rs.getString("name"); 
			                        	}
		                        	}
                               	}
		                        	%>
                                <div class="user-id noline-design id-margin-design">학번 : <%=most_post %></div><!-- 학번 -->
                                <div class="user-name noline-design name-margin-design">이름 : <%=its_name%></div><!-- 이름 -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--공모전 게시판 부분-------------------------------------------------------->
            <div id="inner-contest" class="design">
                <div id="title-type" class="noline-design">
                    [ 스펙 UP! ]
                </div>
                <div id="body-main">
                    <div id="body-left" class="noline-design">
                        <div class="inner-title">
                            <p>🏆이달의 댓글왕🏆</p>
                        </div>
                        <div class="inner-content-main noline-design">
                            <div class="first">
                                <img src="댓글.png" class="num-design noline-design img-margin-design">
                                <div class="user-emo noline-design">
                                    <h1>👑</h1>
                                </div>
                                <%
                                most_heart = null;
                                most_reply = null;
                                most_post = null;
                                its_name=null;
		                        	 rs = stmt.executeQuery("select * from contest order by reply desc limit 1");
		                        	 while(rs.next())
		                        	 {
		                        		 most_reply = rs.getString("writer_id");
		                        	 }
		                        	
		                        	rs = stmt.executeQuery("select * from user where id='"+most_reply+"'");
		                        	while(rs.next())
		                        	{
		                        		its_name = rs.getString("name");	
									}
		                        %>
                                <div class="user-id noline-design id-margin-design">학번 : <%=most_reply %></div><!-- 학번 -->
                                <div class="user-name noline-design name-margin-design">이름 : <%=its_name %></div><!-- 이름 -->
                            </div>
                        </div>
                    </div>
                    <div id="body-center" class="noline-design">
                        <div class="inner-title">
                            <p>🏆이달의 좋아요왕🏆</p>
                        </div>
                        <div class="inner-content-main noline-design">
                            <div class="first">
                                <img src="좋아요.png" class="num-design noline-design img-margin-design">
                                <div class="user-emo noline-design">
                                    <h1>👑</h1>
                                </div>
                                <%
                                most_heart = null;
                                most_reply = null;
                                most_post = null;
                                its_name=null;
		                        	 rs = stmt.executeQuery("select * from contest order by heart desc limit 1");
		                        	 while(rs.next())
		                        	 {
		                        		 most_heart = rs.getString("writer_id");
		                        	 }
		                        	
		                        	rs = stmt.executeQuery("select * from user where id='"+most_heart+"'");
		                        	while(rs.next())
		                        	{
		                        		its_name = rs.getString("name");
		                        	}
		                        %>
                                <div class="user-id noline-design id-margin-design">학번 : <%=most_heart %></div><!-- 학번 -->
                                <div class="user-name noline-design name-margin-design">이름 : <%=its_name %></div><!-- 이름 -->
                            </div>
                        </div>
                    </div>
                    <div id="body-right" class="noline-design">
                        <div class="inner-title">
                            <p>🏆이달의 게시글왕🏆</p>
                        </div>
                        <div class="inner-content-main noline-design">
                            <div class="first">
                                <img src="게시글.png" class="num-design noline-design img-margin-design">
                                <div class="user-emo noline-design">
                                    <h1>👑</h1>
                                </div>
                                <%      
                                most_heart = null;
                                most_reply = null;
                                most_post = null;
                                its_name=null;
                                max = -1;
                                user.beforeFirst();
                                if(stmt.executeQuery("select * from contest").next() == true)
                               	{
		                        	while(user.next())
		                        	{
		                        		temp_id = user.getString("id");                       		
		                        		rs = stmt.executeQuery("select count(*) from contest where id=ref and writer_id='"+temp_id+"'");
		                        		while(rs.next())
		                        		{
		                        			temp_max = rs.getInt("count(*)");
		                        		}
		                        		
		                        		if(max < temp_max)
		                        		{
		                        			max = temp_max;
		                        			most_post = temp_id;
		                        		}                        	
		                        	} 
		
		                        	if(most_post != null)
		                        	{
		                        		rs = stmt.executeQuery("select * from user where id='"+most_post+"'");
			                        	
			                        	while (rs.next())
			                        	{
			                        		its_name = rs.getString("name"); 
			                        	}
		                        	}	
                               	}
		                        %>
                                <div class="user-id noline-design id-margin-design">학번 : <%=most_post %></div><!-- 학번 -->
                                <div class="user-name noline-design name-margin-design">이름 : <%=its_name%></div><!-- 이름 -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--예제문제 게시판 부분-------------------------------------------------------->
            <div id="inner-question" class="design">
                <div id="title-type" class="noline-design">
                    [ 지능 UP! ]
                </div>
                <div id="body-main">
                    <div id="body-left" class="noline-design">
                        <div class="inner-title">
                            <p>🏆이달의 댓글왕🏆</p>
                        </div>
                        <div class="inner-content-main noline-design">
                            <div class="first">
                                <img src="댓글.png" class="num-design noline-design img-margin-design">
                                <div class="user-emo noline-design">
                                    <h1>👑</h1>
                                </div>
                                <%
                                most_heart = null;
                                most_reply = null;
                                most_post = null;
                                its_name=null;
		                        	 rs = stmt.executeQuery("select * from question order by reply desc limit 1");
		                        	 while(rs.next())
		                        	 {
		                        		 most_reply = rs.getString("writer_id");
		                        	 }
		                        	
		                        	rs = stmt.executeQuery("select * from user where id='"+most_reply+"'");
		                        	while(rs.next())
		                        	{
		                        		its_name = rs.getString("name");
		                        	}
		                        %>
                                <div class="user-id noline-design id-margin-design">학번 : <%=most_reply %></div><!-- 학번 -->
                                <div class="user-name noline-design name-margin-design">이름 : <%=its_name %> </div><!-- 이름 -->
                            </div>
                        </div>
                    </div>
                    <div id="body-center" class="noline-design">
                        <div class="inner-title">
                            <p>🏆이달의 좋아요왕🏆</p>
                        </div>
                        <div class="inner-content-main noline-design">
                            <div class="first">
                                <img src="좋아요.png" class="num-design noline-design img-margin-design">
                                <div class="user-emo noline-design">
                                    <h1>👑</h1>
                                </div>
                                <%
                                most_heart = null;
                                most_reply = null;
                                most_post = null;
                                its_name=null;
		                        	 rs = stmt.executeQuery("select * from question order by heart desc limit 1");
		                        	 while(rs.next())
		                        	 {
		                        		 most_heart = rs.getString("writer_id");
		                        	 }
		                        	
		                        	rs = stmt.executeQuery("select * from user where id='"+most_heart+"'");
		                        	while(rs.next())
		                        	{
		                        		its_name = rs.getString("name");
		                        	}
		                        %>
                                <div class="user-id noline-design id-margin-design">학번 : <%=most_heart %></div><!-- 학번 -->
                                <div class="user-name noline-design name-margin-design">이름 : <%=its_name %></div><!-- 이름 -->
                            </div>
                        </div>
                    </div>
                    <div id="body-right" class="noline-design">
                        <div class="inner-title">
                            <p>🏆이달의 게시글왕🏆</p>
                        </div>
                        <div class="inner-content-main noline-design">
                            <div class="first">
                                <img src="게시글.png" class="num-design noline-design img-margin-design">
                                <div class="user-emo noline-design ">
                                    <h1>👑</h1>
                                </div>
                                <%    
                                most_heart = null;
                                most_reply = null;
                                most_post = null;
                                its_name=null;
                                max = -1;
                                user.beforeFirst();
                                if(stmt.executeQuery("select * from question").next() == true)
                               	{
		                        	while(user.next())
		                        	{
		                        		temp_id = user.getString("id");                       		
		                        		rs = stmt.executeQuery("select count(*) from question where id=ref and writer_id='"+temp_id+"'");
		                        		while(rs.next())
		                        		{
		                        			temp_max = rs.getInt("count(*)");
		                        		}
		                        		
		                        		if(max < temp_max)
		                        		{
		                        			max = temp_max;
		                        			most_post = temp_id;
		                        		}                        	
		                        	} 
		
		                        	if(most_post != null)
		                        	{
		                        		rs = stmt.executeQuery("select * from user where id='"+most_post+"'");
		                        	
		                        		while (rs.next())
		                        		{
		                        			its_name = rs.getString("name"); 
		                        		}
		                        	}
                               	}
                        		%>
                                <div class="user-id noline-design id-margin-design">학번 : <%=most_post %></div><!-- 학번 -->
                                <div class="user-name noline-design name-margin-design">이름 : <%=its_name %></div><!-- 이름 -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="footer.jsp"%>
</body>
</html>