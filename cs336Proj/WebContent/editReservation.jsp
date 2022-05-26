<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Edit User Reservation</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
		<h2> Reservation Edit </h2><br>
	<nav class="navar">
		<a href="cusrepPage.jsp" >Home</a>
		<a href="logOut.jsp">Logout</a>
	</nav>
	
	<%
/* 		try{ */
			//Creates list of reservations associated with User ID
			String User_ID = request.getParameter("User_ID");
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement check_user_s = con.createStatement();
			ResultSet check_user_rs = check_user_s.executeQuery("select * from user u where u.User_ID = '" + User_ID + "';");
			if(!check_user_rs.next()){
				out.println("Username does not exist.");
			}
			else{%>
			<table border="1" align="center">
				<tr>
				<td>Passenger ID</td>
				<td>User ID</td>
				<td>First Name</td>
				<td>Last Name</td>
				<td>Ticket Number</td>
				</tr>
				<% 
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery("Select * from user u join customer using (User_ID) join ticket t using (Passenger_ID) where (u.User_Id  = \'" + User_ID + "\') and "
						+ " ((select current_date()) < (select min(Flight_date) from (select Flight_date from seat join flight using (Flight_number) where Ticket_number = t.Ticket_number union select Flight_date from waitlist join flight using (Flight_number) where Ticket_number = t.Ticket_number) t1) " 
						+ "or ((select current_date()) = ((select min(Flight_date) from (select Flight_date from seat join flight using (Flight_number) where Ticket_number = t.Ticket_number union select Flight_date from waitlist join flight using (Flight_number) where Ticket_number = t.Ticket_number) t2)) " + 
						" and ((select current_time()) <= ((select min(Take_off_time) from (select Flight_date, Take_off_time from seat join flight using (Flight_number) where Ticket_number = t.Ticket_number and Flight_date = (select current_date()) union select Flight_date, Take_off_time from waitlist join flight using (Flight_number) where Ticket_number = t.Ticket_number and Flight_date = (select current_date())) t3)))))");
				while(rs.next()){
					%>
					<tr>
					<td><%=rs.getInt("Passenger_ID")%></td>
					<td><%=rs.getString("User_ID")%></td>
					<td><%=rs.getString("First_name")%></td>
					<td><%=rs.getString("Last_name")%></td>
					<td><%=rs.getInt("Ticket_number")%></td>
					</tr>
					<%
				}
				%>
				<%--The Buttons that cancel the user's reservation --%>
				<section class="Edit User Reservation">
							<p>Edit User Reservation</p>
					<div class="container">
						<form class="Edit User Reservation" method="post" action="editReservation2.jsp">
							<input type="text" placeholder="User ID" name = "User_ID">
							<input type="text" placeholder="Ticket number" name = "Ticket_number">
							<button>Cancel Reservation</button>
						</form>
					</div>		<br>
				</section>
			<%}
			con.close();
/* 		}catch (Exception e) {
			out.println("attributes not accepted!");
		} */
%>
</body>
</html>