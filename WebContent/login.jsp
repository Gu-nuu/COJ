<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="main_style.css">
<link rel="stylesheet" href="signup.css">

</head>
<body>
	<%@ include file="navbar.jsp"%>
	<%if(request.getParameter("id")!=null){
		String id, pwd, name=null, email=null;
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		String sql_update;
		
		id=request.getParameter("id");
		pwd=request.getParameter("pwd");
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcurl = "jdbc:mysql://localhost:3306/cse_community?serverTimezone=UTC";
			conn = DriverManager.getConnection(jdbcurl,"root","0000");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			String sql = "select * from user where id='"+id+"'";
			rs = stmt.executeQuery(sql);
			
			
		}
		catch(Exception e) {
		   out.println("DB 연동 오류입니다.:"+e.getMessage());
		}
		while(rs.next()){
			if(rs.getString("pwd").equals(pwd)){
				
				name=rs.getString("name");
				pwd=rs.getString("pwd");
				session.setAttribute("id", id);
				session.setAttribute("name", name);
				session.setAttribute("email", email);
				session.setAttribute("pwd", pwd);
				%>
				<script>location.href="main.jsp"</script>
				<%
			}
			else{
				%><script>alert("비밀번호를 다시 확인해주세요.");</script>
				<%
			}
		}
	}%>
	<div class="body-box">
		<div class="box">
			<div class="middle-box">
				<form action="login.jsp" method="post">
				
					<div class="menu-name">
								<span class="font-default font-bold">로그인</span>
					</div>
					<table>
						<tr class="signup-data">
								<td><span>학번:</span></td>
								<td><input type="number" name="id" required></td>
						</tr>
						<tr class="signup-data">
								<td><span>비밀번호: </span></td>
								<td><input type="password" name="pwd" required></td>
						</tr>
						
						
					</table>
					<div  class="clearfix">
						<button id="submit-box" class="btn-default" type="submit">login</button>
					</div>
					
				</form>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>