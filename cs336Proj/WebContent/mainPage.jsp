<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Main Page</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
	<!-- check for existing session -->
	<% 
	session = request.getSession();
	String userID = (String)session.getAttribute("ID");
	if(userID == null){ %>
		<jsp:forward page = "index.jsp"/>
	<% } %>


	<h1> Online Travel Reservation System </h1>
	<div>
		<%
		out.println("Hello, " + userID + "!");
		
		try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//do for all flights
			Statement stmt = con.createStatement();
			String getPassengerID = "select Passenger_ID from customer where User_ID = \"" + userID + "\"";
			
			ResultSet result = stmt.executeQuery(getPassengerID);
			result.next();
			int passID = Integer.parseInt(result.getString("Passenger_ID"));
			
			Statement stmt2 = con.createStatement();
			String getUserWaitlist = "Select * from waitlist where Passenger_ID = " + passID;
			result = stmt2.executeQuery(getUserWaitlist);
			while(result.next()){
				Statement stmt3 = con.createStatement();
				String checkForSeat = "Select * from seat where Flight_number = " + result.getString("Flight_number") + " and Class = \"" + result.getString("Seat_class") + "\" and Is_Available = 1";
				ResultSet result2 = stmt3.executeQuery(checkForSeat);
				if(result2.next()){
					out.print("<br> There is a seat available on flight " + result.getString("Flight_number") + " for ticket " + result.getString("Ticket_number") + " <br> Would you like to purchase?");
					out.print("<form action=\"mainPage/bookWaitlist.jsp\"> <input type=\"hidden\" name=\"waitlistTicketNumber\" value=\"" + result.getString("Ticket_number") + "\" /> <input type=\"hidden\" name=\"waitlistFlightNumber\" value=\"" + result.getString("Flight_number") + "\" /> <input type=\"hidden\" name=\"waitlistClass\" value=\"" + result.getString("Seat_class") + "\" /> <input type=\"hidden\" name=\"newSeatNumber\" value=\"" + result2.getString("Seat_number") + "\" /> <input type=\"submit\" value=\"Book Flight\"> </form>");
				}
			}
			
			//close the connection.
			db.closeConnection(con);
		
		} catch (Exception e) {
			out.print(e);
		}%>
		
		
		<h3 style="font-weight: bold;">Welcome to the main page!</h3>
		
		<br><br>
		<form action="mainPage/book.jsp">
			<input type="submit" value="Book Flight">
		</form>
		<br>
		
		<h5>Go to Question Forum</h5>
		
		<br><br>
		<form action="questionForumPage.jsp">
			<input style="display:none;" name="page_num" type="text" value="1">
			<input style="display:none;" name="search_value" type="text" value="">
			<input type="submit" value="Question Forum">
		</form>
		<br>
		<form action="viewMyFlights.jsp">
			<input style="display:none;" name="flight_type" type="text" value="Upcoming Flights">
			<input type="submit" value="View Current/Past Flights">
		</form>

		<br>
		<br>
		<form action="logOut.jsp">
			<input type="submit" value="log out">
		</form>
	</div>
</body>
</html>