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
	<div>
		<h3 style="font-weight: bold;">Please provide the following fields:</h3>
		<form method="post" action= "createAircraft2.jsp">
			<table class="login">
				<tr>
					<td><label for="Aircraft_Id">Aircraft_Id</label></td>
					<td><input id="Aircraft_Id" type="text" name="Aircraft_Id"required></td>
				</tr>
				<tr>
					<td><label for="First_class_seats">First_class_seats</label></td>
					<td><input id="First_class_seats" type="text" name="First_class_seats"required></td>
				</tr>
				<tr>
					<td><label for="Biz_class_seats">Biz_class_seats</label></td>
					<td><input id="Biz_class_seats" type="text" name ="Biz_class_seats"required></td>
				</tr>
				<tr>
					<td><label for="Econ_class_seats">Econ_class_seats</label></td>
					<td><input id="Econ_class_seats" type="text" name="Econ_class_seats"required></td>
				</tr>
				<tr>
					<td><label for="Airline_Id">Airline_Id</label></td>
					<td>
						<select name="Airline_Id" id=Airline_Id size=1>
						<%
						ApplicationDB db = new ApplicationDB();
						Connection con = db.getConnection();
						Statement stmt2 = con.createStatement();
						String str2 = "select * from airline;";
						ResultSet result = stmt2.executeQuery(str2);
							while(result.next()){
								out.print("<option value='" + result.getString("Airline_ID") + "' >" + result.getString("Airline_ID") + "</option>");
							}
						result.close();
						stmt2.close();
						con.close();
						%>				
						</select>
					</td>
					
				</tr>
				<tr>
					<td><label for="Sunday">Sunday</label></td>
					<td><input id="Sunday" type="checkbox" name="Sunday"></td>
				</tr>
				<tr>
					<td><label for="Monday">Monday</label></td>
					<td><input id="Monday" type="checkbox" name="Monday"></td>
				</tr>
				<tr>
					<td><label for="Tuesday">Tuesday</label></td>
					<td><input id="Tuesday" type="checkbox" name="Tuesday"></td>
				</tr>
				<tr>
					<td><label for="Wednesday">Wednesday</label></td>
					<td><input id="Wednesday" type="checkbox" name="Wednesday"></td>
				</tr>
				<tr>
					<td><label for="Thursday">Thursday</label></td>
					<td><input id="Thursday" type="checkbox" name="Thursday"></td>
				</tr>
				<tr>
					<td><label for="Friday">Friday</label></td>
					<td><input id="Friday" type="checkbox" name="Friday"></td>
				</tr>
				<tr>
					<td><label for="Saturday">Saturday</label></td>
					<td><input id="Saturday" type="checkbox" name="Saturday"></td>
				</tr>
			</table>
			<br>
			<input type="submit" name="submit" value="create aircraft">
		</form>
		
		<br><br>
		
	</div>
		
</body>
</html>