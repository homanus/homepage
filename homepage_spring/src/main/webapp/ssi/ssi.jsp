<%@ page contentType="text/html; charset=UTF-8"
 pageEncoding="utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/el-functions.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% 
   request.setCharacterEncoding("utf-8");
%>
<c:set var="root" value="${pageContext.request.contextPath}"/>