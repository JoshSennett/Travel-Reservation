<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5.0 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Book Type</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body style="margin-left:auto;margin-right:auto;text-align:center">
	<!-- check for existing session -->
	<% 
	session = request.getSession();
	String userID = (String)session.getAttribute("editID");
	String cusrepID = (String)session.getAttribute("ID");
	
	if(cusrepID == null){ %>
		<jsp:forward page = "index.jsp"/>
	<% } 
	
	if(userID == null){ 
		response.sendRedirect("../cusrepPage.jsp");
	} 
	
	String maxPrice = (String)request.getParameter("maxPrice");
	if(maxPrice == null || maxPrice.isEmpty()){
		session.setAttribute("maxPrice", null);
	}else{
		session.setAttribute("maxPrice",maxPrice);
	}
	
	String sort = (String)request.getParameter("sort");
	session.setAttribute("sort",sort);	
	
	String flightType = (String)request.getParameter("flightType");
	session.setAttribute("flightType",flightType);	
	String flexibility = (String)request.getParameter("flexibility");
	session.setAttribute("flexibility",flexibility);	
	String airline;
	if(((String)request.getParameter("airline")).toUpperCase() != null){
		airline = ((String)request.getParameter("airline")).toUpperCase();
	}else{
		airline = "--";
	}
		
	String departing;
	if(((String)request.getParameter("departing")).toUpperCase() != null){
		departing = ((String)request.getParameter("departing")).toUpperCase();
	}else{
		departing = "---";
	}
	String destination;
	if(((String)request.getParameter("destination")).toUpperCase() != null){
		destination = ((String)request.getParameter("destination")).toUpperCase();
	}else{
		destination = "---";
	}
	if(departing.length() != 3 || destination.length() != 3){
		destination = "---";
		departing = "---";
	}
	if(airline.length() != 2){
		 airline = "--";
	}
	session.setAttribute("destination",destination);	
	session.setAttribute("departing",departing);
	session.setAttribute("airline",airline);
	String cabin = (String)request.getParameter("cabin");
	session.setAttribute("cabin",cabin);	
	String stops = (String)request.getParameter("stops");
	session.setAttribute("stops",stops);	
	
	if(flightType != null && flightType.equals("roundTrip")){
	%>
		<jsp:forward page = "roundTrip.jsp"/>
	<%	
	}else if(flightType != null && flightType.equals("oneWay")){
	%>
		<jsp:forward page = "oneWay.jsp"/>
	<%	
	}
	%>
	<br>
	<form action="../index.jsp" style="margin-left:auto;margin-right:auto;text-align:center">
		<input type="submit" value="Go back to Log in Page">
	</form>
</body>
</html>