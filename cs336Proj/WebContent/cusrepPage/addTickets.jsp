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
		<title>Add Tickets</title>
		<style type="text/css">
       	td {border: 1px #DDD solid; padding: 5px; cursor: pointer;}
       	.selected {
                  background-color: brown;
                  color: #FFF;
                  }
          </style>
	</head>
	<h3 style="font-weight: bold;">Purchase Summary</h3>
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
	
	String flightType = (String)session.getAttribute("flightType");	
	if(flightType == null){
		response.sendRedirect("../cusrepPage.jsp");
	}
	String firstFlight = null;
	String firstFlightA = null;
	String secondFlight = null;
	String secondFlightA = null;
	String thirdFlight = null;
	String thirdFlightA = null;
	String fourthFlight = null;
	String fourthFlightA = null;
	 
	
	if(flightType != null && flightType.equals("roundTrip")){
		thirdFlight = (String)request.getParameter("thirdFlight");
		if(thirdFlight == null){
			
			firstFlight = (String)request.getParameter("firstFlight");
			session.setAttribute("firstFlight",firstFlight);
			firstFlightA = (String)request.getParameter("firstFlightA");
			session.setAttribute("firstFlightA",firstFlightA);
			secondFlight = null;
			session.setAttribute("firstLegLD",(String)request.getParameter("firstFlightLD"));
			session.setAttribute("firstLegLT",(String)request.getParameter("firstFlightLT"));
			if(session.getAttribute("stops").equals("indirect")){
				secondFlight = (String)request.getParameter("secondFlight");
				session.setAttribute("secondFlight",secondFlight);
				secondFlightA = (String)request.getParameter("secondFlightA");
				session.setAttribute("secondFlightA",secondFlightA);
				
			}else{
				session.setAttribute("secondFlight",secondFlight);
			}
			
			if(session.getAttribute("stops").equals("direct")){
				%>
				<jsp:forward page = "direct2.jsp"/>
				<%
				return;
			}else{
				%>
				<jsp:forward page = "indirect2.jsp"/>
				<%
				return;
			}

		}else{
			firstFlight = (String)session.getAttribute("firstFlight");
			firstFlightA = (String)session.getAttribute("firstFlightA");
			secondFlight = (String)session.getAttribute("secondFlight");
			secondFlightA = (String)session.getAttribute("secondFlightA");
			thirdFlight = (String)request.getParameter("thirdFlight");
			thirdFlightA = (String)request.getParameter("thirdFlightA");
			session.setAttribute("thirdFlight",thirdFlight);
			session.setAttribute("thirdFlightA",thirdFlightA);
			fourthFlight = null;
			if(session.getAttribute("stops").equals("indirect")){
				fourthFlight = (String)request.getParameter("fourthFlight");
				session.setAttribute("fourthFlight",fourthFlight);
				fourthFlightA = (String)request.getParameter("fourthFlightA");
				session.setAttribute("fourthFlightA",fourthFlightA);
			}else{
				session.setAttribute("fourthFlight",fourthFlight);
			}
		}
	
	}else if(flightType != null && flightType.equals("oneWay")){
			thirdFlight = null;
			fourthFlight = null;
			firstFlight = (String)request.getParameter("firstFlight");
			session.setAttribute("firstFlight",firstFlight);
			firstFlightA = (String)request.getParameter("firstFlightA");
			session.setAttribute("firstFlightA",firstFlightA);
			secondFlight = null;
			if(session.getAttribute("stops").equals("indirect")){
				secondFlight = (String)request.getParameter("secondFlight");
				session.setAttribute("secondFlight",secondFlight);
				secondFlightA = (String)request.getParameter("secondFlightA");
				session.setAttribute("secondFlightA",secondFlightA);
			}else{	
				session.setAttribute("secondFlight",secondFlight);	
			}
		}

		
		session = request.getSession();
		String departing = (String)session.getAttribute("departing");
		String destination = (String)session.getAttribute("destination");
		String airline = (String)session.getAttribute("airline");
		
		String cabin = (String)session.getAttribute("cabin");
		
		java.util.Date utilDate = new java.util.Date();
		
		try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//do for all flights
			String updateSeat;
			String insertTicket;
			Statement stmt = con.createStatement();
			String getPassengerID = "select Passenger_ID from customer where User_ID = \"" + userID + "\"";
			String getTicketNumber = "(select max(Ticket_number) e from ticket)";
			
			ResultSet result = stmt.executeQuery(getPassengerID);
			result.next();
			int passID = Integer.parseInt(result.getString("Passenger_ID"));
			Statement stmt2 = con.createStatement();
			result = stmt2.executeQuery(getTicketNumber);
			String checkNull;
			if(result.next()){
				checkNull = result.getString("e");}
			else{checkNull = null;}
			
			int ticketNumber = 1;
			if(checkNull != null){
				ticketNumber = Integer.parseInt(checkNull) + 1;
			}
			
				//has to be min seat where seat is also empty
				insertTicket = "insert into ticket(Ticket_number, Passenger_ID, Total_fare, Time_purchased, Booking_fee, Date_purchased) values (" + ticketNumber + ", " + passID + ", 0, \"" + new java.sql.Time(utilDate.getTime()) + "\", 0, \"" + new java.sql.Date(utilDate.getTime()) + "\")";
				String checkExists = "select * from seat where class = \"" + cabin + "\" and Flight_number = " + firstFlight + " and Is_available = 1 and Airline_ID = '" + firstFlightA + "'";
				updateSeat = "update seat set Is_available = 0, Ticket_number =" + ticketNumber + " where Seat_number = (select min(e.Seat_number) from (select * from seat where class = \"" + cabin + "\" and Flight_number = " + firstFlight + " and Is_available = 1 ) e) and Flight_number = " + firstFlight + " and Airline_ID = '" + firstFlightA + "'";
				Statement stmt3 = con.createStatement();
				result = stmt3.executeQuery(checkExists);
				Statement stmt4 = con.createStatement();
				if(result.next()){
					checkNull = result.getString("Seat_number");
				}else{checkNull = null;}
				Statement stmt5 = con.createStatement();
				stmt5.executeUpdate(insertTicket);
				if(checkNull != null){
					Statement stmt6 = con.createStatement();
					stmt6.executeUpdate(updateSeat);
				}else{
					String getWaitlistID = "(select max(waitlist_ID) e from waitlist where Flight_number = " + firstFlight + " and Airline_ID = '" + firstFlightA + "' )";
					Statement stmt7 = con.createStatement();
					result = stmt7.executeQuery(getWaitlistID);
					if(result.next()){
						checkNull = result.getString("e");}
					else{checkNull = null;}
					
					int waitlistNum = 1;
					if(checkNull != null){
						waitlistNum = Integer.parseInt(checkNull) + 1;
					}
					String insertWaitlist = "insert into waitlist(Passenger_ID, Airline_ID, Flight_number, Date_purchased, Seat_class, Time_purchased, Waitlist_id, Ticket_number) values (" + passID + ",\"" + firstFlightA + "\", " + firstFlight + ", \"" + new java.sql.Date(utilDate.getTime()) + "\", \"" + cabin + "\", \""  + new java.sql.Time(utilDate.getTime()) + "\", "+ waitlistNum + "," + ticketNumber + ")";
					Statement stmt8 = con.createStatement();
					stmt8.executeUpdate(insertWaitlist);
				}
	
				if(secondFlight != (null)){
					checkExists = "select * from seat where class = \"" + cabin + "\" and Flight_number = " + secondFlight + " and Is_available = 1 and Airline_ID = '" + secondFlightA + "'";
					updateSeat = "update seat set Is_available = 0, Ticket_number =" + ticketNumber + " where Seat_number = (select min(e.Seat_number) from (select * from seat where class = \"" + cabin + "\" and Flight_number = " + secondFlight + " and Is_available = 1 ) e) and Flight_number = " + secondFlight + " and Airline_ID = '" + secondFlightA + "'";
					Statement stmt9 = con.createStatement();
					result = stmt9.executeQuery(checkExists);
					if(result.next()){
						checkNull = result.getString("Seat_number");
					}else{checkNull = null;}
					if(checkNull != null){
						Statement stmt10 = con.createStatement();
						stmt10.executeUpdate(updateSeat);
					}else{
						String getWaitlistID = "(select max(waitlist_ID) e from waitlist where Flight_number = " + secondFlight + " and Airline_ID = '" + secondFlightA + "')";
						Statement stmt11 = con.createStatement();
						result = stmt11.executeQuery(getWaitlistID);
						if(result.next()){
							checkNull = result.getString("e");}
						else{checkNull = null;}
						
						int waitlistNum = 1;
						if(checkNull != null){
							waitlistNum = Integer.parseInt(checkNull) + 1;
						}
						String insertWaitlist = "insert into waitlist(Passenger_ID, Airline_ID, Flight_number, Date_purchased, Seat_class, Time_purchased, Waitlist_id, Ticket_number) values (" + passID + ",\"" + secondFlightA + "\", " + secondFlight + ", \"" + new java.sql.Date(utilDate.getTime()) + "\", \"" + cabin + "\", \""  + new java.sql.Time(utilDate.getTime()) + "\", "+ waitlistNum + "," + ticketNumber + ")";
						Statement stmt12 = con.createStatement();
						stmt12.executeUpdate(insertWaitlist);
					}
				}
				
				if(thirdFlight != null){
					checkExists = "select * from seat where class = \"" + cabin + "\" and Flight_number = " + thirdFlight + " and Is_available = 1 and Airline_ID = '" + thirdFlightA + "'";
					updateSeat = "update seat set Is_available = 0, Ticket_number =" + ticketNumber + " where Seat_number = (select min(e.Seat_number) from (select * from seat where class = \"" + cabin + "\" and Flight_number = " + thirdFlight + " and Is_available = 1 ) e) and Flight_number = " + thirdFlight + " and Airline_ID = '" + thirdFlightA + "'";
					Statement stmt13 = con.createStatement();
					result = stmt13.executeQuery(checkExists);
					if(result.next()){
						checkNull = result.getString("Seat_number");
					}else{checkNull = null;}
					if(checkNull != null){
						Statement stmt14 = con.createStatement();
						stmt14.executeUpdate(updateSeat);
						}else{
							String getWaitlistID = "(select max(waitlist_ID) e from waitlist where Flight_number = " + thirdFlight + " and Airline_ID = '" + thirdFlightA + "' )";
							Statement stmt15 = con.createStatement();
							result = stmt15.executeQuery(getWaitlistID);
							if(result.next()){
								checkNull = result.getString("e");}
							else{checkNull = null;}
							
							int waitlistNum = 1;
							if(checkNull != null){
								waitlistNum = Integer.parseInt(checkNull) + 1;
							}
							String insertWaitlist = "insert into waitlist(Passenger_ID, Airline_ID, Flight_number, Date_purchased, Seat_class, Time_purchased, Waitlist_id, Ticket_number) values (" + passID + ",\"" + thirdFlightA + "\", " + thirdFlight + ", \"" + new java.sql.Date(utilDate.getTime()) + "\", \"" + cabin + "\", \""  + new java.sql.Time(utilDate.getTime()) + "\", "+ waitlistNum + "," + ticketNumber + ")";
							Statement stmt16 = con.createStatement();
							stmt16.executeUpdate(insertWaitlist);
						}
				}

					if(fourthFlight != null){
						checkExists = "select * from seat where class = \"" + cabin + "\" and Flight_number = " + fourthFlight + " and Is_available = 1 and Airline_ID = '" + fourthFlightA + "'";
						updateSeat = "update seat set Is_available = 0, Ticket_number =" + ticketNumber + " where Seat_number = (select min(e.Seat_number) from (select * from seat where class = \"" + cabin + "\" and Flight_number = " + fourthFlight + " and Is_available = 1 ) e) and Flight_number = " + fourthFlight + " and Airline_ID = '" + fourthFlightA + "'";
						Statement stmt17 = con.createStatement();
						result = stmt17.executeQuery(checkExists);
						if(result.next()){
							checkNull = result.getString("Seat_number");
						}else{checkNull = null;}
						if(checkNull != null){
							Statement stmt18 = con.createStatement();
							stmt18.executeUpdate(updateSeat);
						}else{
							String getWaitlistID = "(select max(waitlist_ID) e from waitlist where Flight_number = " + fourthFlight + " and Airline_ID = '" + fourthFlightA + "')";
							Statement stmt19 = con.createStatement();
							result = stmt19.executeQuery(getWaitlistID);
							if(result.next()){
								checkNull = result.getString("e");}
							else{checkNull = null;}
							
							int waitlistNum = 1;
							if(checkNull != null){
								waitlistNum = Integer.parseInt(checkNull) + 1;
							}
							String insertWaitlist = "insert into waitlist(Passenger_ID, Airline_ID, Flight_number, Date_purchased, Seat_class, Time_purchased, Waitlist_id, Ticket_number) values (" + passID + ",\"" + fourthFlightA + "\", " + fourthFlight + ", \"" + new java.sql.Date(utilDate.getTime()) + "\", \"" + cabin + "\", \""  + new java.sql.Time(utilDate.getTime()) + "\", "+ waitlistNum + "," + ticketNumber + ")";
							Statement stmt20 = con.createStatement();
							stmt20.executeUpdate(insertWaitlist);
						}
					}
				
					Statement stmt21 = con.createStatement();
					String checkSeatExists = "select * from seat s, flight f where f.Flight_number = s.Flight_number and Ticket_number = " + ticketNumber + " and f.Airline_ID = s.Airline_ID";
					result = stmt21.executeQuery(checkSeatExists);		
					double ticketCost = 0;
					String setTicketCost;
					if(cabin.equals("FIR")){
						out.print("Class: First");
						%> <br> <%
						while(result.next()){
							out.println("Flight #: " + result.getString("Airline_ID") + result.getString("Flight_number") + "   Flight Cost: " + result.getDouble("First_class_price"));
							%> <br> <%
							ticketCost = ticketCost + result.getDouble("First_class_price");
						}
					}
					if(cabin.equals("BUS")){
						out.print("Class: Business");
						%> <br> <%
						while(result.next()){
							out.println("Flight #: " + result.getString("Airline_ID") + result.getString("Flight_number") + "   Flight Cost: " + result.getDouble("Business_class_price"));
							%> <br> <%
							ticketCost = ticketCost + result.getDouble("Business_class_price");
						}
					}
					if(cabin.equals("ECO")){
						out.print("Class: Economy");
						%> <br> <%
						while(result.next()){
							out.println("Flight #: " + result.getString("Airline_ID") + result.getString("Flight_number") + " ------ Flight Cost: " + result.getDouble("Econ_class_price"));
							%> <br> <%
							ticketCost = ticketCost + result.getDouble("Econ_class_price");
						}
					}
					
					Statement stmt22 = con.createStatement();
					String checkWaitlistExists = "select * from waitlist w where w.Ticket_number = " + ticketNumber + "";
					result = stmt22.executeQuery(checkWaitlistExists);	
					while(result.next()){
						out.println("Flight #: " + result.getString("Airline_ID") + result.getString("Flight_number") + "   WAITLISTED! ");
						%> <br> <%
					}
					%> <br> <%
					out.println("Booking Fee: $50");
					%> <br> <%
					out.println("Total Fare: $" + ticketCost);
					%> <br> <%
					out.println("Total Purchase: $" + (ticketCost + 50));
					setTicketCost = "update ticket set Booking_fee = 50, Total_fare =" + ticketCost + " where Ticket_number =" + ticketNumber;
					stmt.executeUpdate(setTicketCost);
					db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
		
		session.setAttribute("firstFlight",null);
		session.setAttribute("secondFlight",null);
		session.setAttribute("thirdFlight",null);
		session.setAttribute("fourthFlight",null);
		session.setAttribute("firstFlightA",null);
		session.setAttribute("secondFlightA",null);
		session.setAttribute("thirdFlightA",null);
		session.setAttribute("fourthFlightA",null);
		session.setAttribute("flightType",null);
		session.setAttribute("firstLegLD",null);
		session.setAttribute("firstLegLT",null);
		session.setAttribute("editID",null);
		%>
	
	<form action= "../cusrepPage.jsp">
		<input type="submit" value="Return to Home Page"  />
	</form>
	</body>
</html>