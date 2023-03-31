<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.UserDTO" scope="page"/>
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPW" />
<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	} else {
		userID = request.getParameter("userID");
	}
	
	if(user.getUserID() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(userID, user.getUserPW());
	if(result == 1) {
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='index.jsp'");
		script.println("</script>");
	} else if(result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디를 찾을 수 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('디비 오류')");
		script.println("history.back()");
		script.println("</script>");
	}
%>