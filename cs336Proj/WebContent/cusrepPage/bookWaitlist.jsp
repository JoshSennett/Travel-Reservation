<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.util.Date"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Book Waitlist</title>
		<style type="text/css">
       	td {border: 1px #DDD solid; padding: 5px; cursor: pointer;}
       	.selected {
                  background-color: brown;
                  color: #FFF;
                  }
          </style>
	</head>
	<h3 style="font-weight: bold;">Redirecting</h3>
	<body>
	<% 
	session = request.getSession();
	String userID = (String)session.getAttribute("editID");
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
			
			//do for all flights
			String insertTicket;
			Statement stmt = con.createStatement();
			String getPassengerID = "select Passenger_ID from customer where User_ID = \"" + userID + "\"";
			
			String waitlistTicketNumber = request.getParameter("waitlistTicketNumber");
			String waitlistFlightNumber = request.getParameter("waitlistFlightNumber");
			String waitlistClass = request.getParameter("waitlistClass");
			String newSeatNumber = request.getParameter("newSeatNumber");
			
			ResultSet result = stmt.executeQuery(getPassengerID);
			result.next();
			int passID = Integer.parseInt(result.getString("Passenger_ID"));
			
			Statement stmt3 = con.createStatement();
			Statement stmt4 = con.createStatement();
			
			String updateSeat = "update seat set Is_available = 0, Ticket_number = "+ waitlistTicketNumber + " where Flight_number = " +  waitlistFlightNumber + " and Class = \"" + waitlistClass + "\" and Seat_number = " + newSeatNumber;
			String updateWaitlist = "delete from waitlist where Ticket_number = " + waitlistTicketNumber + " and Flight_number = " +  waitlistFlightNumber;
			
			stmt3.executeUpdate(updateSeat);
			stmt4.executeUpdate(updateWaitlist);
			
			String getSeatCost = "select * from seat s, flight f where s.Flight_number = f.Flight_number and f.Flight_number = " + waitlistFlightNumber + " and Ticket_number = " + waitlistTicketNumber;
			Statement stmt6 = con.createStatement();
			
			result = stmt6.executeQuery(getSeatCost);
			result.next();
			double seatCost = 0;
			if(waitlistClass.equals("FIR")){
				seatCost = result.getDouble("First_class_price");
			}
			if(waitlistClass.equals("BUS")){
				seatCost = result.getDouble("Business_class_price");
			}
			if(waitlistClass.equals("ECO")){
				seatCost = result.getDouble("Econ_class_price");
			}
		
			Statement stmt5 = con.createStatement();
			Statement stmt7 = con.createStatement();
			
			String getTotalFare = "select * from ticket where Ticket_number = " + waitlistTicketNumber;
			result = stmt7.executeQuery(getTotalFare);
			result.next();
			Double totalFare = result.getDouble("Total_fare");

			String updateTicket = "update ticket set Total_fare = " + (totalFare + seatCost) + " where Ticket_number = " + waitlistTicketNumber;
			stmt5.executeUpdate(updateTicket);
			
			response.sendRedirect("../mainPage.jsp");
				
		 } catch (Exception e) {
				out.print(e);
			}%>
	
		
	</body>
</html>