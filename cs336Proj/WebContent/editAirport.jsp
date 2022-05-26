<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Edit an Airport</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
			<h2> Airport edit </h2><br>
		<nav class="navar">
			<a href="cusrepPage.jsp" >Home</a>
			<a href="logOut.jsp">Logout</a>
	</nav>
	<div>
		<h3 style="font-weight: bold;">Please provide the following fields:</h3>
		<form method="post" action= "editAirport2.jsp">
			<table class="login">
				<tr>
					<td><label for="Airport_Id">Original Airport ID</label></td>
					<td><input id="Airport_Id" type="text" name="Airport_Id"></td>
				</tr>
				<tr>
					<td><label for="newAirport_Id">newAirport_Id</label></td>
					<td><input id="newAirport_Id" type="text" name="newAirport_Id"></td>
			</table>
			<br>
			<input type="submit" name="submit" value="edit airport">
		</form>
</body>
</html>