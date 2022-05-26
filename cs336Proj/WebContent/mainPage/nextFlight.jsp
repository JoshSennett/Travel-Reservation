<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.0 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Next Flight</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body style="margin-left:auto;margin-right:auto;text-align:center">
	<!-- check for existing session -->
	<% 
	session = request.getSession();
	String userID = (String)session.getAttribute("ID");
	if(userID == null){ 
	
	%>
		<jsp:forward page = "index.jsp"/>
		
	<% } 
	
	session = request.getSession();
	String flightType = (String)session.getAttribute("flightType");
	String stops = (String)session.getAttribute("stops");
	
	if(stops != null && flightType.equals("oneWay")){
	%>
		<jsp:forward page = "addTickets.jsp"/>
	<%	
	}else if(stops != null && stops.equals("roundTrip")){
	%>
		<jsp:forward page = "indirect2.jsp"/>
	<%	
	}
	%>
	<br>

	<form action="../index.jsp" style="margin-left:auto;margin-right:auto;text-align:center">
		<input type="submit" value="Go back to Log in Page">
	</form>
</body>
</html>