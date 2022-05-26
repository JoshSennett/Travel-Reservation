<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Create a Flight</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
			<h2> Flight Creation </h2><br>
		<nav class="navar">
			<a href="cusrepPage.jsp" >Home</a>
			<a href="logOut.jsp">Logout</a>
	</nav>
	<%
		try{
		String Flight_number = request.getParameter("Flight_number");
		String First_class_price = request.getParameter("First_class_price");
		String Biz_class_price = request.getParameter("Biz_class_price");
		String Econ_class_price = request.getParameter("Econ_class_price");
		String Take_off_time = request.getParameter("Take_off_time");
		String Landing_time = request.getParameter("Landing_time");
		String Flight_date = request.getParameter("Flight_date");
		String Return_date = request.getParameter("Return_date");
		String Flight_type = request.getParameter("Flight_type");
		String Airline_Id = request.getParameter("Airline_Id");
		String Landing_airport_ID = request.getParameter("Landing_airport_ID");
		String Departing_airport_ID = request.getParameter("Departing_airport_ID");
		String Aircraft_Id = request.getParameter("Aircraft_Id");
		if(Landing_airport_ID.compareTo(Departing_airport_ID) != 0){
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("Select * FROM flight WHERE Flight_number = \'" + Flight_number + "\' and Airline_ID = \'" + Airline_Id+"\'");
		if(rs.next()){
			out.println("Flight already exists");
		}else{
			ResultSet rs1 = statement.executeQuery("Select * FROM airline WHERE Airline_ID = \'" + Airline_Id+"\'");
			if(rs1.next()){
				ResultSet rs2 = statement.executeQuery("Select * FROM aircraft WHERE Aircraft_ID = \'" + Aircraft_Id+"\' and Airline_ID = '" + Airline_Id + "'");
				if(rs2.next()){
					ResultSet rs3 = statement.executeQuery("Select * From airport WHERE Airport_ID = \'" + Landing_airport_ID+"\'");
					if(rs3.next()){
						ResultSet rs4 = statement.executeQuery("Select * From airport WHERE Airport_ID = \'" + Departing_airport_ID+"\'");
						if(rs4.next()){
							ResultSet rs5 = statement.executeQuery("Select DAYOFWEEK(\'"+Flight_date+"\') as day;");
							int day = 8;
							if(rs5.next()){
								day = rs5.getInt("day");
							}
							int y = 0;
							ResultSet rs6 = statement.executeQuery("Select * from flies where Aircraft_ID = \'" + Aircraft_Id + "\' and Airline_ID = '" + Airline_Id + "'");
							while(rs6.next()){
								int z = rs6.getInt("Day_of_the_week");
								if(z==day){
									y=1;
								}
							}
							rs6.close();
							if(y==1){
								PreparedStatement ps1 = con.prepareStatement("insert into `flight` values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
								ps1.setString(1,Flight_number);
								ps1.setString(2,First_class_price);
								ps1.setString(3,Biz_class_price);
								ps1.setString(4,Econ_class_price);
								ps1.setString(5,Take_off_time);
								ps1.setString(6,Landing_time);
								ps1.setString(7,Flight_date);
								ps1.setString(8,Flight_type);
								ps1.setString(9,Airline_Id);
								ps1.setString(10,Landing_airport_ID);
								ps1.setString(11,Departing_airport_ID);
								ps1.setString(12,Aircraft_Id);
								ps1.setString(13,Return_date);
								ps1.executeUpdate();
								ps1.close();
								out.println("Flight Successfully Created!");
								ResultSet seats = statement.executeQuery("Select * from aircraft where Aircraft_ID = \'"+Aircraft_Id+"\'");
								if(seats.next()){
									int first = seats.getInt("First_class_seats");
									int biz = seats.getInt("Biz_class_seats");
									int econ = seats.getInt("Econ_class_seats");
									ResultSet seatcount = statement.executeQuery("SELECT count(*) as TOTAL from seat");
									if(seatcount.next()){
									int seatnum = 0;
									for(int x = seatnum;x< seatnum+econ;x++){
										PreparedStatement ps2 = con.prepareStatement("INSERT INTO seat values (?,?,?,?,?,?,?)");
										ps2.setInt(1,x);
										ps2.setString(2,Flight_number);
										ps2.setString(3,Airline_Id);
										ps2.setString(4,"ECO");
										ps2.setString(5,"5.00");
										ps2.setInt(6,1);
										ps2.setString(7,null);
										ps2.executeUpdate();
										ps2.close();
									}
									seatnum = seatnum+econ;
									for(int x = seatnum;x< seatnum+biz;x++){
										PreparedStatement ps2 = con.prepareStatement("INSERT INTO seat values (?,?,?,?,?,?,?)");
										ps2.setInt(1,x);
										ps2.setString(2,Flight_number);
										ps2.setString(3,Airline_Id);
										ps2.setString(4,"BUS");
										ps2.setString(5,"0");
										ps2.setInt(6,1);
										ps2.setString(7,null);
										ps2.executeUpdate();
										ps2.close();
									}
									seatnum = seatnum+biz;
									for(int x = seatnum;x< seatnum+first;x++){
										PreparedStatement ps2 = con.prepareStatement("INSERT INTO seat values (?,?,?,?,?,?,?)");
										ps2.setInt(1,x);
										ps2.setString(2,Flight_number);
										ps2.setString(3,Airline_Id);
										ps2.setString(4,"FIR");
										ps2.setString(5,"0");
										ps2.setInt(6,1);
										ps2.setString(7,null);
										ps2.executeUpdate();
										ps2.close();
									}
									seatnum = seatnum+first;
									}
							}
							}else{
								out.println("The aircraft does not fly on given date! Flight not Created");
							}
							rs5.close();
						}
						else{
							out.println("Departing airport does not exist!");
						}
						rs4.close();
					}
					else
					{
						out.println("Landing airport does not exist!");
					}
					rs3.close();
				}
				else{
					out.println("Aircraft does not exist!");	
				}
				rs2.close();
			}
			else{
				out.println("Airline does not exist!");
			}
			rs1.close();
		}
		}
		else{
			out.println("Invalid entry, The flight can not leave and arrive at same airport!");
			out.println("Arriving airport: \'"+Landing_airport_ID+"\'");
			out.println("Departing airport: \'"+Departing_airport_ID+"\'");
		}
		}	catch(Exception e){
			out.println("Invalid attributes entered!");
		}
	
	%>
</body>
</html>