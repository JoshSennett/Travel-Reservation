<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Page</title>
<link rel="stylesheet" href="styles.css">
</head>

<body>
	<!-- check for existing session -->
	
	<%

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
	
	
	<div>
		<% 
	session = request.getSession();
	String userID = (String)session.getAttribute("ID");
	if(userID == null){ %>
		<jsp:forward page = "index.jsp"/>
	<% } %>
	
	</div>
	<h1>Online Travel Reservation System</h1>
	<div>
		<%
		
		out.println("Hello " + userID);
		%>
		<h3 style="font-weight: bold;">Welcome to the administrator's
			page!</h3>
		<br>
		<br>
		<form action="manageUsers.jsp">
			<input type="submit" value="Manage users">
		</form>
		
	
		
		<form method = "post" action="salesReport.jsp">
			<h2>Generate sales report</h2>
			<h5>Select month, year of sales report</h5>
			<select name="month" id="month">
			  <option value="01">January</option>
			  <option value="02">February</option>
			  <option value="03">March</option>
			  <option value="04">April</option>
			  <option value="05">May</option>
			  <option value="06">June</option>
			  <option value="07">July</option>
			  <option value="08">August</option>
			  <option value="09">September</option>
			  <option value="10">October</option>
			  <option value="11">November</option>
			  <option value="12">December</option>
			</select>
			<label for="year">Year (four digit number): </label>
			<input id="year" type="text" name="year">
			<input type="submit" value="View sales report">
		</form>
		<br>
		<br>
		<form action="topCustomer.jsp">
			<input type="submit" value="Which customer generated most ticket revenue">
		</form>
		<br>
		<br>
		<h2>Produce list of upcoming reservations by customer name</h2>
		<form method = "post" action="reserveListByName.jsp">
			
			<label for="fname">First name: </label>
			<input id="fname" type="text" name="fname">
			<label for="lname">Last name: </label>
			<input id="lname" type="text" name="lname">
			<input type="submit" value="Generate reservation list">
		</form>
		<br>
		<br>
		<h2>Produce list of upcoming reservations by passenger ID</h2>
		<form method = "post" action="reserveListByPID.jsp">
			
			<label for="pid">Passenger ID: </label>
			<input id="pid" type="text" name="pid">
			<input type="submit" value="Generate reservation list">
		</form>
		<br>
		<br>
		<h2>Produce list of reservations by flight number</h2>
		<form method = "post" action="reserveListByFlightNumber.jsp">
			<label for="airline">Airline</label>
				<select name="airline" id=airline size=1>
					<%
					result = stmt2.executeQuery(str2);
						while(result.next()){
							out.print("<option value='" + result.getString("Airline_ID") + "' >" + result.getString("Airline_ID") + "</option>");
						}
					%>				
				</select>
		
			<label for="fnum">Flight number </label>
			<input id="fnum" type="text" name="fnum">
			<input type="submit" value="Generate reservation list">
		</form>
		<br>
		<br>
		
		<h2>Produce summary list of revenue by flight number</h2>
		<form method = "post" action="summaryRevFlight.jsp">
			<label for="airline">Airline</label>
				<select name="airline" id=airline size=1>
					<%
					result = stmt2.executeQuery(str2);
					while(result.next()){
						out.print("<option value='" + result.getString("Airline_ID") + "' >" + result.getString("Airline_ID") + "</option>");
					}
					%>				
				</select>
			
			<label for="fnum">Flight number </label>
			<input id="fnum" type="text" name="fnum">
			<input type="submit" value="Generate revenue list">
		</form>
		<br>
		<br>
		
		<h2>Produce summary list of revenue by userID</h2>
		<form method = "post" action="summaryRevCus.jsp">
			<label for="UID">User_ID </label>
			<input id="UID" type="text" name="UID">
			<input type="submit" value="Generate revenue list">
		</form>
		<br>
		<br>
		
		<h2>Produce summary list of revenue by airline ID</h2>
		<form method = "post" action="summaryRevAirline.jsp">
		<label for=AID>Airline</label>
				<select name="AID" id=AID size=1>
					<%
					result = stmt2.executeQuery(str2);
					while(result.next()){
						out.print("<option value='" + result.getString("Airline_ID") + "' >" + result.getString("Airline_ID") + "</option>");
					}
					%>				
				</select>
			<input type="submit" value="Generate revenue list">
		</form>
		<br>
		<br>
		
		<h2>Produce list of most active flights (tickets)</h2>
		<form action="mostActiveFlights.jsp">
			<input type="submit" value="Generate list">
		</form>
		<br>
		<br>
		<form action="logOut.jsp">
			<input type="submit" value="log out">
		</form>
	</div>

	<%
	con.close();
	%>

</body>
</html>