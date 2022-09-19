<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flight Report</title>
<link rel="stylesheet" href="../assets/dist/css/bootstrap.css">
<link rel="stylesheet" href="../assets/dist/css/nav.css">
<link rel="stylesheet" href="../assets/dist/css/flightInfo.css">
<script src="../assets/dist/js/flightReport.js" defer></script>
<style>
	.search span{
		margin-right: 20px;
	}
	
	input{
		width: 400px !important;
		margin-right: 30px !important;
		padding: 6px 10px;
	}
	
	input:nth-child(2){
		margin-right: 100px !important;
	}
	
	
	.btn-group{
		margin-left: 86% !important;
	}
	
	input[type="checkbox"]{
		width: initial !important;
		margin-right: 0 !important;
		margin-left: 0 !important;
	}
	
	nav{
		margin-bottom: 25px;
	}
	
	nav ul{
		margin-right: 30%;
	}		
</style>
</head>
<body>
		<nav>
	      <ul>
	        <li><a href="index.jsp">Home</a></li>
	        <li><a href="addFlight.jsp">Add Flight</a></li>
	        <li><a href="flightReport.jsp" class="active">Flight Report</a></li>
	        <li><a href="ticketReport.jsp">Ticket Report</a></li>
	      </ul>
    	</nav>
    	<main>
	    	<div class="error-message"></div>
			<div class="search">
				<form method="post" action="">
		    		<span>Flight Name:</span>
		    		<input type="text" name="flightName" placeholder="Search By Name" autocomplete="off"/>
		    		<span>Flight No:</span>
		    		<input type="text" name="id" placeholder="Search By Flight No" autocomplete="off"/>
		    		<button type="submit" class="btn btn-primary btn-sm" id="search-btn">Search</button>
				</form>
	    	</div>
	    	<div class="container">
	    		<table class="table table-striped" id="flight-table">
				  <thead>
				    <tr>
				      <th>#</th>
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
				  	Connection conn = null;
				 	Statement stmt = null;
				 	Class.forName("com.mysql.jdbc.Driver");
				 	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_reservation_system", "root", "");
				 	String sql = "select * from flight";
				 	stmt = conn.createStatement();
				 	ResultSet rs = stmt.executeQuery(sql);
				 	
				 	while(rs.next()){
				 		String output = "";
				 		String id = rs.getString("id");
				 		String flightName = rs.getString("flightName");
				 		String fromCity = rs.getString("fromCity");
				 		String toCity = rs.getString("toCity");
				 		String flightDate = rs.getString("flightDate");
				 		String[] parts = flightDate.split(" ");
				 		String airportName = rs.getString("airportName");
				 		String price = rs.getString("price");
				 		String description = rs.getString("description");
				 		
				 	%>
				 		<tr id="row-<%= id %>">
				 			<td>
				 				<div class="form-check">
						 			<input class="form-check-input" type="checkbox" name="row-check" value="cb-<%= id %>">
								</div>
				 			</td>
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
				 				<button type="button" class="btn btn-info btn-sm edit-btn" id='<%= "flight-id-" + id %>'>
				 					Edit
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
	    <div class="btn-group">
	    	<a class="btn btn-outline-primary" href="addFlight.jsp">New</a>
	    	<button class="btn btn-outline-primary" id="deleteBtn">Delete</button>
	    </div>
</body>
</html>