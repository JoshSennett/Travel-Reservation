<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>List of Flights</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>

	<h1> Online Travel Reservation System </h1>
	<nav "navar">
			<a href="cusrepPage.jsp" >Home</a> <br>
			<a href="logOut.jsp">Logout</a><br>
	</nav>
	<br>
	<table border="1" align="center">
		<tr>
		<td>Flight Number</td>
		<td>Flight Date</td>
		<td>Take Off Time</td>
		<td>Landing Time</td>
		<td>Landing Airport ID</td>
		<td>Departing Airport ID</td>
		</tr>
		<%
		try{
		String Landing_airport_ID = request.getParameter("Airport ID");
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("Select * FROM flight WHERE ((Departing_airport_ID = \'" + Landing_airport_ID + "\' or Landing_Airport_ID = \'" + Landing_airport_ID+"\')) and (Flight_date > (select current_date()) or (Flight_date = (select current_date()) and Take_off_time >= (select current_time())))");
		while(rs.next()){
		%>
		<tr>
		<td><%=rs.getInt("Flight_number")%></td>
		<td><%=rs.getString("Flight_date")%></td>
		<td><%=rs.getString("Take_off_time")%></td>
		<td><%=rs.getString("Landing_time")%></td>
		<td><%=rs.getString("Landing_airport_ID")%></td>
		<td><%=rs.getString("Departing_airport_ID")%></td>
		</tr>
		<%
		}
		con.close();
		}		catch(Exception e){
			out.println("null attributes not accepted!");
		}
		%>
		</table>
		
		
</body>