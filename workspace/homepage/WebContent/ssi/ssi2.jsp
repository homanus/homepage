<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>
<%@ page import="utility.*" %>
<%@ page import="bbs.*" %>
<%@ page import="guest.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Oswald">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open Sans">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

 
<%  
	request.setCharacterEncoding("utf-8"); 
	String root = request.getContextPath();
	
	
	String tempDir = "/guest/temp";
	String upDir = "/guest/storage";
	
	tempDir = application.getRealPath(tempDir);
	upDir = application.getRealPath(upDir);
%> 
