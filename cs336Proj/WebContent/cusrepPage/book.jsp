<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Booking</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body style="margin-left:auto;margin-right:auto;text-align:center">
	<!-- check for existing session -->
	<% 
	session = request.getSession();
	String userID = (String)request.getParameter("User_ID");
	if(userID != null){
		session.setAttribute("editID",userID);
	}
	String cusrepID = (String)session.getAttribute("ID");
	
	if(cusrepID == null){ %>
		<jsp:forward page = "index.jsp"/>
	<% } 
	
	if(userID == null){ 
		response.sendRedirect("../cusrepPage.jsp");
	} 
	
	try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			Statement stmt3 = con.createStatement();
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			
			String str = "select * from airport";
			String str2 = "select * from airline";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
	%>
			
	<h1> Welcome to the Booking Page!  </h1>
	<div>
		<h3 style="font-weight: bold;">What type of flight would you like to book?</h3>
		<br><br>
		<form method="get" action="bookType.jsp">
		<table style="margin-left:auto;margin-right:auto;text-align:center;border:dotted 2px #000000">
		<tr style="margin-left:auto;margin-right:auto;text-align:center">
			<td>
				<label for="departing" required>Departing Airport</label><br>
				<select name="departing" id=departing size=1>
					<%
						while(result.next()){
							out.print("<option value='" + result.getString("Airport_ID") + "' selected>" + result.getString("Airport_ID") + "</option>");
						}
					%>				
				</select>
			</td>
			<td>
				<label for="destination" required>Destination Airport</label><br>
				<select name="destination" id=destination size=1>
					<%	result = stmt2.executeQuery(str);
						while(result.next()){
							out.print("<option value='" + result.getString("Airport_ID") + "' selected>" + result.getString("Airport_ID") + "</option>");
						}
					%>				
				</select>
			</td>
			<td>
				<label for="airline">Airline</label><br>
				<select name="airline" id=airline size=1>
					<option value="--" selected>Any</option>
					<%
					result = stmt2.executeQuery(str2);
						while(result.next()){
							out.print("<option value='" + result.getString("Airline_ID") + "' >" + result.getString("Airline_ID") + "</option>");
						}
					%>				
				</select>
			</td>
		<tr/>
		
		<tr style="margin-left:auto;margin-right:auto;text-align:center">
			<td>
				<label for="flightType">Trip Type<br>
				<select name="flightType" id = flightType size=1>
					<option value="roundTrip" selected>Round Trip</option>
					<option value="oneWay">One Way</option>
				</select>
			</td>
			<td>
				<label for="flexibility">Flexibility</label><br>
				<select name="flexibility" id=flexibility size=1>
					<option value="definite" selected>Definite Dates</option>
					<option value="flexible">Flexible Dates +-3</option>
				</select>
			</td>
			<td>
				<label for="cabin">Class</label><br>
				<select name="cabin" id=cabin size=1>
					<option value="BUS" selected>Business Class</option>
					<option value="FIR">First Class</option>
					<option value="ECO">Economy Class</option>
				</select>
			</td>
		<tr/>
		<tr style="margin-left:auto;margin-right:auto;text-align:center">
			<td>
				<label for="stops">Stops</label><br>
				<select name="stops" id=stops size=1>
					<option value="direct" selected>Direct</option>
					<option value="indirect">Lay Over</option>
				</select>
			</td>
			<td>
				<label for="sort">Sort By</label><br>
				<select name="sort" id=sort size=1>
					<option value="Landing_time">Landing Time</option>
					<option value="Take_off_time">Takeoff Time</option>
					<option value="Price" selected>Price</option>
					<option value="Duration">Duration</option>
				</select>
			</td>
			<td>
				<label for="maxPrice" >Max Price Per Flight (not required)</label><br>
				<input id="maxPrice" min="0" type="number" name="maxPrice">
			</td>
		<tr/>
		
		</table>
		<br>
			<input type="submit" value="submit">
		</form>
		<br><br>
		<form action="../logOut.jsp">
			<input type="submit" value="log out">
		</form>
	</div>
		<%
		db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}%>
</body>
</html>