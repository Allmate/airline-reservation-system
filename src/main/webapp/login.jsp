<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Airline Reservation System</title>
<link rel="stylesheet" href="assets/dist/css/bootstrap.css">
<link rel="stylesheet" href="assets/dist/css/login.css">
<link rel="stylesheet" href="assets/dist/css/nav.css">
<script src="assets/dist/js/login.js" defer></script>
</head>
<body>
	<nav>
      <ul>
        <li><a href="index.jsp">Home</a></li>
        <li><a href="flightInfo.jsp" class="active">Flight</a></li>
        <li><a href="login.jsp">Login</a></li>
      </ul>
    </nav>
	<div class="container">
		<div class="card" id="login">
		  <div class="card-header">
		    Login
		  </div>
		  <div class="card-body">
		  	<div class='error-message'></div>
		  	<form>
			    <div class="mb-3">
				  <label for="" class="form-label">Email address</label>
				  <input type="email" class="form-control"
				  	name="email" 
				  	placeholder="Enter your email address"				  	
				  	autocomplete="off" 
				  	/>
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Password</label>
	  				<input type="email" class="form-control"
	  				 name="password"
	  				 placeholder="Enter your password"
	  				 autocomplete="off" 
	  				 />
				</div>						
				<button type="submit" class="btn btn-success" id="loginBtn">Login Account</button>
				<button type="reset" class="btn btn-success">Clear</button>		
			</form>
		  </div>
		</div>
	</div>
</body>
</html>