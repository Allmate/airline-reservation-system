<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Flight</title>
<link rel="stylesheet" href="../assets/dist/css/bootstrap.css">
<link rel="stylesheet" href="../assets/dist/css/nav.css">
<script src="../assets/dist/js/flightEdit.js" defer></script>
</head>
<style>
*{
margin: 0;
padding: 0;
box-sizing: border-box;
}

.container{
	margin-top: 50px;
	width: 900px;
}

.card-header{
	background-color: #d5f2d6;
}

button{
	margin-top: 5px;
}

.error-message{
	color: red;
	margin-bottom: 8px;
}

.success-message{
	color: green;
	margin-bottom: 8px;
}

nav ul{
	margin-right: 30%;
}
</style>
<body>
<%
Connection conn = null;
Statement stmt = null;
String type = request.getParameter("type");
String id, flightName, fromCity, toCity, date, time, airportName, price, description;
%>
	<nav>
	    <ul>
	       <li><a href="index.jsp">Home</a></li>
	       <li><a href="addFlight.jsp">Add Flight</a></li>
	       <li><a href="flightReport.jsp" class="active">Flight Report</a></li>
	       <li><a href="ticketReport.jsp">Ticket Report</a></li>
	     </ul>
    </nav>
<% 
try {
Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_reservation_system", "root", "");
stmt = conn.createStatement();
String query = "select * from flight where id='" + request.getParameter("id") + "'";
ResultSet rs = stmt.executeQuery(query);
%>
	
<% 
if(rs.next()){		
	id = rs.getString("id");
 	flightName = rs.getString("flightName");
    fromCity = rs.getString("fromCity");
 	toCity = rs.getString("toCity");
 	String flightDate = rs.getString("flightDate");
 	String[] parts = flightDate.split(" ");
 	date = parts[0];
 	time = parts[1];
 	airportName = rs.getString("airportName");
 	price = rs.getString("price");
 	description = rs.getString("description");
%>
     	<div class="container">
		<div class="card" id="login">
		  <div class="card-header">Add Flight</div>
		  <div class="card-body">
		  	<div class='error-message'></div>
		  	<div class='success-message'></div>
		  	<form>
				<input type="hidden" class="form-control" name="id" value="<%= id %>"/>
			
				<div class="mb-3">
	  				<label for="" class="form-label">Flight Name</label>
	  				<input type="text" class="form-control"
	  				 name="flightName"
	  				 value="<%= flightName %>"
	  				 placeholder="Enter Flight Name"
	  				 autocomplete="off" 
	  				 />
				</div>	
				<div class="mb-3">
	  				<label for="" class="form-label">From City</label>
	  				<input type="text" class="form-control"
	  				 name="fromCity"
	  				 value="<%= fromCity %>"
	  				 placeholder="Enter From City"
	  				 autocomplete="off" 
	  				 />
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">To City</label>
	  				<input type="text" class="form-control"
	  				 name="toCity"
	  				 value="<%= toCity %>"
	  				 placeholder="Enter To City"
	  				 autocomplete="off" 
	  				 />
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Date</label>
	  				<input type="date" class="form-control"
	  				 name="date"
	  				 value="<%= date %>"
	  				 autocomplete="off" 
	  				 />
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Time</label>
	  				<input type="time" class="form-control"
	  				 name="time"
	  				 value="<%= time %>"
	  				 autocomplete="off" 
	  				 />
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Airport Name</label>
	  				<input type="text" class="form-control"
	  				 name="airportName"
	  				 value="<%= airportName %>"
	  				 placeholder="Enter Airport Name"	  				 
	  				 autocomplete="off" 
	  				 />
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Total Price</label>
	  				<input type="text" class="form-control"
	  				 name="price"
	  				 value="<%= price %>"
	  				 placeholder="Enter Total Price"
	  				 autocomplete="off" 
	  				 />
				</div>
				<div class="mb-3">
  					<label for="" class="form-label">Description</label>
  					<textarea class="form-control" 
  					 name="description"
  					 rows="3" 
  					 placeholder="Your Description"><%= description %></textarea>
				</div>																
				<button type="submit" class="btn btn-success" id="saveBtn">Save</button>
				<button type="reset" class="btn btn-primary">Clear</button>		
			</form>
		  </div>
		</div>
	</div>
<% 
	}
	
} catch (Exception e) {			
	e.printStackTrace();
}
    %>
</body>
</html>