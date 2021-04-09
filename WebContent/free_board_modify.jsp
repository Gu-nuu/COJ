<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글작성</title>
</head>
<link rel="stylesheet" type="text/css" href="css/free_board_insert_style.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<body>
<%@ include file="navbar.jsp"%>
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
    sql="select * from free where id="+request.getParameter("id");
    rs = stmt.executeQuery(sql);
    %>
    <div class="body-box">
        <div class="content">
            <div id="body-left" class="design">
            <%
            while(rs.next()){
            %>
                <form id="form1" action="free_board_modify_db.jsp" method="POST" enctype="multipart/form-data">
                    <div id="title" class="title-design">
                        <h1><input type="text" placeholder="제목을 입력해주세요" name="title" id="title-input" size="40" value="<%=rs.getString("title")%>" required></h1>
                    </div>
                    <div id="main" class="clearfix">
                        <textarea name="content" id="content-input" rows="18" cols="62" placeholder="글을 입력해주세요" class="design" required><%=rs.getString("content") %></textarea> 
                    </div>
                    <div class="line"></div>
                    <div class="upload">
                        <input class="file-name" value="파일 선택" disabled="disabled">

                        <label for="file_btn">업로드</label>
                        <input type="file" id="file_btn" name="file" class="file-hidden">
                    </div>
                    <div id="move-button" class="clearfix">
                        <div class=""><input type="submit" class="btn-2" value="확인"></div>
                    </div>
                    <input type="hidden" name="id" value="<%=rs.getInt("id")%>">
                </form>
                 <%} %>
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
    <script>
    $(document).ready(function(){
  var fileTarget = $('.upload .file-hidden');

    fileTarget.on('change', function(){
        if(window.FileReader){
            var filename = $(this)[0].files[0].name;
        } else {
            var filename = $(this).val().split('/').pop().split('\\').pop();
        }

        $(this).siblings('.file-name').val(filename);
    });
}); 
</script>
    <script>
    function linked(link){
		location.href=link;
	}
</script>
    <%@ include file="footer.jsp" %>
</body>
</html>