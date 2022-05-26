<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit users</title>
</head>
<body>
	

	<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

	String User_ID = request.getParameter("User_ID");
	String f_name = request.getParameter("f_name");
	String l_name = request.getParameter("l_name");
	String pw = request.getParameter("pw");


	try {
		

		//If this is a customer
		if ((f_name != null) || (l_name !=null))
		{
			if(f_name != "")
			{
				Statement statement = con.createStatement();
				String query = "UPDATE customer	SET First_name= \'" + f_name + "\' WHERE User_ID = \'" + User_ID+ "\'";
				
				statement.executeUpdate(query);
			}
			
			if(l_name !="")
			{
				Statement statement = con.createStatement();
				String query = "UPDATE customer	SET Last_name= \'" + l_name + "\' WHERE User_ID = \'" + User_ID+ "\'";
				
				statement.executeUpdate(query);
			}
			
			
			
		}
		
		if(pw != "")
		{
			Statement statement = con.createStatement();
			String query = "UPDATE user	SET User_password= \'" + pw + "\' WHERE User_ID = \'" + User_ID+ "\'";
			
			statement.executeUpdate(query);
		}
		
		
		Statement statement = con.createStatement();
		String query = "select * FROM user WHERE User_ID = \'" + User_ID+ "\'";
		
		ResultSet rs = statement.executeQuery(query);
		if(rs.next() ==false)
		{
			out.print("Operation failed: user " + User_ID + " does not exist");
		}
		else
		{
			out.println("Completed edit for user: " + User_ID);
		}
		
		
		
		
		
		

	} catch (Exception e) {
		out.println(e);
	}
	%>
	<br>
	<form action="manageUsers.jsp">
		<input type="submit" value="Go back to manage users">
	</form>


</body>
</html>