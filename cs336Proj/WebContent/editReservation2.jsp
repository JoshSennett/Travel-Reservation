<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Edit user Reservation</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
			<h2> Reservation Edit </h2><br>
		<nav class="navar">
			<a href="cusrepPage.jsp" >Home</a>
			<a href="logOut.jsp">Logout</a>
	</nav>
	<!-- Checks to see if given ids exist, then checks to see if new ids are not valid to use. Then assigns new values -->
	<%
			String Ticket_number = request.getParameter("Ticket_number");
			String User_ID = request.getParameter("User_ID");
			
			try{
			//grabs changeFee for the seat associated with given ticket
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement statement = con.createStatement();
			Statement stmt2 = con.createStatement();
			String getChangeFee = "Select * from seat where Ticket_number = " + Ticket_number;
			ResultSet result = stmt2.executeQuery(getChangeFee);
			double changeFee = 0;
			while(result.next()){
				String changeFeeStr = result.getString("Change_fee");
				changeFee = changeFee + Double.parseDouble(changeFeeStr);
			}
			ResultSet rs = statement.executeQuery("SELECT * from customer c natural join ticket natural join seat WHERE c.User_ID  = \'"+User_ID+ "\'");
			if(rs.next()){
				//Updates the seat attributes that is associated with given ticket
			PreparedStatement ps1 = con.prepareStatement("update seat set Is_available = 1, Ticket_number = null where Ticket_number = \'" + Ticket_number+"\'");
			Statement stmt3 = con.createStatement();
			Statement stmt5 = con.createStatement();
				//deletes the waitlist row if ticket number is found within
			String updateWaitlist = "delete from waitlist where Ticket_number = " + Ticket_number;
			ps1.execute();
			stmt3.execute(updateWaitlist);
			ps1.close();
				//Announces change fee for the flight cancellation
			out.println("Reservation Cancelled");
			out.println("A cancelation fee of " + changeFee + " has been charged!");
			String updateTicket = "update ticket set Booking_fee = " + changeFee + ", Total_fare = " + 0 + " where Ticket_number = " + Ticket_number;
			stmt5.executeUpdate(updateTicket);
			}
			else{
				out.println("Failed to cancel reservation");
			}
			con.close();
			}catch (Exception e) {
				out.println("attributes not accepted!");
			}
			
			
	%>
</body>
</html>