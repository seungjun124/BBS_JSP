<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="css/bootstrap.css"> <!-- bootstrap.css 파일 -->
	<link rel="stylesheet" href="css/custom.css">
	<link rel="stylesheet" href="css/loginCSS.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> <!-- jquery 추가 -->
	<script src="js/bootstrap.js"></script>
	<title>코쟁코쟁</title>
</head>
<body>

	<%
		String userID = null;
		String userName = null;
		if(session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
			UserDAO userDAO = new UserDAO();
			userName = userDAO.getuserName(userID);
		} else {
			userName = "로그인이 안 되어 있습니다.";
		}
		
		if(userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어 있습니다.')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		}
	%>
	
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp">열심히 만들자!</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="index.jsp">메인</a>
			</ul>
			<%
				if(userID == null) {
					
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-hasprpup="true"
						aria-expanded="false"><%=userName %><span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">로그인</a></li>
					</ul>
				</li>
			</ul>
			<% 
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-hasprpup="true"
						aria-expanded="false"><%=userName %>님 어서오세요!<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logout.jsp">회원정보</a></li>
						<li><a href="logout.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<% 
				} 
			%>
		</div>
	</nav>
	
	<div class="container">
    	<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
							<div class="col-xs-6">
								<a href="#" class="active" id="login-form-link">로그인</a>
							</div>
							<div class="col-xs-6">
								<a href="#" id="register-form-link">회원가입</a>
							</div>
						</div>
						<hr>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="login-form" action="loginAction.jsp" method="post" role="form" style="display: block;">
									<div class="form-group">
										<input type="text" name="userID" id="userID" tabindex="1" class="form-control" placeholder="아이디" value="">
									</div>
									<div class="form-group">
										<input type="password" name="userPW" id="userPW" tabindex="2" class="form-control" placeholder="비밀번호">
									</div>
									<div class="form-group text-center">
										<input type="checkbox" tabindex="3" class="" name="remember" id="remember">
										<label for="remember"> 아이디 기억하기</label>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="로그인">
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-lg-12">
												<div class="text-center">
													<a href="" tabindex="5" class="forgot-password">비밀번호를 잊으셨나요?</a>
												</div>
											</div>
										</div>
									</div>
								</form>
								<form id="register-form" action="joinAction.jsp" method="post" role="form" style="display: none;">
									<div class="form-group">
										<input type="text" name="userName" id="userName" tabindex="1" class="form-control" placeholder="닉네임" value="">
									</div>

									<div class="form-group">
										<input type="text" name="userID" id="userID" tabindex="2" class="form-control" placeholder="아이디">
									</div>
									<div class="form-group">
										<input type="password" name="userPW" id="userPW" tabindex="2" class="form-control" placeholder="비밀번호">
									</div>
									<div class="form-group">
										<input type="password" name="confirm-userPW" id="userPW" tabindex="2" class="form-control" placeholder="비밀번호를 다시 입력해주세요.">
									</div>
									<div class="form-group">
										<input type="email" name="userEmail" id="userEmail" tabindex="1" class="form-control" placeholder="이메일" value="">
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="register-submit" id="register-submit" tabindex="4" class="form-control btn btn-register" value="회원가입">
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="js/loginJS.js"></script> 
</body>
</html>