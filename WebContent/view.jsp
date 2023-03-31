<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.BbsDTO" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="css/bootstrap.css"> <!-- bootstrap.css 파일 -->
	<link rel="stylesheet" href="css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> <!-- jquery 추가 -->
	<script src="js/bootstrap.js"></script>
	<title>글읽기</title>
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
			<%
				if(userID == null) {
					
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-hasprpup="true"
						aria-expanded="false"><%=userName %><span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
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
	
		
	<!-- 게시판 글쓰기 양식 영역 시작 -->
	<div class="container">
		<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%= bbsDTO.getBbsTitle() %></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%= bbsDTO.getUserID() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%= bbsDTO.getBbsDate() %></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="min-height: 200px text-align: left;"><%= bbsDTO.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "&<br>") %></td>
						</tr>
					</tbody>
				</table>
				<a href="index.jsp" class="btn btn-primary">목록</a>
				<%
					if(userID != null && userID.equals(bbsDTO.getUserID())) {
				%>
					<a href="update.jsp?bbsNumber=<%=bbsNumber%>" class="btn btn-primary">수정</a>
					<a data-title="Delete" data-toggle="modal" data-target="#delete" class="btn btn-primary">삭제</a>
					
				<% 
					}
				%>
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
		</div>
	</div>
	<!-- 게시판 글쓰기 양식 영역 끝 -->
	
	    <div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
      <div class="modal-dialog">
    <div class="modal-content">
          <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
        <h4 class="modal-title custom_align" id="Heading">삭제</h4>
      </div>
          <div class="modal-body">
       
       <div class="alert alert-danger"><span class="glyphicon glyphicon-warning-sign"></span> 게시글을 삭제 하시겠습니다?</div>
       
      </div>
        <div class="modal-footer ">
        <button type="button" class="btn btn-success" onclick="location.href='deleteAction.jsp?bbsNumber=<%=bbsNumber%>'"><span class="glyphicon glyphicon-ok-sign"></a></span>네</button>
        <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> 아니요</button>
      </div>
        </div>
    <!-- /.modal-content --> 
  </div>
      <!-- /.modal-dialog --> 
    </div>
</body>
</html>