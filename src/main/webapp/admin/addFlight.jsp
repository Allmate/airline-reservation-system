<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Flight</title>
<link rel="stylesheet" href="../assets/dist/css/bootstrap.css">
<link rel="stylesheet" href="../assets/dist/css/nav.css">
<script src="../assets/dist/js/addFlight.js" defer></script>
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
	<nav>
	    <ul>
	       <li><a href="index.jsp">Home</a></li>
	       <li><a href="addFlight.jsp" class="active">Add Flight</a></li>
	       <li><a href="flightReport.jsp">Flight Report</a></li>
	       <li><a href="ticketReport.jsp">Ticket Report</a></li>
	     </ul>
    </nav>
	<div class="container">
		<div class="card" id="login">
		  <div class="card-header">Add Flight</div>
		  <div class="card-body">
		  	<div class='error-message'></div>
		  	<div class='success-message'></div>
		  	<form>
			    <div class="mb-3">
				  <label for="" class="form-label">Flight NO</label>
				  <input type="text" class="form-control"
				  	name="id"
				  	placeholder="Enter Flight NO" 				  	
				  	autocomplete="off" 
				  	/>
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Flight Name</label>
	  				<input type="text" class="form-control"
	  				 name="flightName"
	  				 placeholder="Enter Flight Name"
	  				 autocomplete="off" 
	  				 />
				</div>	
				<div class="mb-3">
	  				<label for="" class="form-label">From City</label>
	  				<input type="text" class="form-control"
	  				 name="fromCity"
	  				 placeholder="Enter From City"
	  				 autocomplete="off" 
	  				 />
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">To City</label>
	  				<input type="text" class="form-control"
	  				 name="toCity"
	  				 placeholder="Enter To City"
	  				 autocomplete="off" 
	  				 />
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Date</label>
	  				<input type="date" class="form-control"
	  				 name="date"
	  				 autocomplete="off" 
	  				 />
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Time</label>
	  				<input type="time" class="form-control"
	  				 name="time"
	  				 autocomplete="off" 
	  				 />
				</div>
				<div class="mb-3">	  				
	  				<input type="hidden" class="form-control"
	  				 name="duration"
	  				 placeholder="Enter Travel Duration"
	  				 autocomplete="off"
	  				 value =""	  				 
	  				 />
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Airport Name</label>
	  				<input type="text" class="form-control"
	  				 name="airportName"
	  				 placeholder="Enter Airport Name"
	  				 autocomplete="off" 
	  				 />
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Total Price</label>
	  				<input type="text" class="form-control"
	  				 name="price"
	  				 placeholder="Enter Total Price"
	  				 autocomplete="off" 
	  				 />
				</div>
				<div class="mb-3">
  					<label for="" class="form-label">Description</label>
  					<textarea class="form-control" name="description" rows="3" placeholder="Your Description"></textarea>
				</div>																
				<button type="submit" class="btn btn-success" id="saveBtn">Save</button>
				<button type="reset" class="btn btn-primary">Clear</button>		
			</form>
		  </div>
		</div>
	</div>
</body>
</html>