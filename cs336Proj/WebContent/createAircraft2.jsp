<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Create an Aircraft</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
			<h2> Aircraft Creation </h2><br>
		<nav class="navar">
			<a href="cusrepPage.jsp" >Home</a>
			<a href="logOut.jsp">Logout</a>
	</nav>
	<%
		try{
		String Aircraft_Id = request.getParameter("Aircraft_Id");
		String First_class_seats = request.getParameter("First_class_seats");
		String Biz_class_seats = request.getParameter("Biz_class_seats");
		String Econ_class_seats = request.getParameter("Econ_class_seats");
		String Airline_Id = request.getParameter("Airline_Id");
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
		ResultSet rs1 = statement.executeQuery("Select * FROM airline WHERE "+"Airline_Id = \'" + Airline_Id +"\'");
		if(rs1.next()){
		ResultSet rs = statement.executeQuery("Select * FROM aircraft WHERE Aircraft_Id = \'" + Aircraft_Id + "\' and Airline_Id = \'" + Airline_Id+"\'");
		if(rs.next()){
			out.println("Aircraft with that ID already exists, try again");
		}
		else{
				PreparedStatement ps1 = con.prepareStatement("insert into `aircraft` values(?,?,?,?,?)");
				ps1.setString(1,Aircraft_Id);
				ps1.setString(2,First_class_seats);
				ps1.setString(3,Biz_class_seats);
				ps1.setString(4,Econ_class_seats);
				ps1.setString(5,Airline_Id);
				ps1.executeUpdate();
				ps1.close();
				if(Sunday != null){
					PreparedStatement ps2 = con.prepareStatement("insert into flies values (?,?,?)");
					ps2.setInt(1,1);
					ps2.setString(2,Aircraft_Id);
					ps2.setString(3,Airline_Id);
					ps2.executeUpdate();
					ps2.close();
				}
				if(Monday != null){
					PreparedStatement ps2 = con.prepareStatement("insert into flies values (?,?,?)");
					ps2.setInt(1,2);
					ps2.setString(2,Aircraft_Id);
					ps2.setString(3,Airline_Id);
					ps2.executeUpdate();
					ps2.close();
				}
				if(Tuesday != null){
					PreparedStatement ps2 = con.prepareStatement("insert into flies values (?,?,?)");
					ps2.setInt(1,3);
					ps2.setString(2,Aircraft_Id);
					ps2.setString(3,Airline_Id);
					ps2.executeUpdate();
					ps2.close();
				}
				if(Wednesday != null){
					PreparedStatement ps2 = con.prepareStatement("insert into flies values (?,?,?)");
					ps2.setInt(1,4);
					ps2.setString(2,Aircraft_Id);
					ps2.setString(3,Airline_Id);
					ps2.executeUpdate();
					ps2.close();
				}
				if(Thursday != null){
					PreparedStatement ps2 = con.prepareStatement("insert into flies values (?,?,?)");
					ps2.setInt(1,5);
					ps2.setString(2,Aircraft_Id);
					ps2.setString(3,Airline_Id);
					ps2.executeUpdate();
					ps2.close();
				}
				if(Friday != null){
					PreparedStatement ps2 = con.prepareStatement("insert into flies values (?,?,?)");
					ps2.setInt(1,6);
					ps2.setString(2,Aircraft_Id);
					ps2.setString(3,Airline_Id);
					ps2.executeUpdate();
					ps2.close();
				}
				if(Saturday != null){
					PreparedStatement ps2 = con.prepareStatement("insert into flies values (?,?,?)");
					ps2.setInt(1,7);
					ps2.setString(2,Aircraft_Id);
					ps2.setString(3,Airline_Id);
					ps2.executeUpdate();
					ps2.close();
				}
				out.println("Aircraft Successfully Created!");
		}
		rs.close();
		statement.close();
		con.close();
		}
		else{
			out.println("Airline does not exist");
		}
		rs1.close();
		}	catch(Exception e){
			out.println("Invalid attributes entered!");
		}
	%>

</body>
</html>