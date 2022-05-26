<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reservation list by flight number</title>
</head>
<body>

<%
try {
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

	String fnum = request.getParameter("fnum");
	String airline = request.getParameter("airline");
	
	if(fnum == null || fnum.equals("")){
		out.println("Invalid input: flight number cannot be empty.");
	}
	else{
		Statement statement = con.createStatement();
		String query = "select Flight_number, Seat_number, Ticket_number from seat join flight using (Flight_number, Airline_ID) join ticket using (Ticket_number) where Flight_number = " +fnum+ " and Airline_ID = '" + airline +  "' union "
				+ " select Flight_number, (-1) as Seat_number, Ticket_number from waitlist join flight using (Flight_number, Airline_ID) join ticket using (Ticket_number) where Flight_number = " +fnum + " and Airline_ID = '" + airline + "'";
		
		
		ResultSet rs = statement.executeQuery(query);
		if(rs.next())
		{
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print("Flight number");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Seat number/status");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Ticket number");
			out.print("</td>");
			
			
			if(rs.getString("Ticket_number") != null)
			{
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				
				//print out User_ID
				String Flight_number = rs.getString("Flight_number");
				out.print(Flight_number);
				out.print("</td>");
				
				out.print("<td>");
				if(rs.getInt("Seat_Number") == -1){
					out.print("waitlisted");
				}
				else{
					out.print(rs.getString("Seat_Number"));
				}
				out.print("</td>");
				
				out.print("<td>");
				
				out.print(rs.getString("Ticket_number"));
				out.print("</td>");
				
				out.print("<td>");
			}
			

		}
		else
		{
			out.print("No reservations found for this flight number.");
		}
		

		//parse out the results
		while (rs.next()) {
			if(rs.getString("Ticket_number") != null)
			{
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				
				//print out User_ID
				String Flight_number = rs.getString("Flight_number");
				out.print(Flight_number);
				out.print("</td>");
				
				out.print("<td>");
				if(rs.getInt("Seat_Number") == -1){
					out.print("waitlisted");
				}
				else{
					out.print(rs.getString("Seat_Number"));
				}
				out.print("</td>");
				
				out.print("<td>");
				
				out.print(rs.getString("Ticket_number"));
				out.print("</td>");
				
				out.print("<td>");
			}
			
			
		}
		out.print("</table>");
		
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
<br>
<br>
<form action="adminPage.jsp">
	<input type="submit" value="Go back to Admin Page">
</form>
</body>
</html>