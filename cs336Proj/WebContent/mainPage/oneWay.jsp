<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.0 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Chose Date</title>
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
	
	
	
	%>


	<h1> Welcome to the Booking Page!  </h1>
	<div>
		<h3 style="font-weight: bold;">What type of flight would you like to book?</h3>
		<br><br>
		<form method="get" action="stops.jsp">
		<table style="margin-left:auto;margin-right:auto;text-align:center">
		<tr>
			<td>
  				<label for="departingDate">Departing Date: <br></label><br>
  				<input type="hidden" id="returningDate" name="returningDate" value="null">
  				<input type="date" id="departingDate" name="departingDate" required>
			</td>
			<td>
				<label for="takeoffFilter1">Take off Time<br> (Not Required)</label><br>
				<input type="time" id="takeoffFilter1" name="takeoffFilter1">
			</td>
			<td>
				<label for="landingFilter1">Landing time<br> (Not Required)</label><br>
				<input type="time" id="landingFilter1" name="landingFilter1">
			</td>
		<tr/>
		</table>
			<input type="submit" value="submit">
		</form>
		<br><br>
		<form action="../logOut.jsp">
			<input type="submit" value="log out">
		</form>
	</div>
</body>
</html>