<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Delete a Flight</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
			<h2> Flight Deletion </h2><br>
		<nav class="navar">
			<a href="cusrepPage.jsp" >Home</a>
			<a href="logOut.jsp">Logout</a>
	</nav>
	<% 
		try{
		String Flight_number = request.getParameter("Flight_number");
		String Airline_Id = request.getParameter("Airline_Id");
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("Select * FROM flight WHERE Flight_number = \'"+Flight_number+"\' and Airline_ID = \'"+Airline_Id+"\'");
		if(rs.next()){
			PreparedStatement ps1 = con.prepareStatement("DELETE FROM `flight` WHERE Flight_number = (?) and Airline_ID = (?)");
			ps1.setString(1,Flight_number);
			ps1.setString(2,Airline_Id);
			ps1.executeUpdate();
			ps1.close();
			out.println("Successfully removed Flight list");
		}
		else{
			out.println("Failed to delete flight");
		}
		}		catch(Exception e){
			out.println("null attributes not accepted!");
		}
		
	%>
</body>
</html>