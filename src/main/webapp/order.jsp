<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Airline Reservation System</title>
<link rel="stylesheet" href="assets/dist/css/bootstrap.css">
<link rel="stylesheet" href="assets/dist/css/login.css">
<link rel="stylesheet" href="assets/dist/css/nav.css">
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

String query1 = String.format("select * from flight where id = '%s'", flightId);
String query2 = String.format("select * from user where id = %s", userId);

String date = "";
String email = "";

ResultSet rs1 = stmt.executeQuery(query1);

if(rs1.next()){
	date = rs1.getString("flightDate").split(" ")[0];
}

ResultSet rs2 = stmt.executeQuery(query2);

if(rs2.next()){
	email = rs2.getString("email");
}


%>
	<nav>
      <ul>
        <li><a href="index.jsp">Home</a></li>
        <li><a href="flightInfo.jsp" class="active">Flight</a></li>
        <li><a href="login.jsp">Login</a></li>
      </ul>
    </nav>
	<div class="container">
		<div class="card" id="login">
		  <div class="card-header">Book Ticket</div>
		  <div class="card-body">
		  	<div class='error-message'></div>
		  	<form>
			    <div class="mb-3">
				  <label for="" class="form-label">Email Address</label>
				  <input type="email" class="form-control"
				  	name="email"
				  	value="<%= email %>" 				  	
					disabled				  	
				  	/>
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Phone Number:</label>
	  				<input type="text" class="form-control"
	  				 name="phoneNumber"
	  				 placeholder="Enter your phone number"
	  				 autocomplete="off" 
	  				 />
				</div>				
				<div class="mb-3">
	  				<label for="" class="form-label">Date</label>
	  				<input type="date" class="form-control" name="date" autocomplete="off" value="<%= date %>" disabled/>
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Number of persons:</label>
	  				<input type="number" class="form-control" name="person" placeholder="Enter number of persons" autocomplete="off" />
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Address</label>
	  				<textarea class="form-control" name="address" rows="3" placeholder="Enter your address"></textarea>
				</div>
				
				<button type="submit" class="btn btn-success" id="loginBtn">Proceed to PayMent</button>
				<button type="submit" class="btn btn-success">Cancel</button>
			</form>
		  </div>
		</div>
	</div>
	<script>
		const form = document.querySelector('form');
		
		form.addEventListener('submit', function(e){
			e.preventDefault();
			
			const email = form.email.value;
			const phoneNumber = form.phoneNumber.value;
			const noOfPerson = form.person.value;
			const address = form.address.value;
			const flightId = new URLSearchParams(window.location.search).get('flightId');
			const userId = new URLSearchParams(window.location.search).get('userId');
			
			const obj = {email, phoneNumber, noOfPerson, address};
			
			const isEmpty = Object.values(obj).some(v => v === '');
			
			if(isEmpty){
				console.log('Please fill all required fields');
				return;
			}
			
			obj['flightId'] = flightId;
			obj['userId'] = userId;
			obj['type'] = 'order';
			
			fetch('ActionServlet', {
				method: 'post',
				headers: {
					'Content-Type': 'application/x-www-form-urlencoded'
				},
				body: new URLSearchParams(obj).toString()
			})
			.then(response => response.json())
			.then(data => {
				if(!data.success){
					console.log(data.causeRoot);
					return;
				}
				
				window.location.href = "payment.jsp?flightId=" + flightId + "&userId=" + userId;
			});
			
		});
	</script>
</body>
</html>