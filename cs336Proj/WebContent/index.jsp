<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Log In</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
	<h1> Online Travel Reservation System </h1>
	<div>
		<h3 style="font-weight: bold;">Jump right in!</h3>
		<h5>with your system account</h5>
		<form method="post" action= "signIn.jsp">
			<table class="login">
				<tr>
					<td><label for="ID">ID</label></td>
					<td><input id="ID" type="text" name ="ID"></td>
				</tr>
				<tr>
					<td><label for="pw">Password</label></td>
					<td><input id="pw" type="password" name="pw"></td>
				</tr>
			</table>
			<input type="submit" name="submit" value="sign in">
		</form>
		
		<br><br>
		<form action="createAccount.jsp">
			<input type="submit" value="Or Create an Account">
		</form>
		
	</div>
</body>
</html>