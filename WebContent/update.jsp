<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.BbsDTO" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="css/bootstrap.css"> <!-- bootstrap.css 파일 -->
	<link rel="stylesheet" href="css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> <!-- jquery 추가 -->
	<script src="js/bootstrap.js"></script>
	<title>글쓰기</title>
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
		
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		
		int bbsNumber = 0;
		if(request.getParameter("bbsNumber") != null) {
			bbsNumber = Integer.parseInt(request.getParameter("bbsNumber"));
		}
		
		if (bbsNumber == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}
		BbsDTO bbsDTO = new BbsDAO().getBbs(bbsNumber);
		if(!userID.equals(bbsDTO.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'index.jsp'");
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
				<li class="active"><a href="index.jsp">메인</a>
			</ul>
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
		</div>
	</nav>
	
		
	<!-- 게시판 글쓰기 양식 영역 시작 -->
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?bbsNumber=<%=bbsNumber%>">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbsDTO.getBbsTitle()%>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;"><%= bbsDTO.getBbsContent()%></textarea></td>
						</tr>
					</tbody>
				</table>
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="글수정">
			</form>
		</div>
	</div>
	<!-- 게시판 글쓰기 양식 영역 끝 -->
</body>
</html>