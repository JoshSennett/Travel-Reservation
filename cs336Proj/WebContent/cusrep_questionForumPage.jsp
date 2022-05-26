<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Question Forum</title>
	<link rel="stylesheet" href="styles.css">
	<script src="script.js"></script>
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
	<h2> Question Forum: Customer Representative Version</h2>
	<h3>Place to view and answer questions posted by customers</h3>
	<form action="cusrepPage.jsp">
		<input type="submit" value="Go to Main Page">
	</form>
	<br><br>
	
	<%
		String search_value = request.getParameter("search_value").trim();	
		int page_num = Integer.parseInt(request.getParameter("page_num").trim());
		String search_option = request.getParameter("search_option").trim();
		String temp_search_option = "";
		if(search_option.compareTo("Unanswered Posts") == 0){
			temp_search_option = " and answered = 0 ";
		}
		else if(search_option.compareTo("Answered Posts") == 0){
			temp_search_option = " and answered = 1 ";	
		}
	%>
	<span>Search Option:&nbsp</span>
	<div class="dropdown">
		<button id="search_dropbutton" class="dropButton" onclick="showSearchOptions()"><%=search_option%></button>
		<div id="search_dropdown" class="dropdownContent">
			<span onclick="selectOption('All Posts')">All Posts</span>
			<span onclick="selectOption('Unanswered Posts')">Unanswered Posts</span>
			<span onclick="selectOption('Answered Posts')">Answered Posts</span>
		</div>
	</div>
	<span>&nbsp&nbsp&nbsp&nbsp</span>
	<form style="display:inline-block" action="cusrep_questionForumPage.jsp">
		<span>Search by keywords:&nbsp</span>
		<input type="text" name="search_value" value="<%=search_value%>">
		<input id="search_option" style="display:none;" name="search_option" type="text" value="<%=search_option%>">
		<input type="text" name="page_num" value="1" style="display:none;">
		<button class=".btn">Search</button>
	</form>
	<br><br>
	<%	
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement s = con.createStatement();
		
		String temp_search_value = "%" + search_value;
		if(search_value.length() != 0){
			temp_search_value += "%";
		}
		ResultSet rs = s.executeQuery("(select qid,title,question,author_ID from question where "
				+ "(title like \"" + temp_search_value + "\" or question like \"" + temp_search_value + "\") " + temp_search_option
				+ " union "
				+ "select qid, title,question,author_ID from question where qid in ("
				+ "select qid from answer where answer like \"" + temp_search_value + "\""
				+ ") " + temp_search_option + ")order by qid desc;");

		
		for(int i = 0; i < (page_num-1)*10; i++){
			rs.next();
		}
		
		
		int count = 0;
		while(rs.next() && count < 10){
			String title = rs.getString("title");
			String question = rs.getString("question");
			String author = rs.getString("author_ID");
			int qid = rs.getInt("qid");		
			Statement statement2 = con.createStatement();
			ResultSet rs2 = statement2.executeQuery("select answer, author_ID from answer where qid = " 
					+ qid + ";");
			%>
			<div class="questionBox">
				<span class="questionTitle"> Question: <%= title%> </span>
				<hr>
				<span class="content"> <%= question%> </span>
				<hr>
				<span> Asked by: <%= author%> </span>
				<hr>
				<span style="font-weight:bold;">Answer:</span>
				<br>
				<%
					if(rs2.next()){
						String answer = rs2.getString("answer");
						String answerer = rs2.getString("author_ID");
						%>
						<span class="content"><%=answer%> </span>
						<hr>
						<span> Answered by: <%=answerer%> </span>
						<hr>
						<%
					}
					else{%>
						<form style="display:inline-block" action="cusrep_questionPage.jsp">
							<input type="text" style="display:none;" name="qid" value= "<%=qid%>">
							<button class="answerQuestionBtn">Answer this Question</button>
						</form>
						<hr>
					<%}
				%>
				
				<form action="cusrep_questionPage.jsp">
					<input type="text" style="display:none;" name="qid" value= "<%=qid%>">
					<input type="submit" value="Go to Question">
				</form>
			</div>
			<br>
			<% 
			rs2.close();
			statement2.close();
			count++;
		}
		rs.close();
		s.close();
		
		//need to change: answer has to be taken into consideration
		s = con.createStatement();
		rs = s.executeQuery("select count(*) num from (select qid,title,question,author_ID from question where "
				+ "(title like \"" + temp_search_value + "\" or question like \"" + temp_search_value + "\") " + temp_search_option
				+ " union "
				+ "select qid, title,question,author_ID from question where qid in ("
				+ "select qid from answer where answer like \"" + temp_search_value + "\""
				+ ") " + temp_search_option + ") t;");
		rs.next();
		int num_of_questions = rs.getInt("num");
		
		rs.close();
		s.close();
		con.close();
		
		int lowest_pagenum = 10 * (int)(Math.ceil(page_num/10.0)-1) +1;
		int highest_pagenum =(int) Math.ceil(num_of_questions/10.0);
		if(highest_pagenum > lowest_pagenum + 9){
			highest_pagenum = lowest_pagenum + 9;
		}
	%>
	
	<div class="pageNavigator">
		<% if(page_num != 1){
			 if(page_num > 10){%>
				<form style="display:inline;" action="cusrep_questionForumPage.jsp">
					<input type="text" style="display:none;" name="page_num" value="<%=page_num - 10%>">
					<input style="display:none;" name="search_value" type="text" value="<%=search_value%>">
					<input style="display:none;" name="search_option" type="text" value="<%=search_option%>">
					<button class="pageNavigatorItem btn"> &lt&lt </button>
				</form>
			<% } else{%>
				<form style="display:inline;" action="cusrep_questionForumPage.jsp">
					<input type="text" style="display:none;" name="page_num" value="<%=1%>">
					<input style="display:none;" name="search_value" type="text" value="<%=search_value%>">
					<input style="display:none;" name="search_option" type="text" value="<%=search_option%>">
					<button class="pageNavigatorItem btn"> &lt&lt </button>
				</form>	
			<%} %>
			<form style="display:inline;" action="cusrep_questionForumPage.jsp">
				<input type="text" style="display:none;" name="page_num" value="<%=page_num-1%> ">
				<input style="display:none;" name="search_value" type="text" value="<%=search_value%>">
				<input style="display:none;" name="search_option" type="text" value="<%=search_option%>">
				<button class="pageNavigatorItem btn"> &lt </button>
			</form>
		<% } 
		
		for(int i = lowest_pagenum; i <= highest_pagenum; i++){
			if(i == page_num){ %>
				<form style="display:inline;" action="cusrep_questionForumPage.jsp">
					<input type="text" style="display:none;" name="page_num" value="<%=i%> ">
					<input style="display:none;" name="search_value" type="text" value="<%=search_value%>">
					<input style="display:none;" name="search_option" type="text" value="<%=search_option%>">
					<button class="pageNavigatorItem btn" style="background-color:#ededed;"> <%=i%> </button>
				</form>
			<%}else{ %>
				<form style="display:inline;" action="cusrep_questionForumPage.jsp">
					<input type="text" style="display:none;" name="page_num" value="<%=i%> ">
					<input style="display:none;" name="search_value" type="text" value="<%=search_value%>">
					<input style="display:none;" name="search_option" type="text" value="<%=search_option%>">
					<button class="pageNavigatorItem btn"> <%=i%> </button>
				</form>
			<%} %>
		<%}

		 if(page_num * 10 < num_of_questions){%>
			<form style="display:inline;" action="cusrep_questionForumPage.jsp">
				<input type="text" style="display:none;" name="page_num" value="<%=page_num+1%> ">
				<input style="display:none;" name="search_value" type="text" value="<%=search_value%>">
				<input style="display:none;" name="search_option" type="text" value="<%=search_option%>">
				<button class="pageNavigatorItem btn"> &gt </button>
			</form>
			
			<% if((page_num-1) * 10 + 101 <= num_of_questions) {%>
				<form style="display:inline;" action="cusrep_questionForumPage.jsp">
					<input type="text" style="display:none;" name="page_num" value="<%=page_num+10%>">
					<input style="display:none;" name="search_value" type="text" value="<%=search_value%>">
					<input style="display:none;" name="search_option" type="text" value="<%=search_option%>">
					<button class="pageNavigatorItem btn"> &gt&gt </button>
				</form>
			<% } else{%>
				<form style="display:inline;" action="cusrep_questionForumPage.jsp">
					<input type="text" style="display:none;" name="page_num" value="<%=(int)Math.ceil(num_of_questions/10.0)%>">
					<input style="display:none;" name="search_value" type="text" value="<%=search_value%>">
					<input style="display:none;" name="search_option" type="text" value="<%=search_option%>">
					<button class="pageNavigatorItem btn"> &gt&gt </button>
				</form>
			<%} %>
		<% } %>
	</div>
	
	
	<div>
		<br><br>
		<form action="logOut.jsp">
			<input type="submit" value="log out">
		</form>
	</div>
</body>
</html>