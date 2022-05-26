<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.0 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Stops</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body style="margin-left:auto;margin-right:auto;text-align:center">
	<!-- check for existing session -->
	<% 
	session = request.getSession();
	String userID = (String)session.getAttribute("editID");
	String cusrepID = (String)session.getAttribute("ID");
	
	if(cusrepID == null){ %>
		<jsp:forward page = "index.jsp"/>
	<% } 
	
	if(userID == null){ 
		response.sendRedirect("../cusrepPage.jsp");
	} 
	
	session = request.getSession();
	String stops = (String)session.getAttribute("stops");
	
	if(stops != null && stops.equals("direct")){
	%>
		<jsp:forward page = "direct.jsp"/>
	<%	
	}else if(stops != null && stops.equals("indirect")){
	%>
		<jsp:forward page = "indirect.jsp"/>
	<%	
	}
	%>
	<br>

	<form action="../index.jsp" style="margin-left:auto;margin-right:auto;text-align:center">
		<input type="submit" value="Go back to Log in Page">
	</form>
</body>
</html>