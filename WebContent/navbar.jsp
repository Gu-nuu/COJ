<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="main_style.css">

<title>navbar</title>
</head>
<body>	
	<script>
	function f(link){
		location.href=link;
	}
	</script>
	<div class="body-box">
		<div id="top">
			<div id="head-top">
				<div id="logo">
					<img src="elephant.png" style="width:30px;">
					<a href="main.jsp"><span id="page-name">우리컴공끼리</span></a>
				</div>
				<div id="user">
					<%if(request.isRequestedSessionIdValid()&&session.getAttribute("name")!=null){ %>
					<!--세션이 유효할 때  -->
					<span class="font-default">어서오세요 <%=session.getAttribute("name") %>님. </span>
					<button class="btn-default" type="submit" onclick="f('logout.jsp')">logout</button>
					<%} else{%>
					<!--세션이 유효하지 않을 때  -->
					
					<button class="btn-default" type="submit" onclick="f('login.jsp')">login</button>
					<button class="btn-default" type="submit" onclick="f('signup.jsp')">sign up</button>
					
					<%} %>
				</div>
				
			</div>
			<div id="nav" class="navbar-default">
				<ul class="clearfix">
					<li><a href="free_board.jsp">오늘도 밤새니?</a></li>
					<li><a href="question_board.jsp">지능 UP!</a></li>
					<li><a href="contest_board.jsp">스펙 UP!</a></li>
					<li><a href="tasty_board.jsp">오늘 뭐 먹지?</a></li>
					<li><a href="fame_hall.jsp">명예의 전당</a></li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>