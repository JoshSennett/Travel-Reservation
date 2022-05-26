<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Create an Airport</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
			<h2> Airport Creation </h2><br>
		<nav class="navar">
			<a href="cusrepPage.jsp" >Home</a>
			<a href="logOut.jsp">Logout</a>
	</nav>
	<div>
		<h3 style="font-weight: bold;">Please provide the following fields:</h3>
		<form method="post" action= "createAirport2.jsp">
			<table class="login">
				<tr>
					<td><label for="Airport_Id">Airport Id</label></td>
					<td><input id="Airport_Id" type="text" name="Airport_Id"required></td>
				</tr>
				<tr>
					<td><label for="Airport_Name">Airport name</label></td>
					<td><input id="Airport_Name" type="text" name="Airport_Name"required></td>
				</tr>
			</table>
			<br>
			<input type="submit" name="submit" value="create airport">
		</form>
		
		<br><br>
		
	</div>
		
</body>
</html>