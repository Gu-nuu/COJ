<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공모전 게시판 글작성</title>
<link rel="stylesheet" type="text/css" href="css/contest_board_insert_style.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<%@include file="navbar.jsp" %>
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
%>
    <div class="body-box">
        <div class="content">
            <div id="body-left" class="design">
                <form action="contest_board_insert-db.jsp" method="POST" enctype="multipart/form-data"><!--action 채우기-->
                    <div id="title" class="title-design">
                        <h1><input type="text" placeholder="제목을 입력해주세요" name="title" id="title-input" size="40" required></h1>
                    </div>
                    <div id="main" class="clearfix">
                        <textarea name="content" id="content-input" rows="18" cols="62" placeholder="글을 입력해주세요" class="design" required></textarea> 
                    </div>
                    <div class="line"></div>
                    <div class="upload">
                        <input class="file-name" value="파일 선택" disabled="disabled">
                        <label for="file_btn">업로드</label>
                        <input type="file" id="file_btn" class="file-hidden" name="file">
                    </div>
                    <div id="move-button" class="clearfix">
                        <input type="submit" class="btn-contest" value="완료"/>
                    </div>
                </form>
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
                            <div id="inner-pic" class=""><img style="width:100%" src="contest/<%=image%>" onerror="this.style.display='none'"></div>
                            <div id="inner-text" class="noline-design"><%=content %></div>
                        </div>
                        <div id="inner-info" class="clearfix">
                            <div class="info-design-left noline-design"><%=writer %></div>
                            <div class="info-design-right noline-design" style="color:rgb(204,102,51);" >🗨 <%=reply %></div>
                            <div class="info-design-right noline-design">👍 <%=heart %></div>
                        </div>
                    </div>
                 <%} %>
                </div>            
            </div>
        </div>
    </div>
    <%@include file = "footer.jsp" %>
</body>
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
    function go_post(id) {
        location.href = "contest_board_post.jsp?id="+id;
    }     
</script>
</html>