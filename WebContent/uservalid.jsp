<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인이 필요한 페이지를 열었을 때</title>
</head>
<body>
	<%if(request.isRequestedSessionIdValid()&&session.getAttribute("name")!=null){ %>
		<!--세션이 유효할 때  -->
		<script></script>
		<%} else{%>
		<!--세션이 유효하지 않을 때  -->
		<script>
			alert("로그인을 먼저 해주세요.");
			location.href="login.jsp";
		</script>					
	<%} %>
</body>
</html>
