<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Check Question Page</title>
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
		String title = request.getParameter("title").trim();
		String question = request.getParameter("question").trim();
		
		if(title.length() == 0 || question.length() == 0){
			out.println("Posting question failed: title or question cannot be empty.");
		}
		else{
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement s = con.createStatement();
			ResultSet rs = s.executeQuery("select max(qid) num from question;");
			int qid = 1;
			if(rs.next()){
				qid = rs.getInt("num")+1;
			}
			rs.close();
			s.close();
			
			PreparedStatement ps = con.prepareStatement("insert into question values(?,?,?,?,?)");
			ps.setString(1,title);
			ps.setString(2,question);
			ps.setInt(3,qid);
			ps.setString(4,userID);
			ps.setBoolean(5,false);
			ps.executeUpdate();
			ps.close();
			con.close();
			
			out.println("Successfully posted a question!");	
		}
	%>
	
	
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
	<br>
	<br>
	<div>
		<form action="logOut.jsp">
			<input type="submit" value="log out">
		</form>
	</div>
</body>
</html>