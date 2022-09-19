<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="assets/dist/css/bootstrap.css">
<link rel="stylesheet" href="assets/dist/css/nav.css">
<link rel="stylesheet" href="assets/dist/css/flightInfo.css">
<script src="assets/dist/js/flightInfo.js" defer></script>
<title>Airline Reservation System</title>
</head>
<body>
	
	<%
		Connection conn = null;
 		Statement stmt1 = null;
 		Statement stmt2 = null;
 		Class.forName("com.mysql.jdbc.Driver");
 		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_reservation_system", "root", "");
 		String query1 = "select distinct fromCity from flight where flightDate > now()";
 		String query2 = "select distinct toCity from flight where flightDate > now()";
 		
 		stmt1 = conn.createStatement();
 		ResultSet rs1 = stmt1.executeQuery(query1);
 		
 		stmt2 = conn.createStatement();
 		ResultSet rs2 = stmt2.executeQuery(query2);
 		
 		
 		String select_str1 = "<select name='from' class=\"form-select form-select-sm\">";
 		String select_str2 = "<select name='destincation' class=\"form-select form-select-sm\">";
 		
 		while(rs1.next()){
 			select_str1 += String.format("<option>%s</option>", rs1.getString("fromCity")); 			
 		}
 		
 		while(rs2.next()){
 			select_str2 += String.format("<option>%s</option>", rs2.getString("toCity"));
 		}
 		
 		select_str1 += "</select>";
 		select_str2 += "</select>";
	%>

	<nav>
      <ul>
        <li><a href="index.jsp">Home</a></li>
        <li><a href="flightInfo.jsp" class="active">Flight</a></li>
        <li><a href="login.jsp">Login</a></li>
      </ul>
    </nav>
    <main>
    	<div class="error-message"></div>
		<div class="search">
			<form method="post" action="#">
				<span>From City</span>
				<%= select_str1 %>
				<span>To City</span>
				<%= select_str2 %>
				<span>Date</span>
	    		<input type="date" name="date" />
	    		<button type="submit" class="btn btn-primary btn-sm" id="search-btn">Search</button>
			</form>
    	</div>
    	<div class="container">
    		<table class="table table-striped" id="flight-table">
			  <thead>
			    <tr>
			      <th scope="col">Flight NO</th>
			      <th scope="col">Flight Name</th>
			      <th scope="col">From City</th>
			      <th scope="col">To City</th>
			      <th scope="col">Date</th>
			      <th scope="col">Time</th>
			      <th scope="col">Airport Name</th>
			      <th scope="col">Ticket Price</th>
			      <th scope="col">Description</th>
			      <th scope="col">Action</th>
			    </tr>
			  </thead>
			  <tbody>
			  <% 			  	
			 	String sql = "select * from flight where flightDate > now()";
			 	Statement stmt3 = conn.createStatement();
			 	ResultSet rs3 = stmt3.executeQuery(sql);
			 	
			 	while(rs3.next()){
			 		String output = "";
			 		String id = rs3.getString("id");
			 		String flightName = rs3.getString("flightName");
			 		String fromCity = rs3.getString("fromCity");
			 		String toCity = rs3.getString("toCity");
			 		String flightDate = rs3.getString("flightDate");
			 		String[] parts = flightDate.split(" ");
			 		String airportName = rs3.getString("airportName");
			 		String price = rs3.getString("price");
			 		String description = rs3.getString("description");			 		
			 	%>
			 		<tr>
			 			<td><%= id %></td>
			 			<td><%= flightName %></td>
			 			<td><%= fromCity %></td>
			 			<td><%= toCity %></td>
			 			<td><%= parts[0] %></td>
			 			<td><%= parts[1] %></td>
			 			<td><%= airportName %></td>
			 			<td><%= price %></td>
			 			<td><%= description %></td>
			 			<td>
			 				<button type="button" class="btn btn-info btn-sm order-btn" id='<%= "flight-id-" + id %>'>
			 					Book
			 				</button>
			 			</td>
			 		</tr>
			 	<% 
			 	}
			  	
			  %>
			  </tbody>
			</table>
    	</div>
    </main>
</body>
</html>