<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ticket Report</title>
<link rel="stylesheet" href="../assets/dist/css/bootstrap.css">
<link rel="stylesheet" href="../assets/dist/css/nav.css">
<link rel="stylesheet" href="../assets/dist/css/flightInfo.css">
</head>
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
		margin-right: 120px !important;
	}
	
	
	.btn-group{
		margin-left: 86% !important;
	}
	
	nav{
		margin-bottom: 25px;
	}

	nav ul{
		margin-right: 30%;
	}
		
</style>
<body>
	<nav>
      <ul>
        <li><a href="index.jsp">Home</a></li>
	       <li><a href="addFlight.jsp">Add Flight</a></li>
	       <li><a href="flightReport.jsp">Flight Report</a></li>
        <li><a href="flightInfo.jsp" class="active">Ticket Report</a></li>
      </ul>
    </nav>
    <div class="error-message"></div>
    <main>	    	
		<div class="search">							
			<form method="post" action="" id="searchForm">
		    	<span>Flight Name:</span>
		    	<input type="text" name="flightName" placeholder="Search By Flight Name" autocomplete="off"/>
		    	<span>Email Address</span>
		    	<input type="text" name="email" placeholder="Search By Email Address" autocomplete="off"/>
		    	<button type="submit" class="btn btn-primary btn-sm" id="searchBtn">Search</button>
			</form>
	    	</div>
	    	<div class="container">
	    		<table class="table table-striped" id="flight-table">
				  <thead>
				    <tr>
				      <th scope="col">Flight Name</th>
				      <th scope="col">User Name</th>
				      <th scope="col">Mobile No</th>							     
				      <th scope="col">Email ID</th>
				      <th scope="col">Date</th>
				      <th scope="col">Time</th>
				      <th scope="col">No Of Person</th>
				      <th scope="col">Price</th>
				      <th scope="col">Final Price</th>				      
				    </tr>
				  </thead>
				  <tbody>
				  <% 
				  	Connection conn = null;
				 	Statement stmt = null;
				 	Class.forName("com.mysql.jdbc.Driver");
				 	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_reservation_system", "root", "");
				 	String sql = "select userId, `user`.email, flightId, phoneNumber, noOfPersons, flightName, price, firstName, lastName, flightDate from `order` INNER JOIN `flight` ON `order`.`flightId` = `flight`.id INNER JOIN `user`  ON `user`.id = `order`.`userId`;";
				 	stmt = conn.createStatement();
				 	ResultSet rs = stmt.executeQuery(sql);
				 	
				 	while(rs.next()){
				 		String phoneNumber = rs.getString("phoneNumber");
				 		int noOfPersons = rs.getInt("noOfPersons");
				 		String flightName = rs.getString("flightName");
				 		int price = rs.getInt("price");
				 		String firstName = rs.getString("firstName");
				 		String lastName = rs.getString("lastName");		
				 		String email = rs.getString("email");
				 		String date = rs.getString("flightDate");
				 		String [] parts = date.split(" ");
				 		int totalAmount = price * noOfPersons;
				 		
				 	%>
				 		<tr data-id="<%= flightName.toLowerCase() + "-" + email.toLowerCase() %>">
				 			<td><%= flightName %></td>
				 			<td><%= firstName + " " + lastName %></td>
				 			<td><%= phoneNumber %></td>
				 			<td><%= email %></td>
				 			<td><%= parts[0] %></td>
				 			<td><%= parts[1] %></td>
				 			<td><%= noOfPersons %></td>
				 			<td><%= price %></td>
				 			<td><%= totalAmount %></td>
				 		</tr>				 		
				 	<% 
				 	}
				  	
				  %>
				  </tbody>
				</table>
	    	</div>
	    </main>
	    <script>
	    
	    
	    	const searchForm = document.querySelector('#searchForm');
	    	const flightTable = document.querySelector('#flight-table');
	    	const rows = flightTable.querySelectorAll('tbody tr');
	    		    		    		    	    		    		    	
	    	searchForm.addEventListener('submit', function(e){
	    		e.preventDefault();
	    		const flightName = this.flightName.value.trim().toLowerCase();
	    		const email = this.email.value.trim().toLowerCase();
	    		const fragment = new DocumentFragment();
	    			    			    		    		
	    		if(flightName === '' && email === '') return;
	    		
	    		if(flightName !== '' && email === ''){	    	    				    				    			    			
	    			rows.forEach(element => {
	    				const id = element.dataset.id;
	    				if(id.startsWith(flightName)){	    						    					
	    					fragment.appendChild(element);
	    				}
	    			});	    				    				    			
	    		} 
	    		
	    		if(flightName === '' && email !== ''){	    				    			
	    			rows.forEach(element => {
	    				const id = element.dataset.id;
		    			const index = id.indexOf('-');
		    			if(id.startsWith(email, index + 1)){
		    				fragment.appendChild(element);
		    			}
	    			});	    				    		
	    		}
	    		
	    		if(flightName !== '' && email !== ''){	    				    			
	    			rows.forEach(element => {
	    				const id = element.dataset.id;
		    			const index = id.indexOf('-');
		    			if(id.startsWith(flightName, 0)){
		    				if(id.startsWith(email, index + 1)){
		    					fragment.appendChild(element);	
		    				}		    				
		    			}
	    			});	
	    		}
	    		
    			flightTable.querySelector('tbody').innerHTML = '';
    			flightTable.querySelector('tbody').appendChild(fragment);
	    	});
	    </script>
</body>
</html>