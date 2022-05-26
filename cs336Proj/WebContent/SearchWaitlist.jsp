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
	<nav "navar">
			<a href="cusrepPage.jsp" >Home</a> <br>
			<a href="logOut.jsp">Logout</a><br>
	</nav>
	<br>
	Wait List
	<table border="1" align="center">
		<tr>
		<td>Passenger ID</td>
		<td>User ID</td>
		<td>First Name</td>
		<td>Last Name</td>
		</tr>
		<%
		try{
		String Flight_number = request.getParameter("Flight_number");
		String AID = request.getParameter("Airline_Id");
		
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("Select * FROM waitlist w LEFT JOIN customer ON w.Passenger_ID = customer.Passenger_ID WHERE Flight_number = \'" + Flight_number+"\' and Airline_ID =  \'"+AID + "\'");
		while(rs.next()){
			%>
			<tr>
			<td><%=rs.getInt("Passenger_ID")%></td>
			<td><%=rs.getString("User_ID")%></td>
			<td><%=rs.getString("First_name")%></td>
			<td><%=rs.getString("Last_name")%></td>
			</tr>
			<%
		}
		con.close();
		}
		catch(Exception e){
			out.println("null attributes not accepted!");
		}
		%>
		</table>
</body>