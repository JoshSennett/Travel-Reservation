<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Most active flights</title>
</head>
<body>

<%
try {
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();


	Statement statement = con.createStatement();
	String query = "select Flight_number ,count(*) count from seat join flight using (Flight_number) join"  
			+ " ticket using (Ticket_number) group by Flight_number order by count desc;";


	ResultSet rs = statement.executeQuery(query);
	
	out.print("<table>");

	//make a row
	out.print("<tr>");
	//make a column
	out.print("<td>");
	//print out column header
	out.print("Flight number");
	out.print("</td>");

	
	out.print("<td>");
	out.print("Number tickets sold");
	out.print("</td>");
	

	//parse out the results
	while (rs.next()) {
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		
		//print out User_ID
		String User_ID = rs.getString("Flight_number");
		out.print(User_ID);
		out.print("</td>");
		out.print("<td>");
	
		//prnt out count
		out.print(rs.getString("count"));
		out.print("</td>");
		out.print("<td>");
		
	}
	out.print("</table>");
	
	rs.close();
	statement.close();
	con.close();
}


catch (Exception e)
{
	out.print(e);
}

%>

<form action="adminPage.jsp">
	<input type="submit" value="Go back to Admin Page">
</form>
</body>
</html>