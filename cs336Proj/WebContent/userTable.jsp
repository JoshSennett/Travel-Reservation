<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User table</title>
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


<% 
try{
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("Select * From user");
		
		out.print("<table>");

		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("User_ID");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("access level");
		out.print("</td>");
		
	

		//parse out the results
		while (rs.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			
			//print out User_ID
			String User_ID = rs.getString("User_ID");
			out.print(User_ID);
			out.print("</td>");
			out.print("<td>");
		
			//prnt out accessLevel
			out.print(rs.getString("accessLevel"));
			out.print("</td>");
			out.print("<td>");
			
						
		}
		out.print("</table>");
		
		
		
		rs.close();
		statement.close();
		con.close();
	
	}
	catch(Exception e){
		out.println(e);
	}%>
	
	<form action="manageUsers.jsp">
		<input type="submit" value="Go back to User Management Page">
	</form>
</body>
</html>