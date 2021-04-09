<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="main_style.css">
<link rel="stylesheet" href="signup.css">

</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="body-box">
		<div class="box">
			<div class="middle-box">
				<form action="signup-db.jsp" method="post">
				
					<div class="menu-name">
								<span class="font-default font-bold">회원가입</span>
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
						<tr class="signup-data">
								<td><span>이름:</span></td>
								<td><input type="text" name="name" required></td>
						</tr>
						<tr class="signup-data">
								<td><span>이메일:</span></td>
								<td><input type="email" name="email" required></td>
						</tr>
						
					</table>
					<div  class="clearfix">
						<button id="submit-box" class="btn-default" type="submit">sign up</button>
					</div>
					
				</form>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>