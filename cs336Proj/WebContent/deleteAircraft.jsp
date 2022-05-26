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
			<h2> Aircraft Deletion </h2><br>
		<nav class="navar">
			<a href="cusrepPage.jsp" >Home</a>
			<a href="logOut.jsp">Logout</a>
	</nav>
	<%
		try{
		String Aircraft_Id = request.getParameter("Aircraft_Id");
		String Airline_Id = request.getParameter("Airline_Id");
		if(Aircraft_Id != null & Airline_Id != null){
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement statement = con.createStatement();
			ResultSet rs = statement.executeQuery("Select * FROM aircraft WHERE Aircraft_ID = \'" + Aircraft_Id +"\' and Airline_ID = \'"+Airline_Id+"\'");
			if(rs.next()){
				PreparedStatement ps1 = con.prepareStatement("DELETE FROM `aircraft` WHERE Aircraft_ID = (?) and Airline_ID = (?)");
				ps1.setString(1,Aircraft_Id);
				ps1.setString(2,Airline_Id);
				ps1.executeUpdate();
				ps1.close();
				out.println("Successfully removed Aircraft!");
			}
			else {
				out.println("Failed to delete aircraft, incorrect attributes!");	
			}
			}else{
			out.println("null attributes not accepted!");
			}
		}
		catch(Exception e){
			out.println("null attributes not accepted!");
		}
	%>
</body>
</html>