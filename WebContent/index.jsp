<%@page import="java.util.ArrayList"%>
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
	<title>메인</title>
	
	<style>
		a,a:hover {
			color: black;
			text-decoration: none;
		}
	</style>
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
		
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
						<li><a href="userUpdate.jsp">회원정보</a></li>
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
		
        
        <div class="col-md-12">
        <div class="table-responsive">

                
              <table id="mytable" class="table table-bordred table-striped">
                   
                   <thead>
                   
                   <th>번호</th>
                    <th>닉네임</th>
                     <th>제목</th>
                     <th>내용</th>
                     <th>시간</th>
                   </thead>
    <tbody>
    
    <%
    	BbsDAO bbsDAO = new BbsDAO();
    	ArrayList<BbsDTO> list = bbsDAO.getList(pageNumber);
    	for(int i = 0; i < list.size(); i++) {
    %>
    <tr>
    <td><%= list.get(i).getBbsNumber() %></td>
    <td><%= list.get(i).getUserID() %></td>
    <td><a href="view.jsp?bbsNumber=<%=list.get(i).getBbsNumber() %>"><%= list.get(i).getBbsTitle() %></a></td>
    <td><%= list.get(i).getBbsContent() %></td>
    <td><%= list.get(i).getBbsDate()%></td>
    </tr>
    <% 
    	}
    %>
    
    </tbody>
        
</table>

<%
	if(pageNumber != 1) {
%>
	<a href="index.jsp?pageNumber=<%= pageNumber - 1 %>" class="btn btn-success btn-arraw-left">이전</a>
<% 
	} if (bbsDAO.nextPage(pageNumber + 1)) {
%>
	<a href="index.jsp?pageNumber=<%= pageNumber + 1 %>" class="btn btn-success btn-arraw-left">다음</a>
<% 
	}
%>

<a href="write.jsp" class="btn btn-primary pull-right">글 쓰기</a>
                
            </div>
            
        </div>
	</div>
</div>


<div class="modal fade" id="edit" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
      <div class="modal-dialog">
    <div class="modal-content">
          <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
        <h4 class="modal-title custom_align" id="Heading">수정</h4>
      </div>
          <div class="modal-body">
        <div class="form-group">
        
        <input class="form-control " type="text" placeholder="제목">
        </div>
        <div class="form-group">
        <textarea rows="2" class="form-control" placeholder="내용"></textarea>
    
        
        </div>
      </div>
          <div class="modal-footer ">
        <button type="button" class="btn btn-warning btn-lg" style="width: 100%;"><span class="glyphicon glyphicon-ok-sign"></span>수정하기</button>
      </div>
        </div>
    <!-- /.modal-content --> 
  </div>
      <!-- /.modal-dialog --> 
    </div>
    
    
    
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
        <button type="button" class="btn btn-success" ><span class="glyphicon glyphicon-ok-sign"></span> 네</button>
        <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> 아니요</button>
      </div>
        </div>
    <!-- /.modal-content --> 
  </div>
      <!-- /.modal-dialog --> 
    </div>
</body>
</html>