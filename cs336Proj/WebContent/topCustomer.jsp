<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Top customer</title>
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
	try {

		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		Statement statement = con.createStatement();
		//this isn't even the worst one
		String fareSumQuery = "SELECT c.User_ID,c.First_name,c.Last_name,(SELECT SUM(t2.Total_fare + t2.Booking_fee) FROM ticket t2,customer c2 WHERE c.User_ID = c2.User_ID AND t2.Passenger_ID = c2.Passenger_ID) AS thing FROM customer c ORDER BY thing DESC";
		ResultSet rs = statement.executeQuery(fareSumQuery);
		rs.next();
		String fname = rs.getString("First_name");
		String lname = rs.getString("Last_name");
		String User_ID = rs.getString("User_ID");

		out.print("Top revenue generating customer is: " + fname + " " + lname + " (User_ID: " + User_ID + ")");

	} catch (Exception e) {
		out.print(e);
	}
	%>



	<br>
	<br>
	<form action="adminPage.jsp">
		<input type="submit" value="Go back to Admin Page">
	</form>
</body>
</html>