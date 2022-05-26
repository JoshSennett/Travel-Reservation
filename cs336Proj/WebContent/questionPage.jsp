<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Question Page</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
	<!-- check for existing session -->
	<% 
	session = request.getSession();
	String userID = (String)session.getAttribute("ID");
	if(userID == null){ %>
		<jsp:forward page = "index.jsp"/>
	<% } %>

	<h1> Online Travel Reservation System </h1>
	<h2> Question Forum</h2>
	<h3> Question Page</h3>
	<br>
	<form action="mainPage.jsp">
		<input type="submit" value="Go to Main Page">
	</form>
	<br>
	<form action="questionForumPage.jsp">
		<input type="text" name="page_num" value="1" style="display:none;">
		<input style="display:none;" name="search_value" type="text" value="">
		<input type="submit" value="Go to Question Forum">
	</form>
	<br><br>
	
	<%
		String qid = request.getParameter("qid").trim();
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		ResultSet rs = statement.executeQuery("select title, question, author_ID from question"
				+ " where qid = " + qid + ";");
		rs.next();
		String title = rs.getString("title");
		String question = rs.getString("question");
		String author = rs.getString("author_ID");
		%>
		<div class="biggerQuestionBox">
			<span class="biggerQuestionTitle">Question: <%=title%></span>
			<hr>
			<span class="content"> <%= question%> </span>
			<hr>
			<span> Asked by: <%= author%> </span>
			<hr>
			<span style="font-weight:bold;">Answer:</span>
			<br>
		<% 
		Statement statement2 = con.createStatement();
		ResultSet rs2 = statement2.executeQuery("select answer, author_ID from answer where qid = " 
			+ qid + ";");
		
		if(rs2.next()){
			String answer = rs2.getString("answer");
			String answerer = rs2.getString("author_ID");
			%>
			<span class="content"><%=answer%></span>
			<hr>
			<span> Answered by: <%=answerer%> </span>
			<hr>
			<%
		}
		else{ %>
			<br><br>
			<span>Not Answered</span>
		<%}
		rs.close();
		statement.close();
		rs2.close();
		statement2.close();
		con.close();
		%>
		</div>
	
		<div>
			<br><br>
			<form action="logOut.jsp">
				<input type="submit" value="log out">
			</form>
		</div>
</body>
</html>