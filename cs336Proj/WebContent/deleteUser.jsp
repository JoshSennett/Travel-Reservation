<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delet users</title>
</head>
<body>
<%
	try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

	String User_ID = request.getParameter("User_ID");
	Statement statement = con.createStatement();
	String query = "DELETE FROM user WHERE User_ID = \'" + User_ID+ "\'";
	
	
	
	int e = statement.executeUpdate(query);
	if(e==0)
	{
		out.print("Operation failed: user " + User_ID + " does not exist");
	}
	else
	{
		out.print("Deleted user: " + User_ID);
	}
	
	}
catch(Exception e)
{
	out.print(e);
}
	%>
	
	<form action="manageUsers.jsp">
		<input type="submit" value="Go back to manage users">
	</form>
</body>
</html>