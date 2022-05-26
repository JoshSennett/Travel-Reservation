<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reservation list by first, last name</title>
</head>
<body>

<%
try {
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	
	if((fname == "") || (lname == ""))
	{
		out.print("Invalid input: missing first and/or last names");
	}
	else
	{
		Statement statement = con.createStatement();
		
				 
				 
				 

		String query = "SELECT c.First_name, c.Last_name, t.Passenger_ID, s.Seat_Number, t.Ticket_number, w.Waitlist_id AS is_waitlist, f.Flight_date, f.Flight_type, f.Airline_ID, f.Landing_airport_ID, f.Departing_airport_ID, f.Landing_date FROM ticket t RIGHT JOIN seat s ON t.Ticket_number = s.Ticket_number RIGHT JOIN flight f ON f.Flight_number = s.Flight_number LEFT JOIN waitlist w ON w.Ticket_number = t.Ticket_number right join customer c on c.Passenger_ID = t.Passenger_ID WHERE c.First_name = \'" + fname + "\' and c.Last_name = \'" + lname + "\'";

		ResultSet rs = statement.executeQuery(query);
		
		
		
		if(rs.next())
		{
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print("First_name");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Last_name");
			out.print("</td>");
			
			out.print("<td>");
			out.print("Passenger_ID");
			out.print("</td>");
			
		
			
			out.print("<td>");
			out.print("Waitlist status");
			out.print("</td>");		
			
			out.print("<td>");
			out.print("Flight date");
			out.print("</td>");		
			
			out.print("<td>");
			out.print("Flight type");
			out.print("</td>");		
			
			out.print("<td>");
			out.print("Airline ID");
			out.print("</td>");		
			
			out.print("<td>");
			out.print("Landing airport ID");
			out.print("</td>");		
			
			out.print("<td>");
			out.print("Departing airport ID");
			out.print("</td>");		
			
			out.print("<td>");
			out.print("Landing date");
			out.print("</td>");	
			

		}
		else
		{
			out.print("No reservations found for this name.");
		}
		


		//parse out the results
		while (rs.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			
			//print out User_ID
			String User_ID = rs.getString("First_name");
			out.print(User_ID);
			out.print("</td>");
			
			
			out.print("<td>");
		
			//prnt out accessLevel
			out.print(rs.getString("Last_name"));
			out.print("</td>");
			
			
			out.print("<td>");
			
			//prnt out accessLevel
			out.print(rs.getString("Passenger_ID"));
			out.print("</td>");
			
			out.print("<td>");
			if(rs.getString("is_waitlist") == null)
			{
				out.print("Not on waitlist");
			}
			else
			{
				out.print("On waitlist");
			}
			out.print("</td>");
			
			
			out.print("<td>");		
			out.print(rs.getString("Flight_date"));
			out.print("</td>");
			
			out.print("<td>");		
			out.print(rs.getString("Flight_type"));
			out.print("</td>");
			
			out.print("<td>");		
			out.print(rs.getString("Airline_ID"));
			out.print("</td>");
			
			out.print("<td>");		
			out.print(rs.getString("Landing_airport_ID"));
			out.print("</td>");
			
			out.print("<td>");		
			out.print(rs.getString("Departing_airport_ID"));
			out.print("</td>");
			
			out.print("<td>");		
			out.print(rs.getString("Landing_date"));
			out.print("</td>");
			out.print("<td>");
			
						
		}
		out.print("</table>");
		
		rs.close();
		statement.close();
		
	}
	
	con.close();
	
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