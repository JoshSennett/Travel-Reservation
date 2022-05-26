<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Summary of revenues by flight number</title>
</head>
<body>

<%
	try { 
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

	String fnum = request.getParameter("fnum");
	
	if(fnum == null || fnum.equals("")){
		out.println("Invalid input: flight  number cannot be empty");	
	}
	else{
		String airline = request.getParameter("airline");
		
		Statement statement2 = con.createStatement();
		String query2 = "select * from flight f, airline a where f.Flight_number = " + fnum + " and a.Airline_ID = \'" + airline + "\'";
		ResultSet rs2 = statement2.executeQuery(query2);
		
		boolean isDone = false;
		if(rs2.next())
		{		
			
			Statement statement6 = con.createStatement();
			String query = "select Flight_number, Seat_number, Booking_fee, Ticket_number, Class,  First_class_price, Business_class_price, Econ_class_price from seat join flight using (Flight_number, Airline_ID) join ticket using (Ticket_number) where Flight_number = " +fnum+ " and Airline_ID = '" + airline +  "' union "
					+ " select Flight_number, (-1) as Seat_number, Booking_fee, First_class_price, Seat_class as Class, Business_class_price, Econ_class_price, Ticket_number from waitlist join flight using (Flight_number, Airline_ID) join ticket using (Ticket_number) where Flight_number = " +fnum + " and Airline_ID = '" + airline + "'";
			ResultSet rs6 = statement6.executeQuery(query);
			
			if(!rs6.next())
			{
				out.print("No revenues associated with this flight.");
			}
			else
			{
				out.print("<table>");

				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print("Fare");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Booking fee");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Total");
				out.print("</td>");
				isDone = true;
			}
			rs6.close();
			statement6.close();
			
		}
		else
		{
			out.print("No such flight.");
		}
		rs2.close();
		statement2.close();

		double total = 0;
		//parse out the results
		
		Statement statement = con.createStatement();
		String query = "select Flight_number, Booking_fee, Seat_number, Ticket_number, First_class_price, Business_class_price, Econ_class_price, Class from seat join flight using (Flight_number, Airline_ID) join ticket using (Ticket_number) where Flight_number = " +fnum+ " and Airline_ID = '" + airline +  "' union "
				+ " select Flight_number,  Booking_fee, (-1) as Seat_number, Ticket_number, First_class_price, Business_class_price, Econ_class_price, Seat_class as Class from waitlist join flight using (Flight_number, Airline_ID) join ticket using (Ticket_number) where Flight_number = " +fnum + " and Airline_ID = '" + airline + "'";
		ResultSet rs = statement.executeQuery(query);
		
		while (rs.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			
			//print out User_ID
			double Econ_class_price = rs.getDouble("Econ_class_price");
			double Business_class_price = Double.parseDouble(rs.getString("Business_class_price"));
			double First_class_price = rs.getDouble("First_class_price");
			String flightClass = rs.getString("class");
			double totalFare = 0;

			
			if(rs.getInt("Seat_number") != -1){
				if(flightClass.equals("BUS"))
				{
					totalFare = rs.getDouble("Business_class_price");
				}
				if(flightClass.equals("ECO"))
				{
					totalFare = rs.getDouble("Econ_class_price");
				}
				if(flightClass.equals("FIR"))
				{
					totalFare = rs.getDouble("First_class_price");
				}
			}
			out.print("<td>");
			out.print(totalFare);
			out.print("</td>");
			
			
			String innerQ = "SELECT count(distinct(f.Flight_number)) as thing from flight f, seat s, airline a WHERE f.Flight_number = s.Flight_number  and f.Airline_ID = s.Airline_ID and s.Ticket_number =" + rs.getDouble("Ticket_number");
			Statement innerStatement = con.createStatement();
			ResultSet inner = innerStatement.executeQuery(innerQ);
			double thing = 1;
			if(inner.next())
			{
				thing = inner.getDouble("thing");
			}
			
			
			
			
			
			
			out.print("<td>");
			double bookingFee = rs.getDouble("Booking_fee");
			if(rs.getInt("Seat_number") == -1){
				bookingFee = 0;
			}
			bookingFee /= thing;
			out.print(bookingFee);
			out.print("</td>");
			
			out.print("<td>");
			total += totalFare + bookingFee;
			out.print(totalFare + bookingFee);
			out.print("</td>");
						
		}
		out.print("</table>");
		
		if(isDone)
		{
			out.print("<br>");
			out.print("<td>");
			out.print("Grand total: " + total);
			out.print("</td>");
		}
		
		rs.close();
		statement.close();
		con.close();
	}	
	
 }


catch (Exception e)
{
	out.print(e);
} 

%>

<form action="adminPage.jsp">
	<input type="submit" value="Go back to Admin Page">
</form>
</body>
</html>