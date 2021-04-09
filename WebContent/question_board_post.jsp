<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예제문제 게시판 게시글</title>
<link rel="stylesheet" type="text/css" href="css/question_board_post_style.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

</head>
<body>
<%@ include file="uservalid.jsp" %>
<%@include file="navbar.jsp" %>
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
			sql="select count(*) as cnt from question where ref="+i;
			rs=stmt.executeQuery(sql);
			rs.next();
			count = rs.getInt("cnt");
			count-=1;
			sql="select * from question where ref="+i+" order by id asc";
			rs=stmt.executeQuery(sql);
		}
		catch(Exception e) {
		   out.println("DB 연동 오류입니다.:"+e.getMessage());
		}
		
		if(!rs.next()){
			
			%><script>alert("잘못된 접근");
				location.href="question_board.jsp";</script><%
		}
		if(rs.getString("title")==null){
			%><script>alert("잘못된 접근");
			location.href="question_board.jsp";</script><%
		}
%>
    <div class="body-box">
        <div class="content">
            <div id="body-left" class="design">
                <div id="title" class="title-design">
                    <h1>지능 UP!</h1>
                </div>
                <div id="user-info" class="clearfix">
                    <div class="noline-design user-name"><%=rs.getString("writer") %></div>
                    <%if(session.getAttribute("id")!=null && session.getAttribute("id").equals(rs.getString("writer_id"))){%>
                    <div class="btn-q" name="delete" onclick="del(<%=rs.getInt("id")%>)"><a>삭제❌</a></div>
                    <div class="btn-q" name="modify" onclick="linked('question_board_modify.jsp?id=<%=rs.getInt("id")%>')"><a>수정✍</a></div>
                    <%} %>
                    <div class="noline-design"><%=rs.getString("time") %></div>
                </div>
                <div id="post" class="design clearfix">
                    <div id="post-title"><%= rs.getString("title") %></div>
                    <div id="post-content" style="word-break:break-all;"><%=rs.getString("content") %></div>
                    <div id="pic-align">
                        <div id="pic">
                            <div class="noline-design clearfix">
                                <img style="width:100%" src="question/<%=rs.getString("image")%>" onerror="this.style.display='none'"/><!--src 채워주세요!-->
                            </div>
                        </div>
                    </div>
                    <br>
                    <div id="count" class="clearfix">
                        <div class="info-design-left noline-design">좋아요 <%=rs.getInt("heart") %></div>
                        <div class="info-design-left noline-design">댓글 <%=rs.getInt("reply") %></div>
                        <div class="btn-q" name="heart"><a href="question_heart-db.jsp?id=<%=i%>">좋아요👍</a></div><!--href 채워주세요!-->
                    </div>
                </div>
                
                <form action="question_board_reply.jsp" method="post"><!--form 채워주세요!-->
                    <div id="write" class="design clearfix">
                        <div id="user-info" class="clearfix">
                            <div class="write-username"><%if(session.getAttribute("name")!=null){ %><%=session.getAttribute("name")%><%} %></div>
                        </div>
                        <div id="write-text">
                            <textarea name="reply" placeholder="댓글을 입력해주세요" class="reply-design noline-design" rows="4" cols="85" required></textarea>
                        </div>
                        <div><input type="submit" id="reply-button" class="btn-q" value="댓글 달기"></div>
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
            int id=0;
        	int ref;
        	String title,writer,writer_id,content,image,time;
        	int heart,reply;
            sql="select * from question where id=ref order by id desc ";
            rs = stmt.executeQuery(sql);
            %>
            <div id="body-right" class="design">
                <div id="sidebar-title" class="title-design">
                    <h2>오늘의 문제</h2><!--2개 정도만 보여주면 될듯...?-->
                </div>
                <div class="list clearfix">
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
                	image=rs.getString("image");
             %>
                    <div id="post-left" class="design" onclick="linked('question_board_post.jsp?id=<%=id%>')">
                        <div id="inner" class="design clearfix">
                            <div id="inner-title" class="noline-design"><%=title %></div>
                            <div class="noline-design"><img style="width:100%" src="question/<%= image%>" onerror="this.style.display='none'"></div>
                            <div id="inner-text" class="noline-design"><%=content %></div>
                        </div>
                        <div id="inner-info" class="clearfix">
                            <div class="info-design-left noline-design"><%=writer %></div>
                            <div class="info-design-right noline-design" style="color:rgb(204,102,51);">🗨 <%= reply %></div>
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
    <%@include file="footer.jsp" %>
    <script>
    	function linked(link){
    		location.href=link;
    	}
    	function del(id){
    		if(confirm("글을 삭제하시겠습니까?")){
    			location.href="question_board_delete.jsp?id="+id;
    		}else{
    			
    		}
    	}
    </script>
</body>
</html>