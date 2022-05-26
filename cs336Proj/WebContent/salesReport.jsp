<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales report</title>
</head>
<body>

	<%
	try {

		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();

		String month = request.getParameter("month");
		String year = request.getParameter("year");
		if(year == null || year.trim().compareTo("") == 0){
			out.println("Year cannot be empty");
		}
		else{
			Statement statement = con.createStatement();
			String fareSumQuery = "select sum(Total_fare) as fareSum from ticket where (MONTH(Date_purchased) = \'" + month
			+ "\' and year(Date_purchased) = \'" + year + "\') ";

			ResultSet rs = statement.executeQuery(fareSumQuery);
			rs.next();
			double fareSum = rs.getDouble("fareSum");

			Statement statement2 = con.createStatement();
			String bookingFeeSumQuery = "select sum(Booking_fee) as bookingFeeSum from ticket where (MONTH(Date_purchased) = \'"
			+ month + "\' and year(Date_purchased) = \'" + year + "\')";
			rs = statement.executeQuery(bookingFeeSumQuery);
			rs.next();
			double bookingFeeSum = rs.getDouble("bookingFeeSum");

			double totalMoney = fareSum + bookingFeeSum;

			out.print("On " + month + "/" + year + ", total flight fares paid were " + fareSum + ",\n total booking fees were "
			+ bookingFeeSum + ",\n with a total revenue of " + totalMoney + ".");
		}

	} catch (Exception e) {
		out.print(e);
	}
	%>

</body>
</html>