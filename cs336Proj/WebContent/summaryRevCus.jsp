<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Summary of revenues by customer ID</title>
</head>
<body>
	

	<%
	try {

		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		Statement statement = con.createStatement();
		String UID = request.getParameter("UID");
		String fareSumQuery = "SELECT if(Total_fare is null,0,t2.Total_fare) as Total_fare, if(Booking_fee is null,0,t2.Booking_fee) as Booking_fee, c2.User_ID FROM ticket t2 right join customer c2 using(Passenger_ID) WHERE c2.User_ID = \'" + UID+ "\'";

		ResultSet rs = statement.executeQuery(fareSumQuery);
		
		
		double total = 0;
		boolean isDone = false;
		if(rs.next())
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

			
			
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			
			//print out User_ID
			double totalFare = rs.getDouble("Total_fare");
			out.print(totalFare);
			out.print("</td>");
			out.print("<td>");
		
			//prnt out accessLevel
			double bookingFee = rs.getDouble("Booking_fee");
			out.print(bookingFee);
			out.print("</td>");
			out.print("<td>");
			
			total += totalFare + bookingFee;
			out.print(totalFare + bookingFee);
			out.print("</td>");
			out.print("<td>");
			
		}
		else
		{
			out.print("No such customer.");
		}
		
		
		//parse out the results
		while (rs.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			
			//print out User_ID
			double totalFare = rs.getDouble("Total_fare");
			out.print(totalFare);
			out.print("</td>");
			out.print("<td>");
		
			//prnt out accessLevel
			double bookingFee = rs.getDouble("Booking_fee");
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