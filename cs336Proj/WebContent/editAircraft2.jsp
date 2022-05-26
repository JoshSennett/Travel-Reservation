<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Edit an Aircraft</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
			<h2> Aircraft Edit </h2><br>
		<nav class="navar">
			<a href="cusrepPage.jsp" >Home</a>
			<a href="logOut.jsp">Logout</a>
	</nav>
	<!-- Checks to see if given ids exist, then checks to see if new ids are not valid to use. Then assigns new values -->
	<%
	try{
			String Aircraft_Id = request.getParameter("Aircraft_Id");
			String Airline_Id = request.getParameter("Airline_Id");
			String newAircraft_Id = request.getParameter("newAircraft_Id");
			if(newAircraft_Id == null || newAircraft_Id.compareTo("") == 0){
				newAircraft_Id = Aircraft_Id;
			}
				
				
			String newAirline_Id = request.getParameter("newAirline_Id");
			String First_class_seats = request.getParameter("First_class_seats");
			String Biz_class_seats = request.getParameter("Biz_class_seats");
			String Econ_class_seats = request.getParameter("Econ_class_seats");
			String Sunday = request.getParameter("Sunday");
			String Monday = request.getParameter("Monday");
			String Tuesday = request.getParameter("Tuesday");
			String Wednesday = request.getParameter("Wednesday");
			String Thursday = request.getParameter("Thursday");
			String Friday = request.getParameter("Friday");
			String Saturday = request.getParameter("Saturday");
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement statement = con.createStatement();
			int flights = 0;
			int count = 0;
			ResultSet rs = statement.executeQuery("Select * FROM aircraft WHERE Aircraft_Id = \'" + Aircraft_Id + "\' and Airline_Id = \'" + Airline_Id+"\'");
			if(rs.next()){
				ResultSet rs1 = statement.executeQuery("SELECT * FROM airline WHERE Airline_ID = \'"+ newAirline_Id+"\'");
				if(rs1.next()){
					ResultSet rs2 = statement.executeQuery("SELECT * FROM aircraft WHERE Aircraft_ID = \'"+newAircraft_Id+"\' and Airline_ID = '" + newAirline_Id + "' and Aircraft_ID <> "+Aircraft_Id+" and Airline_ID <> '" + Airline_Id + "'");
					if(rs2.next()){
						out.println("That Aircraft Id is already in use!");
					}else{
								ResultSet rs100 = statement.executeQuery("Select *  from flight where Airline_ID = '" + Airline_Id + "' and Aircraft_ID = " + Aircraft_Id);
								if(Airline_Id.compareTo(newAirline_Id) != 0 && rs100.next()){
									out.println("The requested aircraft is currently in use. Can't change the airline of an aircraft when an aircraft is being used for an airline.");
								}
								else{
									ResultSet rs8 = statement.executeQuery("Select count(*) as TOTAL from flight where Aircraft_ID = \'"+Aircraft_Id+"\' and Airline_ID = '" + Airline_Id + "'");
									if(rs8.next()){
									flights = rs8.getInt("TOTAL");
									ResultSet rs5 = statement.executeQuery("Select * from flight natural join aircraft natural join flies where Aircraft_ID = "+Aircraft_Id+" and Airline_ID = '" + Airline_Id + "' and DAYOFWEEK(Flight_date) = Day_of_the_week");
									while(rs5.next()){
										int z = rs5.getInt("Day_of_the_week");
										if(Sunday != null){
											if(z == 1){
												count +=1;
											}
										}
										if(Monday != null){
											if(z == 2){
												count +=1;
											}
										}
										if(Tuesday != null){
											if(z == 3){
												count +=1;
											}
										}
										if(Wednesday != null){
											if(z == 4){
												count +=1;
											}
										}
										if(Thursday != null){
											if(z == 5){
												count +=1;
											}
										}
										if(Friday != null){
											if(z == 6){
												count +=1;
											}
										}
										if(Saturday != null){
											if(z == 7){
												count +=1;
											}
										}
										}
										}
									System.out.println(flights+"");
									System.out.println(count+"");
									if(flights==count){
										ResultSet rs3 = statement.executeQuery("SELECT * FROM flies WHERE Aircraft_ID = \'"+Aircraft_Id+"\' and Airline_ID = '" + Airline_Id + "'");
										while(rs3.next()){
											PreparedStatement ps2 = con.prepareStatement("DELETE FROM `flies` WHERE Aircraft_ID = (?) and Airline_ID = (?) ");
											ps2.setString(1,Aircraft_Id);
											ps2.setString(2,Airline_Id);
											ps2.execute();
											ps2.close();
										}
										
										PreparedStatement ps1 = con.prepareStatement("UPDATE aircraft SET Aircraft_ID = (?), First_class_seats = (?), Biz_class_seats = (?), Econ_class_seats = (?), Airline_ID = (?) where Aircraft_ID = (?)");
										ps1.setString(1,newAircraft_Id);
										ps1.setString(2,First_class_seats);
										ps1.setString(3,Biz_class_seats);
										ps1.setString(4,Econ_class_seats);
										ps1.setString(5,newAirline_Id);
										ps1.setString(6,Aircraft_Id);
										ps1.execute();
										out.println("Aircraft Updated Successfully!");
										if(Sunday != null){
											PreparedStatement ps2 = con.prepareStatement("insert into flies values (?,?,?)");
											ps2.setInt(1,1);
											ps2.setString(2,newAircraft_Id);
											ps2.setString(3,newAirline_Id);
											ps2.executeUpdate();
											ps2.close();
										}
										if(Monday != null){
											PreparedStatement ps2 = con.prepareStatement("insert into flies values (?,?,?)");
											ps2.setInt(1,2);
											ps2.setString(2,newAircraft_Id);
											ps2.setString(3,newAirline_Id);
											ps2.executeUpdate();
											ps2.close();
										}
										if(Tuesday != null){
											PreparedStatement ps2 = con.prepareStatement("insert into flies values (?,?,?)");
											ps2.setInt(1,3);
											ps2.setString(2,newAircraft_Id);
											ps2.setString(3,newAirline_Id);
											ps2.executeUpdate();
											ps2.close();
										}
										if(Wednesday != null){
											PreparedStatement ps2 = con.prepareStatement("insert into flies values (?,?,?)");
											ps2.setInt(1,4);
											ps2.setString(2,newAircraft_Id);
											ps2.setString(3,newAirline_Id);
											ps2.executeUpdate();
											ps2.close();
										}
										if(Thursday != null){
											PreparedStatement ps2 = con.prepareStatement("insert into flies values (?,?,?)");
											ps2.setInt(1,5);
											ps2.setString(2,newAircraft_Id);
											ps2.setString(3,newAirline_Id);
											ps2.executeUpdate();
											ps2.close();
										}
										if(Friday != null){
											PreparedStatement ps2 = con.prepareStatement("insert into flies values (?,?,?)");
											ps2.setInt(1,6);
											ps2.setString(2,newAircraft_Id);
											ps2.setString(3,newAirline_Id);
											ps2.executeUpdate();
											ps2.close();
										}
										if(Saturday != null){
											PreparedStatement ps2 = con.prepareStatement("insert into flies values (?,?,?)");
											ps2.setInt(1,7);
											ps2.setString(2,newAircraft_Id);
											ps2.setString(3,newAirline_Id);
											ps2.executeUpdate();
											ps2.close();
										}
										ps1.close();
										}
										else{
										out.println("Aircraft could not be updated because of existing flight flying on dates that are invalid in editted aircraft");
										}
								}
					}
				}
				else{
					out.println("The requested Airline does not exist");
				}
				
			}else{
				out.println("No such aircraft with given aircraft id and airline id exists");
			}
 		}catch(Exception e){
			out.println("oops");
		}
			
	%>
</body>
</html>