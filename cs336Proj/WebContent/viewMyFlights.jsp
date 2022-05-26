<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>View Upcoming/Past Flights</title>
	<link rel="stylesheet" href="styles.css">
	<script src="script.js"></script>
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
		%>
		<br><br>
		<form action="logOut.jsp">
			<input type="submit" value="log out">
		</form>
		<br><br>
		<form action="mainPage.jsp">
			<input type="submit" value="Go to Main Page">
		</form>
		<br>
		<br>
		<h3 style="font-weight: bold;">View Upcoming/Past Flights</h3>

		<%
			String flight_type = request.getParameter("flight_type").trim();
			LocalDateTime ldt = LocalDateTime.now();
		%>
		<span>Search Option:&nbsp</span>
		<div class="dropdown">
			<button id="search_dropbutton" class="dropButton" onclick="showSearchOptions()"><%=flight_type%></button>
			<div id="search_dropdown" class="dropdownContent">
				<span onclick="selectFlightOption('All Flights')">All Flights</span>
				<span onclick="selectFlightOption('Upcoming Flights')">Upcoming Flights</span>
				<span onclick="selectFlightOption('Past Flights')">Past Flights</span>
			</div>
		</div>
		<span>&nbsp&nbsp&nbsp&nbsp</span>
		<form style="display:inline-block" action="viewMyFlights.jsp">
			<span>Search by flight type:&nbsp</span>
			<input id="search_option_flight" type="text" name="flight_type" value="<%=flight_type%>" style="display:none;">
			<button class=".btn">Search Flights</button>
		</form>
		<br><br>

		<%
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			String ticket_query = "select * from user join customer using (User_ID) join ticket using (Passenger_ID) where User_ID = '" + userID + "' order by Ticket_number desc;";
			Statement s = con.createStatement();
			ResultSet rs = s.executeQuery(ticket_query);
			
			//maybe implement pages later
			while(rs.next()){//for each ticket
				//create an array list for flights(including waitlisted ones)
				ArrayList<FlightEntry> fear = new ArrayList<>();
				
				int flights_count = 0;
				Statement flight_statement = con.createStatement();
				String flight_query = "select * from ticket join seat using (Ticket_number) where Ticket_number = " + rs.getInt("Ticket_number") + ";";
				ResultSet flight_resultSet = flight_statement.executeQuery(flight_query);
				while(flight_resultSet.next()){
					flights_count++;
					//query to get info about flight and everything
					Statement seat_statement = con.createStatement();
					String seat_query = "select * from flight join airline using (Airline_ID) where Flight_number = " + flight_resultSet.getInt("Flight_number") + " and Airline_ID = '" + flight_resultSet.getString("Airline_ID") + "'";
					ResultSet seat_resultSet = seat_statement.executeQuery(seat_query);
					seat_resultSet.next();
					
					Statement airport_statement1 = con.createStatement();
					ResultSet airport_resultSet1 = airport_statement1.executeQuery("select name from airport where Airport_ID = '" + seat_resultSet.getString("Departing_airport_ID") +"';");
					airport_resultSet1.next();
					String departing_airport = airport_resultSet1.getString("name");
					Statement airport_statement2 = con.createStatement();
					ResultSet airport_resultSet2 = airport_statement2.executeQuery("select name from airport where Airport_ID = '" + seat_resultSet.getString("Landing_airport_ID") +"';");
					airport_resultSet2.next();
					String landing_airport = airport_resultSet2.getString("name");
					
					FlightEntry fe = new FlightEntry(flight_resultSet.getInt("Flight_number"), seat_resultSet.getString("Flight_type"), seat_resultSet.getString("name"),
							flight_resultSet.getString("Class"),seat_resultSet.getString("Flight_date"),seat_resultSet.getString("Take_off_time"),
							seat_resultSet.getString("Landing_date"),seat_resultSet.getString("Landing_time"),departing_airport,landing_airport,
							flight_resultSet.getInt("Seat_number"),flight_resultSet.getBigDecimal("Change_fee"));
					fear.add(fe);
					
					seat_resultSet.close();
					seat_statement.close();
					airport_resultSet1.close();
					airport_statement1.close();
					airport_resultSet2.close();
					airport_statement2.close();
				}
				flight_resultSet.close();
				flight_statement.close();
				
				Statement waitlist_statement = con.createStatement();
				String waitlist_query = "select * from waitlist where Ticket_number = " + rs.getInt("Ticket_number") + ";";
				ResultSet waitlist_resultSet = waitlist_statement.executeQuery(waitlist_query);
				while(waitlist_resultSet.next()){
					flights_count++;
					//query to get info about flight and everything for the waitlisted flights
					Statement w_flight_statement = con.createStatement();
					String w_flight_query = "select * from flight join airline using (Airline_ID) where Flight_number = " + waitlist_resultSet.getInt("Flight_number") + " and Airline_ID = '" + waitlist_resultSet.getString("Airline_ID") + "'";
					ResultSet w_flight_resultSet = w_flight_statement.executeQuery(w_flight_query);
					w_flight_resultSet.next();
					
					Statement airport_statement1 = con.createStatement();
					ResultSet airport_resultSet1 = airport_statement1.executeQuery("select name from airport where Airport_ID = '" + w_flight_resultSet.getString("Departing_airport_ID") +"';");
					airport_resultSet1.next();
					String departing_airport = airport_resultSet1.getString("name");
					Statement airport_statement2 = con.createStatement();
					ResultSet airport_resultSet2 = airport_statement2.executeQuery("select name from airport where Airport_ID = '" + w_flight_resultSet.getString("Landing_airport_ID") +"';");
					airport_resultSet2.next();
					String landing_airport = airport_resultSet2.getString("name");
					
					FlightEntry fe = new FlightEntry(waitlist_resultSet.getInt("Flight_number"),w_flight_resultSet.getString("Flight_type"),w_flight_resultSet.getString("name"),
							waitlist_resultSet.getString("Seat_class"),w_flight_resultSet.getString("Flight_date"),w_flight_resultSet.getString("Take_off_time"),
							w_flight_resultSet.getString("Landing_date"), w_flight_resultSet.getString("Landing_time"), departing_airport, landing_airport, -1,null);
					fear.add(fe);
					
					w_flight_resultSet.close();
					w_flight_statement.close();
					airport_resultSet1.close();
					airport_statement1.close();
					airport_resultSet2.close();
					airport_statement2.close();
				}
				waitlist_resultSet.close();
				waitlist_statement.close();
				
				//sort fear based on flight date 
				fear.sort(new Comparator<FlightEntry>(){
					public int compare(FlightEntry fe1, FlightEntry fe2){
						return fe1.compareTo(fe2);
					}
				});
				
				//html part
				if(flights_count == 0){//flight has been cancelled
					if(flight_type.compareTo("Upcoming Flights") != 0){
						//write out flight has been cancelled (if searching for past flights)
						%>
						<div class="ticketBox">
							<table class="ticketTable">
								<tr>
									<td class="flight_search_indicator">Cancelled</td>
									<td>
										<span class="ticketBoxTitle"> Ticket Number: <%=rs.getString("Ticket_number")%>&nbsp&nbsp&nbsp&nbspDate Purchased: <%=rs.getString("Date_purchased") %></span>
									</td>
								</tr>
							</table>
							<br>
							<div>Booking/Cancellation Fee: <%=rs.getBigDecimal("Booking_fee")%></div>
						</div>
						<%	
					}
				}
				else{
					//check past/upcoming requirements
					if(flight_type.compareTo("Upcoming Flights") == 0){
						if(!fear.get(0).Flight_date_time.isBefore(ldt)){
							%>
							<div class="ticketBox">
								<table class="ticketTable">
									<tr>
										<td class="flight_search_indicator">Upcoming</td>
										<td>
											<pre class="ticketBoxTitle"> Ticket Number: <%=rs.getString("Ticket_number")%>    Date Purchased: <%=rs.getString("Date_purchased") %></pre><hr>
											<%
											for(int i = 0; i < fear.size(); i++){
												%>
												<pre>Flight Number: <%=fear.get(i).Flight_number%>    Airline: <%=fear.get(i).Airline%>    Class: <%=fear.get(i).Class%></pre>
												<% 
												if(fear.get(i).Seat_number == -1){//waitlisted
													%>
													<pre>Departure Airport: <%=fear.get(i).Departing_airport%>      Landing Airport: <%=fear.get(i).Landing_airport%></pre>
													<pre>waitlisted    Departure time: <%=fear.get(i).getFlight_date_time()%>    Landing time: <%=fear.get(i).getLanding_date_time()%></pre><hr>
													<% 
												}
												else{//not waitlisted
													%>
													<pre>Departure Airport: <%=fear.get(i).Departing_airport%>      Landing Airport: <%=fear.get(i).Landing_airport%></pre>
													<pre>Seat Number: <%=fear.get(i).Seat_number%>    Departure time: <%=fear.get(i).getFlight_date_time()%>    Landing time: <%=fear.get(i).getLanding_date_time()%></pre>
													<span>Change Fee: <%=fear.get(i).Change_fee%></span><br><hr>
													<% 
												}
											}
											%>
										</td>
									</tr>
								</table>
								<br>
								<div>Booking Fee: <%=rs.getBigDecimal("Booking_fee")%></div>
								<div>Total Fare: <%=rs.getBigDecimal("Total_fare")%></div>
								<br>
								<form action="mainPage/cancelFlight.jsp">
									<button>Cancel this Flight</button>
									<input type="text" style="display:none;" name="ticket_number" value="<%=rs.getInt("Ticket_number")%>">
								</form>
							</div>
							<%
						}
					}
					else if(flight_type.compareTo("Past Flights") == 0){
						if(fear.get(0).Flight_date_time.isBefore(ldt)){
							%>
							<div class="ticketBox">
								<table class="ticketTable">
									<tr>
										<td class="flight_search_indicator">Past</td>
										<td>
											<pre class="ticketBoxTitle"> Ticket Number: <%=rs.getString("Ticket_number")%>    Date Purchased: <%=rs.getString("Date_purchased") %></pre><hr>
											<%
											for(int i = 0; i < fear.size(); i++){
												%>
												<pre>Flight Number: <%=fear.get(i).Flight_number%>    Airline: <%=fear.get(i).Airline%>    Class: <%=fear.get(i).Class%></pre>
												<% 
												if(fear.get(i).Seat_number == -1){//waitlisted
													%>
													<pre>Departure Airport: <%=fear.get(i).Departing_airport%>      Landing Airport: <%=fear.get(i).Landing_airport%></pre>
													<pre>waitlisted    Departure time: <%=fear.get(i).getFlight_date_time()%>    Landing time: <%=fear.get(i).getLanding_date_time()%></pre><hr>
													<% 
												}
												else{//not waitlisted
													%>
													<pre>Departure Airport: <%=fear.get(i).Departing_airport%>      Landing Airport: <%=fear.get(i).Landing_airport%></pre>
													<pre>Seat Number: <%=fear.get(i).Seat_number%>      Departure time: <%=fear.get(i).getFlight_date_time()%>    Landing time: <%=fear.get(i).getLanding_date_time()%></pre>
													<span>Change Fee: <%=fear.get(i).Change_fee%></span><br><hr>
													<% 
												}
											}
											%>
										</td>
									</tr>
								</table>
								<br>
								<div>Booking Fee: <%=rs.getBigDecimal("Booking_fee")%></div>
								<div>Total Fare: <%=rs.getBigDecimal("Total_fare")%></div>
								<br>
							</div>
							<%
						}
					}
					else{
						String All_Flights_indicator = "Past";
						if(!fear.get(0).Flight_date_time.isBefore(ldt)){
							All_Flights_indicator = "Upcoming";
						}
						%>
						<div class="ticketBox">
							<table class="ticketTable">
								<tr>
									<td class="flight_search_indicator"><%=All_Flights_indicator%></td>
									<td>
										<pre class="ticketBoxTitle"> Ticket Number: <%=rs.getString("Ticket_number")%>    Date Purchased: <%=rs.getString("Date_purchased") %></pre><hr>
										<%
										for(int i = 0; i < fear.size(); i++){
											%>
											<pre>Flight Number: <%=fear.get(i).Flight_number%>    Airline: <%=fear.get(i).Airline%>    Class: <%=fear.get(i).Class%></pre>
											<% 
											if(fear.get(i).Seat_number == -1){//waitlisted
												%>
												<pre>Departure Airport: <%=fear.get(i).Departing_airport%>      Landing Airport: <%=fear.get(i).Landing_airport%></pre>
												<pre>waitlisted    Departure time: <%=fear.get(i).getFlight_date_time()%>    Landing time: <%=fear.get(i).getLanding_date_time()%></pre><hr>
												<% 
											}
											else{//not waitlisted
												%>
												<pre>Departure Airport: <%=fear.get(i).Departing_airport%>      Landing Airport: <%=fear.get(i).Landing_airport%></pre>
												<pre>Seat Number: <%=fear.get(i).Seat_number%>      Departure time: <%=fear.get(i).getFlight_date_time()%>    Landing time: <%=fear.get(i).getLanding_date_time()%></pre>
												<span>Change Fee: <%=fear.get(i).Change_fee%></span><br><hr>
												<% 
											}
										}
										%>
									</td>
								</tr>
							</table>
							<br>
							<div>Booking Fee: <%=rs.getBigDecimal("Booking_fee")%></div>
							<div>Total Fare: <%=rs.getBigDecimal("Total_fare")%></div>
							<br>
							<% if(!fear.get(0).Flight_date_time.isBefore(ldt)){ %>
								<form action="mainPage/cancelFlight.jsp">
								<button>Cancel this Flight</button>
								<input type="text" style="display:none;" name="ticket_number" value="<%=rs.getInt("Ticket_number")%>">
							</form>
							<% } %>
						</div>
						<%
					}
				}	
			}
			rs.close();
			s.close();
			con.close();
			%>
	</div>
</body>
</html>