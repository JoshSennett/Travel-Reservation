<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Sign in</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
	<% 
	try{	//maybe here we need to check for sessions first?
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		String ID = request.getParameter("ID");
		String password = request.getParameter("pw");
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("Select * From user c Where BINARY " + 
				"c.user_ID = \'" + ID + "\' and BINARY c.user_password = \'" + password + "\'");
		if(!rs.next()){
			out.println("Invalid login credentials. Please try again.\n");
		}
		else{ 
			session = request.getSession();
			session.setAttribute("ID",ID);		
			
			int accessLevel = rs.getInt("accessLevel");
			if(accessLevel == 0){
					%>	
				<jsp:forward page = "mainPage.jsp"/>
			<% 
			}
			else if(accessLevel == 1){
				%>	
				<jsp:forward page = "cusrepPage.jsp"/>
			<% 
			}
			else{
				%>	
				<jsp:forward page = "adminPage.jsp"/>
			<% 
			}
		rs.close();
		statement.close();
		con.close();
		}
	}
	catch(Exception e){
		out.println(e);
	}
	%>
	<br>
	<form action="index.jsp">
		<input type="submit" value="Go back to Log in Page">
	</form>
</body>
</html>