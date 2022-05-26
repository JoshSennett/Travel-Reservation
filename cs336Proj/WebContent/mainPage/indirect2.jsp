<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" href="styles.css">
		<title>Indirect Return</title>
	</head>
	<body>
	<h1> Return Flights that match your search!  </h1>
	
	<% 
	session = request.getSession();
	String userID = (String)session.getAttribute("ID");
	if(userID == null){ 
	
	%>
		<jsp:forward page = "index.jsp"/>
		
	<% } %>
		<% 
		session = request.getSession();
		String destination = (String)session.getAttribute("departing");
		String departing = (String)session.getAttribute("destination");
		String airline = (String)session.getAttribute("airline");
		String firstLegLD = (String)session.getAttribute("firstLegLD");
		String firstLegLT = (String)session.getAttribute("firstLegLT");
		String cabin = (String)session.getAttribute("cabin");
		String sort = (String)session.getAttribute("sort");
		
		String flexibility = (String)session.getAttribute("flexibility");
		String returnDate = (String)session.getAttribute("returningDate");
		String validDate;
		
		if(flexibility.equals("definite")){
			validDate = " and Flight_date1 = '" + returnDate + "'";
		}else{
			validDate = " and Flight_date1 > (Date_SUB('" + returnDate + "', INTERVAL 3 DAY)) and Flight_date1 < (Date_ADD('" + returnDate + "', INTERVAL 3 DAY)) ";
		}
		
		String takeoffFilter = (String)session.getAttribute("takeoffFilter2");
		String landingFilter = (String)session.getAttribute("landingFilter2");
		String filters = "";
		
		if(!takeoffFilter.equals("")){
			filters =  filters + " and Take_off_time1 = '" + takeoffFilter + "'";
		}
		if(!landingFilter.equals("")){
			filters = filters + " and Landing_time2 = '" + landingFilter + "'";
		}
		
		String cabinPrice1 = "Econ_class_price1";
		String cabinPrice2 = "Econ_class_price2";
		String maxPrice = (String)session.getAttribute("maxPrice");
		if(cabin.equals("FIR")){
			cabinPrice1 = "First_class_price1";
			cabinPrice2 = "First_class_price2";
			if(sort.equals("Price")){
				sort = "First_class_price1 + First_class_price2";
			}
			if(maxPrice != null && !maxPrice.equals("")){
				filters = filters + " and First_class_price1 <= '" + maxPrice + "'";
				filters = filters + " and First_class_price2 <= '" + maxPrice + "'";
			}
		}
		if(cabin.equals("BUS")){
			cabinPrice1 = "Business_class_price1";
			cabinPrice2 = "Business_class_price2";
			if(sort.equals("Price")){
				sort = "Business_class_price1 + First_class_price2";
			}
			if(maxPrice != null && !maxPrice.equals("")){
				filters = filters + " and Business_class_price1 <= '" + maxPrice + "'";
				filters = filters + " and Business_class_price2 <= '" + maxPrice + "'";
			}
		}
		if(cabin.equals("ECO")){
			cabinPrice1 = "Econ_class_price1";
			cabinPrice2 = "Econ_class_price2";
			if(sort.equals("Price")){
				sort = "Econ_class_price1 + First_class_price2";
			}
			if(maxPrice != null && !maxPrice.equals("")){
				filters = filters + " and Econ_class_price1 <= '" + maxPrice + "'";
				filters = filters + " and Econ_class_price2 <= '" + maxPrice + "'";
			}
		}
		
		if(sort.equals("Landing_time")){
			sort = "Landing_time1";
		}
		if(sort.equals("Takeoff_time")){
			sort = "Takeoff_time1";
		}
		try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "select * from "
					+ "(select Flight_number Flight_number1,Econ_class_price Econ_class_price1, Business_class_price Business_class_price1, First_class_price First_class_price1, Flight_date Flight_date1, Take_off_time Take_off_time1, Landing_time Landing_time1, Landing_airport_ID Landing_airport_ID1, Departing_airport_ID Departing_airport_ID1, Aircraft_ID Aircraft_ID1, Airline_ID Airline_ID1, Flight_type Flight_type1, Landing_date Landing_date1, (TIMESTAMPDIFF(minute, Flight_date, Landing_date) + TIMESTAMPDIFF(minute, Take_off_time, Landing_time)) Duration1  from flight) f1, "
					+ "(select Flight_number Flight_number2,Econ_class_price Econ_class_price2, Business_class_price Business_class_price2, First_class_price First_class_price2, Flight_date Flight_date2, Take_off_time Take_off_time2, Landing_time Landing_time2, Landing_airport_ID Landing_airport_ID2, Departing_airport_ID Departing_airport_ID2, Aircraft_ID Aircraft_ID2,  Airline_ID Airline_ID2, Flight_type Flight_type2, Landing_date Landing_date2, (TIMESTAMPDIFF(minute, Flight_date, Landing_date) + TIMESTAMPDIFF(minute, Take_off_time, Landing_time)) Duration2  from flight) f2 " 
					+ "where ((Landing_date1 = Flight_date2 and Landing_time1 < Take_off_time2) or (Landing_date1 < Flight_date2)) and Landing_airport_ID1 = Departing_airport_ID2 and Landing_airport_ID2 = \"" + destination + "\" and Departing_airport_ID1 = \"" + departing +"\" and (( '" + firstLegLD + "' = Flight_Date1 and '" + firstLegLT + "' < Take_off_time1) or ( '" + firstLegLD + "' < Flight_date1)) " + validDate + " and Flight_date1 >= CURDATE() order by " + sort + "";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table id = "table" border = "1px solid black" style="margin-left:auto;margin-right:auto;text-align:center">
		<tr style="text-align:center"> 
		   	<td></td>
			<td>Flight #1</td>
			<td>Price</td>
			<td>Date</td>
			<td>Takeoff Time</td>
			<td>Landing Time</td>
			<td>Airline</td>
			<td>Type</td>
			<td>Departs From</td>
			<td>Lands At</td>
			<td>Aircraft ID</td>
			<td>Duration (min)</td>
			
			<td>Flight #2</td>
			<td>Price</td>
			<td>Date</td>
			<td>Takeoff Time</td>
			<td>Landing Time</td>
			<td>Airline</td>
			<td>Type</td>
			<td>Departs From</td>
			<td>Lands At</td>
			<td>Aircraft ID</td>
			<td>Duration (min)</td>
			
			<td>Total Duration (min)</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr style="text-align:right">  
					<%out.print("<td><form action=\"addTickets.jsp\"> <input type=\"hidden\" name=\"thirdFlight\" value=\"" + result.getString("Flight_Number1") + "\" /> <input type=\"hidden\" name=\"thirdFlightA\" value=\"" + result.getString("Airline_ID1") + "\" /> <input type=\"hidden\" name=\"fourthFlight\" value=\"" + result.getString("Flight_Number2") + "\" /> <input type=\"hidden\" name=\"fourthFlightA\" value=\"" + result.getString("Airline_ID2") + "\" />  <input type=\"submit\" value=\"Book\"> </form></td> ");   
					%>  
					<td><%= result.getString("Flight_number1") %></td>
					<td><%= result.getString(cabinPrice1) %></td>
					<td><%=result.getString("Flight_date1") %></td>
					<td><%=result.getString("Take_off_time1") %></td>
					<td><%=result.getString("Landing_time1") %></td>
					<td><%=result.getString("Airline_ID1") %></td>
					<td><%=result.getString("Flight_type1") %></td>
					<td><%=result.getString("Departing_airport_ID1") %></td>
					<td><%=result.getString("Landing_airport_ID1") %></td>
					<td><%=result.getString("Aircraft_ID1") %>
					<td><%=result.getString("Duration1") %>
					<td><%= result.getString("Flight_number2") %></td>
					<td><%= result.getString(cabinPrice2) %></td>
					<td><%=result.getString("Flight_date2") %></td>
					<td><%=result.getString("Take_off_time2") %></td>
					<td><%=result.getString("Landing_time2") %></td>
					<td><%=result.getString("Airline_ID2") %></td>
					<td><%=result.getString("Flight_type2") %></td>
					<td><%=result.getString("Departing_airport_ID2") %></td>
					<td><%=result.getString("Landing_airport_ID2") %></td>
					<td><%=result.getString("Aircraft_ID2") %>
					<td><%=result.getString("Duration2") %>
					<td><%= result.getInt("Duration2") + result.getInt("Duration1") %></td>
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>
    
			
		<% } catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>