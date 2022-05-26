<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Customer Representative Page</title>
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

	<h1> Online Travel Reservation System </h1>
		<nav class="navar">
			<a href="cusrepPage.jsp" >Home</a>
			<a href="logOut.jsp">Logout</a>
	</nav>
	<div>
		<%
		out.println("Hello, Customer Representative!");
		%>
		<section class="Edit User Reservation">
				<p>Book Flights for User</p>
		<div class="container">
			<form class="Edit User Reservation" method="post" action="cusrepPage/book.jsp">
				<input type="text" placeholder="User Id" name="User_ID" required>
				<button>Book</button>
			</form>
		</div>
		<section class="Edit User Reservation">
				<p>Edit Flights for User</p>
		<div class="container">
			<form class="Edit User Reservation" method="post" action="editReservation.jsp">
				<input type="text" placeholder="User Id" name="User_ID" required>
				<button>Edit</button>
			</form>
		</div>
		<br>
		</section>
		<form action="createAircraft.jsp">
			<input type="submit" value="Add an aircraft">
		</form>
		<div><br>
		<form action="createAirport.jsp">
			<input type="submit" value="Add an airport">
		</form>
		<div><br>
		<form action="createFlight.jsp">
			<input type="submit" value="Add a flight">
		</form>
		<div><br>
		<form action="editAircraft.jsp">
			<input type="submit" value="edit an aircraft">
		</form>
		<div><br>
		<form action="editAirport.jsp">
			<input type="submit" value="edit an airport">
		</form>
		<div><br>
		<form action="editFlight.jsp">
			<input type="submit" value="edit a flight">
		</form>
		<div><br>
		<section class="Delete Aircraft">
				<p>Delete Aircraft</p>
		<div class="container">
			<form class="Delete Aircraft" method="post" action="deleteAircraft.jsp">
					<tr>
					<td><label for="Aircraft_Id">Aircraft Id</label></td>
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
					<td><label for="Airline_Id">Airline Id</label></td>	
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
				<button>Delete</button>
			</form>
		</div>
		<br>
		</section>
		<section class="Delete Airport">
				<p>Delete Airport</p>
		<div class="container">
			<form class="Delete Airport" method="post" action="deleteAirport.jsp">
				<tr>
					<td><label for="Airport_Id">airport ID</label></td>
					<td>
						<select name="Airport_Id" id=Airport_Id size=1>
							<%
							result = stmt.executeQuery(str);
							while(result.next()){
								out.print("<option value='" + result.getString("Airport_ID") + "' selected>" + result.getString("Airport_ID") + "</option>");
							}
							%>				
						</select>
					</td>
				</tr>
				<button>Delete</button>
			</form>
		</div>
		<br>
		</section>
		<section class="Delete Flight">
				<p>Delete Flight</p>
		<div class="container">
			<form class="Delete Flight" method="post" action="deleteFlight.jsp">
				<input type="text" placeholder="Flight Number" name="Flight_number" required>
								<tr>
					<td><label for="Airline_Id">Airline Id</label></td>
					<td>
						<select name="Airline_Id" id=Airline_Id size=1>
						<%
						result = stmt2.executeQuery(str2);
							while(result.next()){
								out.print("<option value='" + result.getString("Airline_ID") + "' >" + result.getString("Airline_ID") + "</option>");
							}
						%>				
						</select>
					</td>
				</tr>
				<button>Delete</button>
			</form>
		</div>
		<br>
		</section>
		<section class="AirportFlights">
		<p>Search for passengers on a waitlist</p>
		<div class="container">
		
			<form class="AirportFlights" method="post" action="SearchWaitlist.jsp" required>
				<input type="text" placeholder="Flight Number" name="Flight_number" required>
				<select name="Airline_Id" id=Airline_Id size=1>
						<%
						result = stmt2.executeQuery(str2);
							while(result.next()){
								out.print("<option value='" + result.getString("Airline_ID") + "' >" + result.getString("Airline_ID") + "</option>");
							}
						%>				
						</select>
				<button>Search</button>
			</form>
		</div>
		<br>
		</section>
		<section class="AirportFlights">
		<p>Search for flights at a given airport</p>
		<div class="container">
			<form class="AirportFlights" method="post" action="AirportFlights.jsp" required>
				<tr>
					<td><label for="Airport ID">airport ID</label></td>
					<td>
						<select name="Airport ID" id=Airport ID size=1>
							<%
							result = stmt3.executeQuery(str);
							while(result.next()){
								out.print("<option value='" + result.getString("Airport_ID") + "' selected>" + result.getString("Airport_ID") + "</option>");
							}
							%>				
						</select>
					</td>
				</tr>
				<button>Search</button>
			</form>
		</div>
		<br>
		</section>
	</div>
	<div>
	
		<form action="cusrep_questionForumPage.jsp">
			<input type="text" name="search_value" value="" style="display:none;">
			<input style="display:none;" name="search_option" type="text" value="All Posts">
			<input type="text" name="page_num" value="1" style="display:none;">
			<input type="submit" value="Go to Question Forum">
		</form>
	
		<br><br>
		<form action="logOut.jsp">
			<input type="submit" value="log out">
		</form>
	</div>
	<% 
		db.closeConnection(con);
		} catch (Exception e){
			out.print(e);
		}
		%>
</body>
</html>