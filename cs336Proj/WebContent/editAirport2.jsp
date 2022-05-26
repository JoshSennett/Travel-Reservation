<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Edit an Airport</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
			<h2> Airport Edit </h2><br>
		<nav class="navar">
			<a href="cusrepPage.jsp" >Home</a>
			<a href="logOut.jsp">Logout</a>
	</nav>
	<%
	try{
		String Airport_Id = request.getParameter("Airport_Id");
		String newAirport_Id = request.getParameter("newAirport_Id");
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("Select * FROM airport WHERE Airport_ID = \'"+Airport_Id +"'");
		if(rs.next()){
			ResultSet rs1 = statement.executeQuery("Select * FROM airport WHERE Airport_ID = \'"+newAirport_Id + "'");
			if(rs1.next()){
				out.println("the requested airport id already exists");
			}else{
				PreparedStatement ps1 = con.prepareStatement("UPDATE airport SET Airport_ID = (?) WHERE Airport_ID = (?)");
				ps1.setString(1,newAirport_Id);
				ps1.setString(2,Airport_Id);
				ps1.executeUpdate();
				ps1.close();
				out.println("Airport successfully updated!");
			}
		}
		else{
			out.println("the airport id does not exist");
		}
		
	}
	catch(Exception e){
		out.println("Airport failed to update!");
	}
	%>
</body>
</html>