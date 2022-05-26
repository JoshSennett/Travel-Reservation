<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Edit a flight</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
			<h2> Flight edit </h2><br>
		<nav class="navar">
			<a href="cusrepPage.jsp" >Home</a>
			<a href="logOut.jsp">Logout</a>
	</nav>
	<%
try{
	String Aircraft_ID = request.getParameter("Aircraft_Id");
	String Flight_number = request.getParameter("Flight_number");
	String Airline_Id = request.getParameter("Airline_Id");
	String newFlight_number = request.getParameter("newFlight_number");
	if(newFlight_number == null || newFlight_number.trim().compareTo("") == 0){
		newFlight_number = Flight_number;
	}
	String First_class_price = request.getParameter("First_class_price");
	String Business_class_price = request.getParameter("Business_class_price");
	String Econ_class_price = request.getParameter("Econ_class_price");
	String Take_off_time = request.getParameter("Take_off_time");
	String Landing_time = request.getParameter("Landing_time");
	String Flight_date = request.getParameter("Flight_date");
	String Return_date = request.getParameter("Return_date");
	String Flight_type = request.getParameter("Flight_type");
	String newAirline_ID = request.getParameter("newAirline_ID");
	String Landing_airport_ID = request.getParameter("Landing_airport_ID");
	String Departing_airport_ID = request.getParameter("Departing_airport_ID");
	if(Flight_number != null & Airline_Id != null & Landing_airport_ID != null & Departing_airport_ID != null){
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	ResultSet rs = statement.executeQuery("Select * FROM flight WHERE Flight_number = \'" + Flight_number + "\' and Airline_ID = \'" + Airline_Id+"\'");
	if(rs.next()){
		ResultSet rs1 = statement.executeQuery("Select * FROM airline WHERE Airline_ID = \'" + newAirline_ID+"\'");
		if(rs1.next()){
			ResultSet rs2 = statement.executeQuery("Select * FROM flight WHERE Flight_number = \'" + newFlight_number+"\' and Airline_ID = '" + newAirline_ID + "' and Flight_number != \'" + Flight_number+"\' and Airline_ID != '" + Airline_Id + "'");
			if(rs2.next()){
				out.println("The desired Flight number is already taken");
			}else{
					ResultSet rs4 = statement.executeQuery("Select * From airport WHERE Airport_ID = \'" + Landing_airport_ID+"\'");
					if(rs4.next()){
						ResultSet rs5 = statement.executeQuery("Select * From airport WHERE Airport_ID = \'" + Departing_airport_ID+"\'");
						if(rs5.next()){
							ResultSet rs6 = statement.executeQuery("Select DAYOFWEEK(\'"+Flight_date+"\') as day;");
							int day = 8;
							if(rs6.next()){
								day = rs6.getInt("day");
							}
							int y = 0;
							ResultSet rs7 = statement.executeQuery("Select * from flies join flight on (flies.Aircraft_ID = flight.Aircraft_ID and flies.Airline_ID = flight.Airline_ID) and Flight_number = \'" + Flight_number+"\'");
							while(rs7.next()){
								int z = rs7.getInt("Day_of_the_week");
								if(z==day){
									y=1;
								}
							}
							if(y==1){
								PreparedStatement ps1 = con.prepareStatement("UPDATE flight SET Flight_number = (?), First_class_price = (?), Business_class_price = (?), Econ_class_price = (?), Take_off_time = (?), Landing_time = (?), Flight_date = (?), Landing_date = (?), Flight_type = (?), Aircraft_ID = (?), Airline_ID = (?), Landing_airport_ID = (?), Departing_airport_ID = (?) where Flight_number = (?) and Airline_ID = (?)");
								ps1.setString(1,newFlight_number);
								ps1.setString(2,First_class_price);
								ps1.setString(3,Business_class_price);
								ps1.setString(4,Econ_class_price);
								ps1.setString(5,Take_off_time);
								ps1.setString(6,Landing_time);
								ps1.setString(7,Flight_date);
								ps1.setString(8,Return_date);
								ps1.setString(9,Flight_type);
								ps1.setString(10,Aircraft_ID);
								ps1.setString(11,newAirline_ID);
								ps1.setString(12,Landing_airport_ID);
								ps1.setString(13,Departing_airport_ID);
								ps1.setString(14,Flight_number);
								ps1.setString(15,Airline_Id);
								ps1.execute();
								out.println("Flight editted!");
								ps1.close();	
							}else{
								out.println("The aircraft does not fly on given date! Flight not editted");
							}
						}else{
							out.println("The Departing airport does not exist");
						}
						rs5.close();
					}else{
						out.println("The Destination airport does not exist");
					} rs4.close();
			} rs2.close();
		}else{
			out.println("Desired Airline Does not exist");
		}rs1.close();
	}else{
		out.println("This flight does not exist with the given flight number and airline id");
	} rs.close();
	con.close();
	statement.close();
	}else{
		out.println("Invalid entry, attributes left null");
		out.println(Flight_number);
		out.println(Airline_Id);
		out.println(Landing_airport_ID);
		out.println(Departing_airport_ID);
	}
 	}	catch(Exception e){
		out.println("Invalid attributes entered: flight date + flight time cannot be after return date + return time");
	} 
	
	
	%>
</body>
</html>