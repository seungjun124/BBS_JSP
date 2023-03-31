<%@page import="bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.BbsDTO" %>
<% request.setCharacterEncoding("UTF-8"); %>
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

int bbsNumber = 0;
if(request.getParameter("bbsNumber") != null) {
	bbsNumber = Integer.parseInt(request.getParameter("bbsNumber"));
}

BbsDAO bbsDAO = new BbsDAO();

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
} else {
	int result = bbsDAO.delete(bbsNumber);
	if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('삭제를 실패하였습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='index.jsp'");
		script.println("</script>");
	}
}
%>
</body>
</html>