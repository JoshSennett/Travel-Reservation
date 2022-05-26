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
		<title>Cancel Flight</title>
		<style type="text/css">
       	td {border: 1px #DDD solid; padding: 5px; cursor: pointer;}
       	.selected {
                  background-color: brown;
                  color: #FFF;
                  }
          </style>
	</head>
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
	
	
		session = request.getSession();
		String ticketNumber = request.getParameter("ticket_number");
		
		try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//do for all flights
			Statement stmt = con.createStatement();
			String getPassengerID = "select Passenger_ID from customer where User_ID = \"" + userID + "\"";
			
			ResultSet result = stmt.executeQuery(getPassengerID);
			result.next();
			int passID = Integer.parseInt(result.getString("Passenger_ID"));
			
			Statement stmt2 = con.createStatement();
			String getChangeFee = "Select * from seat where Ticket_number = " + ticketNumber;
			result = stmt2.executeQuery(getChangeFee);
			double changeFee = 0;
			while(result.next()){
				String changeFeeStr = result.getString("Change_fee");
				changeFee = changeFee + Double.parseDouble(changeFeeStr);
			}
			
			
			Statement stmt3 = con.createStatement();
			Statement stmt4 = con.createStatement();
			
			String updateSeat = "update seat set Is_available = 1, Ticket_number = null where Ticket_number = " + ticketNumber;
			String updateWaitlist = "delete from waitlist where Ticket_number = " + ticketNumber;
			
			stmt3.executeUpdate(updateSeat);
			stmt4.executeUpdate(updateWaitlist);
			
			Statement stmt5 = con.createStatement();

			
			out.println("A cancelation fee of " + changeFee + " has been charged!");
			String updateTicket = "update ticket set Booking_fee = " + changeFee + ", Total_fare = " + 0 + " where Ticket_number = " + ticketNumber;
			stmt5.executeUpdate(updateTicket);
			
			//close the connection.
			db.closeConnection(con);
		
		} catch (Exception e) {
			out.print(e);
		}%>
	
	<form action= "../mainPage.jsp">
		<input type="submit" value="Return to Home Page"  />
	</form>
	</body>
</html>