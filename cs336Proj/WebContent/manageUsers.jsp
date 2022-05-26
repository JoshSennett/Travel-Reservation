<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User management</title>
<link rel="stylesheet" href="styles.css">
</head>



 <body>
 	<div>
		<% 
	session = request.getSession();
	String userID = (String)session.getAttribute("ID");
	if(userID == null){ %>
		<jsp:forward page = "index.jsp"/>
	<% } %>
	
	</div>
	<!-- check for existing session -->
	<h1 style="font-weight: bold;">User management page.</h1>
	<div>
	
	<h1>Edit a user. Empty fields will be unchanged.</h1>
	<form method = "post" action = "editUser.jsp">
		<table class="edit">
			<tr>
				<td><label for="User_ID">User_ID you want to modify</label></td>
				<td><input id="User_ID" type="text" name="User_ID"></td>
			</tr>
			<tr>
				<td><label for="f_name">First Name (customers only)</label></td>
				<td><input id="f_name" type="text" name="f_name"></td>
			</tr>
			<tr>
				<td><label for="l_name">Last Name (customers only)</label></td>
				<td><input id="l_name" type="text" name="l_name"></td>
			</tr>
			<tr>
				<td><label for="pw">Password</label></td>
				<td><input id="pw" type="text" name="pw"></td>
			</tr>
			<tr>
			<td><input type="submit" name="submit" value="Submit edit"></td>
			</tr>
		</table>
		
	</form>
	
	<br>
	<br>
	
	<h1>Create a user. For customers, add the first, last name using edit users functionality.</h1>
	<form method = "post" action = "createUser.jsp">
		<table class="edit">
			<tr>
				<td><label for="f_name">First Name (customers only)</label></td>
				<td><input id="f_name" type="text" name="f_name"></td>
			</tr>
			<tr>
				<td><label for="l_name">Last Name (customers only)</label></td>
				<td><input id="l_name" type="text" name="l_name"></td>
			</tr>
			<tr>
				<td><label for="User_ID">User_ID for user</label></td>
				<td><input id="User_ID" type="text" name="User_ID"></td>
			</tr>
			<tr>
				<td><label for="pw">Password for user</label></td>
				<td><input id="pw" type="text" name="pw"></td>
			</tr>
			<tr>
				<td>Select the type of user</td>
				<td><select name="al" id="al">
				  <option value="0">Customer</option>
				  <option value="1">Customer representative</option>
				  <option value="2">Administrator</option>
				</select></td>
			</tr>
			<tr>
			<td><input type="submit" name="submit" value="Submit edit"></td>
			</tr>
		</table>
		
	</form>
	
	<br>
	<br>
	
	<h1>Delete a user.</h1>
	<form method = "post" action = "deleteUser.jsp">
		<table class="edit">
			<tr>
				<td><label for="User_ID">User_ID you want to delete</label></td>
				<td><input id="User_ID" type="text" name="User_ID"></td>
			</tr>
			
			<tr>
			<td><input type="submit" name="Delete" value="Delete"></td>
			</tr>
		</table>
		
	</form>

	<form action="userTable.jsp">
		<input type="submit" value="Look at all the users">
	</form>
	
	<form action="adminPage.jsp">
		<input type="submit" value="Go back to Admin Page">
	</form>
	
	<form method = "get" action="query.jsp">
		
	</form>
	</div>
	

</body>
</html>