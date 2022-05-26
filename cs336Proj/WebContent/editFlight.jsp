<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Edit a flight</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
	<%
	try {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		

		//Create a SQL statement
		Statement stmt = con.createStatement();
		Statement stmt2 = con.createStatement();
		Statement stmt3 = con.createStatement();
		Statement stmt4 = con.createStatement();
		//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		
		String str = "select * from airport";
		String str2 = "select * from airline";
		String str3 = "select * from aircraft";
		
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		%>
			<h2> Flight edit </h2><br>
		<nav class="navar">
			<a href="cusrepPage.jsp" >Home</a>
			<a href="logOut.jsp">Logout</a>
	</nav>
	<div>
		<h3 style="font-weight: bold;">Please provide the following fields:</h3>
		<form method="post" action= "editFlight2.jsp">
			<table align="center">
				<tr>
					<td><label for="Flight_number">Original Flight number</label></td>
					<td><input id="Flight_number" type="text" name="Flight_number"></td>
				</tr>
				<tr>
					<td><label for="Airline_Id">Airline_Id</label></td>
					<td>
						<select name="Airline_Id" id=Airline_Id size=1>
						<%
						result = stmt.executeQuery(str2);
							while(result.next()){
								out.print("<option value='" + result.getString("Airline_ID") + "' >" + result.getString("Airline_ID") + "</option>");
							}
						%>				
						</select>
					</td>
				</tr>
				<tr>
				<tr>
					<td><label for="newFlight_number">New Flight_number</label></td>
					<td><input id="newFlight_number" type="text" name="newFlight_number"></td>
				</tr>
				<tr>
					<td><label for="First_class_price">First class price</label></td>
					<td><input id="First_class_price" type="text" name="First_class_price" required></td>
				</tr>
				<tr>
					<td><label for="Business_class_price">Business class price</label></td>
					<td><input id="Business_class_price" type="text" name="Business_class_price" required></td>
				</tr>
				<tr>
					<td><label for="Econ_class_price">Economy class price</label></td>
					<td><input id="Econ_class_price" type="text" name="Econ_class_price" required></td>
				</tr>
				<tr>
					<td><label for="Take_off_time">Take off time</label></td>
					<td><input id="Take_off_time" type="time" name="Take_off_time"required></td>
				</tr>
				<tr>
					<td><label for="Landing_time">Landing time</label></td>
					<td><input id="Landing_time" type="time" name="Landing_time"required></td>
				</tr>
				<tr>
					<td><label for="Flight_date">Flight date</label></td>
					<td><input id="Flight_date" type="date" name="Flight_date"></td>
				</tr>
				<tr>
					<td><label for="Return_date">Return date</label></td>
					<td><input id="Return_date" type="date" name="Return_date"></td>
				</tr>
			<tr>
					<td><label for="Flight_type">Flight type</label></td>
					<td>
						<select name="Flight_type" id=Flight_type size=1>
							<option value="DOM">Domestic</option>
							<option value="INT">International</option>	
						</select>
					</td>
				</tr>
				<tr>
					<td><label for="Aircraft_Id">Aircraft_Id</label></td>
					<td>
						<select name="Aircraft_Id" id = Aircraft_Id size=1>
							<%
							result = stmt4.executeQuery(str3);
							while(result.next()){
								out.print("<option value='"+ result.getString("Aircraft_ID")+ "' selected>"+ result.getString("Aircraft_ID") + "</option>");
							}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td><label for="newAirline_ID">new Airline_Id</label></td>
					<td>
						<select name="newAirline_ID" id=newAirline_ID size=1>
						<%
						result = stmt.executeQuery(str2);
							while(result.next()){
								out.print("<option value='" + result.getString("Airline_ID") + "' >" + result.getString("Airline_ID") + "</option>");
							}
						%>				
						</select>
					</td>
				</tr>
						<tr>
					<td><label for="Landing_airport_ID">Landing airport ID</label></td>
					<td>
						<select name="Landing_airport_ID" id=Landing_airport_ID size=1>
							<%
							result = stmt.executeQuery(str);
							while(result.next()){
								out.print("<option value='" + result.getString("Airport_ID") + "' selected>" + result.getString("Airport_ID") + "</option>");
							}
							%>				
						</select>
					</td>
				</tr>
				<tr>
					<td><label for="Departing_airport_ID">Departing airport ID</label></td>
					<td>
						<select name="Departing_airport_ID" id=Departing_airport_ID size=1>
							<%
							result = stmt.executeQuery(str);
							while(result.next()){
								out.print("<option value='" + result.getString("Airport_ID") + "' selected>" + result.getString("Airport_ID") + "</option>");
							}
							%>				
						</select>
					</td>
				</tr>
				<tr>
					</table>
			<br>
			<input type="submit" name="submit" value="edit flight">
		</form>
			<%
		db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}%>
				
</body>
</html>