<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment</title>
<link rel="stylesheet" href="assets/dist/css/bootstrap.css">
<link rel="stylesheet" href="assets/dist/css/nav.css">
<link rel="stylesheet" href="assets/dist/js/bootstrap.js">
<script src="assets/dist/js/bootstrap.js"></script>
<style>

*{
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

tr {
  display: flex;
  flex-wrap: wrap;
  margin-left: 0;
}

td {
  font-size: 17px;
  padding: 0;
  flex: calc(50%);
  text-align: left;
}

.container{
	display: flex;
	flex-direction: row;
	justify-content: center;
	margin-bottom: 30px;
}


td > span:nth-child(1){
	font-weight: 500;
	margin-right: 20px;
}

.card{
	width: 800px !important;
	padding: 20px 20px 15px 20px;
	
}

.card-header{
	background-color: lightgrey;
	font-size: 20px;
	margin-left: 0;
}

.card-body{
	padding-bottom: 0;
	padding-top: 15px;	
	padding-left: 0;
	padding-right: 0;
}

.btn-group{
	margin-left: 80%;
}


</style>
</head>
<body>
<%	
	Connection conn = null;
	Statement stmt = null;
	
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/airline_reservation_system", "root", "");
	stmt = conn.createStatement();
	
	String flightId = request.getParameter("flightId");
	String userId = request.getParameter("userId");	
	String address = session.getAttribute("address").toString();
	String phoneNumber = session.getAttribute("phoneNumber").toString();
	String noOfPerson = session.getAttribute("noOfPerson").toString();
	String email = session.getAttribute("email").toString();	
	int totalAmount = 0;					
%>
	<nav>
      <ul>
        <li><a href="index.jsp">Home</a></li>
        <li><a href="flightInfo.jsp" class="active">Flight</a></li>
        <li><a href="login.jsp">Login</a></li>
      </ul>
    </nav>
    
    <form style="display: none;" id="hiddenForm">
	    <input type="hidden" name="flightId" value="<%= flightId %>" />
    	<input type="hidden" name="userId" value="<%= userId %>" />
    	<input type="hidden" name="address" value="<%= address %>" />
    	<input type="hidden" name="phoneNumber" value="<%= phoneNumber %>" />
    	<input type="hidden" name="noOfPerson" value="<%= noOfPerson %>" />
    	<input type="hidden" name="email" value="<%= email %>" />
    </form>    
    
    <div id="success-message" style="color: green;margin-left: 37%; margin-top: 20px; margin-bottom: 10px; font-size: 25px;"></div>
              
    <div class="container">
    	<div class="card">
    		<div class="card-header">Confirm Details</div>
    		<div class="card-body"></div>    
				<table class="table table-striped">
					<tbody>
						<%		
							String query1 = String.format("select * from flight where id = '%s'", flightId);
							ResultSet rs1 = stmt.executeQuery(query1);
							
							while(rs1.next()){					
								String id = rs1.getString("id");
								String flightName = rs1.getString("flightName");
								String travel = rs1.getString("fromCity") + " to " + rs1.getString("toCity");
								String [] parts = rs1.getString("flightDate").split(" ");
								String airportName = rs1.getString("airportName");
								totalAmount = rs1.getInt("price") * Integer.parseInt(noOfPerson);
						%>
							<tr>
								<td>
									<span>Flight No:</span>
									<span><%= id %></span>
								</td>
								<td>
									<span>Flight Name:</span>
									<span><%= flightName %></span>
								</td>								
							</tr>
							<tr>
								<td>
									<span>Travel:</span>
									<span><%= travel %></span>
								</td>
								<td>
									<span>Date:</span>
									<span><%= parts[0] + " : " + parts[1] %></span>
								</td>								
							</tr>
							<tr>
								<td>
									<span>Airport Name:</span>
									<span><%= airportName %></span>
								</td>
								<td>
									<span>Ticket Price:</span>
									<span><%= rs1.getInt("price") %></span>
								</td>								
							</tr>
						<%	
							}
						%>
					</tbody>
				</table>
		</div>
	</div>
	
	<div class="container">
		<div class="card">
			<div class="card-header">Your Details</div>
			<div class="card-body">
				<table class="table table-striped">
					<tbody>
						<%
							String query2 = String.format("select * from user where id = %s", userId);
							ResultSet rs2 = stmt.executeQuery(query2);
							while(rs2.next()){
								String name = rs2.getString("firstName") + " " + rs2.getString("lastName");
						%>
							<tr>
								<td>
									<span>Name:</span>
									<span><%= name %></span>
								</td>
								<td>
									<span>Contact No:</span>
									<span><%= phoneNumber %></span>
								</td>								
							</tr>
							<tr>
								<td>
									<span>Email Address:</span>
									<span><%= email %></span>
								</td>
								<td>
									<span>No of persons:</span>
									<span><%= noOfPerson %></span>
								</td>								
							</tr>
							<tr>
								<td>
									<span>Address:</span>
									<span><%= address %></span>
								</td>
								<td>
									<span>Final Amount:</span>
									<span><%= totalAmount %></span>
								</td>								
							</tr>							
						<%
							}
						%>
					</tbody>
				</table>
			</div>
		</div>		
	</div>
	<div class="btn-group">
		<button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#paymentModal">Payment and Book</button>
		<button class="btn btn-outline-primary">Cancel</button>
	</div>
	
	
	
<div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="">Payment</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
	  	<div class="mb-3">
	    	<label for="" class="form-label">Card Number:</label>
			<input type="text" class="form-control"
			 name="cardNumber" 
		     placeholder="Enter your card number"				  	
			 autocomplete="off" 
		    />
		</div>
		<div class="mb-3">
	  		<label for="" class="form-label">Card Holder Name:</label>
	  		<input type="text" class="form-control"
	  		 name="cardHolderName"
	  		 placeholder="Enter your Card Holder Name"
	  		 autocomplete="off" 
	  		/>
		</div>
		<div class="mb-3">
	  		<label for="" class="form-label">Month:</label>
	  		<input type="text" class="form-control"
	  		 name="month"
	  		 placeholder="Enter Month"
	  		 autocomplete="off" 
	  		/>
		</div>
		<div class="mb-3">
	  		<label for="" class="form-label">Year:</label>
	  		<input type="text" class="form-control"
	  		 name="year"
	  		 placeholder="Enter Year"
	  		 autocomplete="off" 
	  		/>
		</div>
		<div class="mb-3">
	  		<label for="" class="form-label">CVV No:</label>
	  		<input type="text" class="form-control"
	  		 name="cvvNo"
	  		 placeholder="Enter your CVV No"
	  		 autocomplete="off" 
	  		/>
		</div>									
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="paymentBtn">Submit</button>
      </div>
    </div>
  </div>
</div>
	
	<script>
		const paymentBtn = document.querySelector('#paymentBtn');
		const hiddenForm = document.querySelector('#hiddenForm');
		const successMsg = document.querySelector('#success-message');
		 			
		paymentBtn.addEventListener('click', function(e){
			const arr = ['flightId', 'userId', 'address', 'phoneNumber', 'noOfPerson', 'email'];
			const obj = {};
			
			arr.forEach((key, value) => {
				obj[key] = hiddenForm[key].value;	
			});
			
			obj['type'] = "payment";
				
			fetch('ActionServlet', {
				method: 'post',
				headers: {
					'Content-Type': 'application/x-www-form-urlencoded'
				},
				body: new URLSearchParams(obj).toString()
			})
			.then(response => response.json())
			.then(data => {
				if(data.success){
					bootstrap.Modal.getInstance(document.querySelector('#paymentModal')).hide();
					successMsg.textContent = "You successfully created your booking!";			
				}
			})
		});
	</script>
	
</body>
</html>