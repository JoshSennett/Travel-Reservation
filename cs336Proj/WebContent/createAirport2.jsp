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
			<h2> Airport Creation  </h2><br>
		<nav class="navar">
			<a href="cusrepPage.jsp" >Home</a>
			<a href="logOut.jsp">Logout</a>
	</nav>
	<%
	try{
		String Airport_Id = request.getParameter("Airport_Id");
		String Airport_Name = request.getParameter("Airport_Name");
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("Select * FROM airport WHERE " + "Airport_ID = \'" + Airport_Id+"\'");
		if(rs.next()){
			out.println("Airport already exists");
		}
		else{
			PreparedStatement ps1 = con.prepareStatement("insert into airport values(?,?)");
			ps1.setString(1,Airport_Id);
			ps1.setString(2,Airport_Name);
			ps1.executeUpdate();
			ps1.close();
			out.println("Airport Successfully Created!");
		}
	}	catch(Exception e){
		out.println("Incorrect aiport ID lenght. It must be between 1 and 3 characters");
	}
	
	%>
</body>
</html>