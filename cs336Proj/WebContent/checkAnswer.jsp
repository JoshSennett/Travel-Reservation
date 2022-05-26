<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Check Answer Page</title>
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

	<%
		String qid = request.getParameter("qid").trim();
		String author_ID = request.getParameter("author_ID").trim();
		String answer = request.getParameter("answer_textarea");
		if(answer.length() == 0){
			out.println("\nPosting answer failed: answer cannot be empty.");
		}
		else{
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			//checking for already existing answer for this question
			Statement statement1 = con.createStatement();
			ResultSet rs1 = statement1.executeQuery("select * from answer where qid = " + qid + ";");
			if(rs1.next()){//answer for this question already exists
				out.println("\nPosting answer failed: Someone has already answered this question.");
			}
			else{
				Statement statement2 = con.createStatement();
				ResultSet rs2 = statement2.executeQuery("select max(aid) num from answer");
				int aid = 1;
				if(rs2.next()){
					aid = rs2.getInt("num") + 1;
				}
				rs2.close();
				statement2.close();
					
				PreparedStatement prepared_statement = con.prepareStatement("insert into answer values(?,?,?,?);");
				prepared_statement.setString(1,answer);
				prepared_statement.setInt(2,aid);
				prepared_statement.setInt(3,Integer.parseInt(qid));
				prepared_statement.setString(4,author_ID);
				int result = prepared_statement.executeUpdate();
				
				prepared_statement.close();
				
				statement2 = con.createStatement();
				statement2.executeUpdate("update question set answered = TRUE where qid = " + qid + ";");
				statement2.close();
				out.println("\nSuccessfully posted answer.");
			}
			rs1.close();
			statement1.close();
			con.close();
		}
	
	%>
	
	
	<br>
	<form action="cusrepPage.jsp">
		<input type="submit" value="Go to Main Page">
	</form>
	<br>
	<form action="cusrep_questionForumPage.jsp">
		<input type="text" name="page_num" value="1" style="display:none;">
		<input style="display:none;" name="search_value" type="text" value="">
		<input style="display:none;" name="search_option" type="text" value="All Posts">
		<input type="submit" value="Go to Question Forum">
	</form>
	<br>
	<div>
		<form action="cusrep_questionPage.jsp">
			<input type="text" name="qid" value="<%=qid%>" style="display:none;">
			<input type="submit" value="Go back to Question">
		</form>
	</div>
	<br>
	<div>
		<form action="logOut.jsp">
			<input type="submit" value="log out">
		</form>
	</div>
</body>
</html>