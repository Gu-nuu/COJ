<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예제문제 게시판</title>
<link rel="stylesheet" type="text/css" href="css/question_board_style.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">


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
        sql="select * from question where id=ref order by id desc limit "+id+", "+id2;
        rs = stmt.executeQuery(sql);
     }catch(Exception e){
        out.print("DB 연동 오류입니다.:" + e.getMessage());
    }
    %>
	<%@include file="navbar.jsp" %>
    <div class="body-box">
        <div class="content">
            <div id="body-left" class="design">
                <div id="title" class="title-design">
                    <h1>지능 UP!</h1>
                </div>
                <div id="write-button" class="clearfix">
                    <div class="btn-q"><a href="question_board_insert.jsp">글 작성</a></div><!--href 넣어주세요!-->
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
                    <div id="post-right" class="design" onclick="linked('question_board_post.jsp?id=<%=id%>')"><!--자유게시판이랑 동일하게-->
                        <div id="inner" class="design clearfix">
                            <div id="pic" class="noline-design"><img style="width:100%;" src="question/<%= image%>" onerror="this.style.display='none'"></div>
                            <div id="inner-title-q" class="noline-design"><%=title %></div><!--게시판에서 문제 내용보단 문제 정보나 
                                제목이 보이는게 좋아보여서...별로면 문제 내용으로 바꿔도 됩니당-->
                        </div>
                        <div id="info" class="clearfix">
                            <div class="info-design-left noline-design"><%=time %></div>
                            <div class="info-design-left noline-design"><%=writer %></div>
                            <div class="info-design-right noline-design" style="color:rgb(204,102,51);">🗨 <%= reply %></div>
                            <div class="info-design-right noline-design">👍 <%= heart %></div>
                        </div>
                    </div>
                   <%} %>
                </div>
                <div id="move-button" class="clearfix">
                    <div class="btn-q"><a href="question_board.jsp">다음</a></div><!--자유게시판에 다음으로 넘어가는 기능 구현되어있습니다!-->
                </div>
            </div>
            <%
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
    	
    </script>
</body>
</html>