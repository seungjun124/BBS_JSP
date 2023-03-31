<%@page import="bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.BbsDTO" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
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

if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('입력이 안 된 사항이 있습니다.')");
	script.println("history.back()");
	script.println("</script>");
}

BbsDAO bbsDAO = new BbsDAO();
int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
if(result == -1) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('등록에 실패하였습니다.')");
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