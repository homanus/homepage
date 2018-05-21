<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%

	session.invalidate();
	response.sendRedirect("../index.jsp");

%>