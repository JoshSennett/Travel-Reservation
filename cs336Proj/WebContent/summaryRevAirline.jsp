<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Summary of revenues by airline ID</title>
</head>
<body>
	

	<%
	try {

		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		
		
		try{
			String AID = request.getParameter("AID");
			
			Statement statement2 = con.createStatement();
			String query2 = "select * from airline a where a.Airline_ID = \'" + AID + "\'";
					
			ResultSet rs2 = statement2.executeQuery(query2);
			
			boolean isDone = false;
			if(rs2.next())
			{		
				
				Statement statement6 = con.createStatement();
				String query = "SELECT t.Total_fare, t.Booking_fee, t.Ticket_number FROM ticket t, seat s WHERE s.Airline_ID = \'" + AID + "\' and s.Ticket_number = t.Ticket_number";
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
				out.print("No such airline.");
			}
			rs2.close();
			statement2.close();
			
			double total = 0;
			Statement statement = con.createStatement();
			String query = "SELECT t.Total_fare, t.Booking_fee, t.Ticket_number FROM ticket t, seat s WHERE s.Airline_ID = \'" + AID + "\' and s.Ticket_number = t.Ticket_number";
			ResultSet rs = statement.executeQuery(query);
			//parse out the results
			while (rs.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				
				String innerQ = "SELECT count(*) as thing from ticket t, seat s WHERE s.Airline_ID = \'" + AID + "\' and s.Ticket_number = t.Ticket_number and t.Ticket_number = " + rs.getString("Ticket_number");
				Statement innerStatement = con.createStatement();
				ResultSet inner = innerStatement.executeQuery(innerQ);
				double thing = 1;
				if(inner.next())
				{
					thing = inner.getDouble("thing");
				}
			
				
				
				//print out User_ID
				double totalFare = rs.getDouble("Total_fare");
				out.print(totalFare);
				out.print("</td>");
				out.print("<td>");
			
				//prnt out accessLevel
				double bookingFee = rs.getDouble("Booking_fee");
				bookingFee /= thing;
				out.print(bookingFee);
				out.print("</td>");
				out.print("<td>");
				
				total += totalFare + bookingFee;
				out.print(totalFare + bookingFee);
				out.print("</td>");
				out.print("<td>");
				
							
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
		catch(Exception e)
		{
			out.print("Invalid input: enter airline ID");
			out.print(e);
		}
		

	} catch (Exception e) {
		out.print(e);
	}
	%>



	<br>
	<br>
	<form action="adminPage.jsp">
		<input type="submit" value="Go back to Admin Page">
	</form>
</body>
</html>
