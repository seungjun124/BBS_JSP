<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.UserDTO" scope="page" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPW" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String userID = null;
if(session.getAttribute("userID") != null) {
	userID = (String)session.getAttribute("userID");
} else {
	userID = request.getParameter("userID");
}

if(user.getUserName() == null || user.getUserID() == null || user.getUserPW() == null || user.getUserEmail() == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('입력이 안 된 사항이 있습니다.')");
	script.println("history.back()");
	script.println("</script>");
}

UserDAO userDAO = new UserDAO();
int result = userDAO.join(user);
if(result == -1) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 있는 회원 입니다.')");
	script.println("history.back()");
	script.println("</script>");
} else {
	session.setAttribute("userID", userID);
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href='index.jsp'");
	script.println("</script>");
}
%>
</body>
</html>