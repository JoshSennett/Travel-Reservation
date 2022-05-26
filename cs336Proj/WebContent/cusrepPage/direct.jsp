<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Direct</title>
		<link rel="stylesheet" href="styles.css">
	</head>
	<h1> Flights that match your search!  </h1>
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
	}  %>
		<% 
		session = request.getSession();
		
		session.setAttribute("landingFilter1",(String)request.getParameter("landingFilter1"));	
		session.setAttribute("takeoffFilter1",(String)request.getParameter("takeoffFilter1"));	
		session.setAttribute("landingFilter2",(String)request.getParameter("landingFilter2"));	
		session.setAttribute("takeoffFilter2",(String)request.getParameter("takeoffFilter2"));
		
		String cabin = (String)session.getAttribute("cabin");
		String departing = (String)session.getAttribute("departing");
		String destination = (String)session.getAttribute("destination");
		String airline = (String)session.getAttribute("airline");
		String sort = (String)session.getAttribute("sort");
		String flexibility = (String)session.getAttribute("flexibility");
		String departingDate = (String)request.getParameter("departingDate");
		String returnDate = (String)request.getParameter("returningDate");
		session.setAttribute("departingDate",departingDate);
		session.setAttribute("returningDate",returnDate);
		String validDate;
		
		if(flexibility.equals("definite")){
			validDate = " and Flight_date = '" + departingDate + "'";
		}else{
			validDate = " and Flight_date > (Date_SUB('" + departingDate + "', INTERVAL 3 DAY)) and Flight_date < (Date_ADD('" + departingDate + "', INTERVAL 3 DAY)) ";
		}
		
		
		String takeoffFilter = (String)session.getAttribute("takeoffFilter1");
		String landingFilter = (String)session.getAttribute("landingFilter1");
		String filters = "";
		
		if(!takeoffFilter.equals("")){
			filters =  filters + " and Take_off_time = '" + takeoffFilter + "'";
		}
		if(!landingFilter.equals("")){
			filters = filters + " and Landing_time = '" + landingFilter + "'";
		}
		
		if(!airline.equals("--")){
			filters = filters + " and Airline_ID =\"" + airline + "\"";
		}
		
		String cabinPrice = "Econ_class_price";
		String maxPrice = (String)session.getAttribute("maxPrice");
		if(cabin.equals("FIR")){
			cabinPrice = "First_class_price";
			if(sort.equals("Price")){
				sort = "First_class_price";
			}
			if(maxPrice != null && !maxPrice.equals("")){
				filters = filters + " and First_class_price <= '" + maxPrice + "'";
			}
		}
		if(cabin.equals("BUS")){
			cabinPrice = "Business_class_price";
			if(sort.equals("Price")){
				sort = "Business_class_price";
			}
			if(maxPrice != null && !maxPrice.equals("")){
				filters = filters + " and Business_class_price <= '" + maxPrice + "'";
			}
		}
		if(cabin.equals("ECO")){
			cabinPrice = "Econ_class_price";
			if(sort.equals("Price")){
				sort = "Econ_class_price";
			}
			if(maxPrice != null && !maxPrice.equals("")){
				filters = filters + " and Econ_class_price <= '" + maxPrice + "'";
			}
		}
		
		if(sort.equals("Duration")){
			sort = "(TIMESTAMPDIFF(minute, Flight_date, Landing_date) + TIMESTAMPDIFF(minute, Take_off_time, Landing_time))";
		}
		
		
		
		try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			
			String str = "select *, (TIMESTAMPDIFF(minute, Flight_date, Landing_date) + TIMESTAMPDIFF(minute, Take_off_time, Landing_time)) Duration from flight where Departing_airport_ID = \"" + departing + 
			"\" and Landing_airport_ID = \"" + destination + "\" " + validDate + filters + " and Flight_date >= CURDATE() order by " + sort;

			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
	<table border = "1px solid black" id="table" style="margin-left:auto;margin-right:auto;text-align:center">
		<tr style="text-align:center">  
			<td></td>  
			<td>Flight #</td>
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
		</tr >
			<%
			//parse out the results
			while (result.next()) { %>
				<tr style="text-align:right">
					<%out.print("<td><form action=\"addTickets.jsp\"> <input type=\"hidden\" name=\"firstFlight\" value=\"" + result.getString("Flight_Number") + "\" /> <input type=\"hidden\" name=\"firstFlightA\" value=\"" + result.getString("Airline_ID") + "\" /> <input type=\"hidden\" name=\"firstFlightLD\" value=\"" + result.getString("Landing_date") + "\" /> <input type=\"hidden\" name=\"firstFlightLT\" value=\"" + result.getString("Landing_time") + "\" /> <input type=\"submit\" value=\"Book\"> </form></td> ");   
					%><td><%= result.getString("Flight_Number") %></td>
					<td><%= result.getString(cabinPrice) %></td>
					<td><%=result.getString("Flight_date") %></td>
					<td><%=result.getString("Take_off_time") %></td>
					<td><%=result.getString("Landing_time") %></td>
					<td><%=result.getString("Airline_ID") %></td>
					<td><%=result.getString("Flight_type") %></td>
					<td><%=result.getString("Departing_airport_ID") %></td>
					<td><%=result.getString("Landing_airport_ID") %></td>
					<td><%=result.getString("Landing_airport_ID") %></td>
					<td><%=result.getString("Duration") %>
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