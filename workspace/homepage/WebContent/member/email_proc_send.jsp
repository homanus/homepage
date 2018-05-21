<%@ page contentType="text/html; charset=UTF-8" %> 
<%
	request.setCharacterEncoding("UTF-8");
	
	
	String from = request.getParameter("from");
	System.out.println(from);
	String to = request.getParameter("to");
	System.out.println(to);
	String subject = request.getParameter("subject");
	System.out.println(subject);
	String content = request.getParameter("content");
	System.out.println(content);
%>

{
	from:'<%=from %>',
	to:'<%=to %>',
	subject:'<%=subject %>',
	content:'<%=content %>'
}


