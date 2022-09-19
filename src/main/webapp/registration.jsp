<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration</title>
<link rel="stylesheet" href="assets/dist/css/bootstrap.css">
<link rel="stylesheet" href="assets/dist/css/login.css">
<link rel="stylesheet" href="assets/dist/css/nav.css">

<script src="assets/dist/js/bootstrap.js"></script>
<style>
	.card a:hover{
		background-color: initial;
		text-decoration: underline;		
	}
	
	.card a{
		display: block;
		margin-top: 10px;
	}
</style>
</head>
<body>
	<nav>
      <ul>
        <li><a href="index.jsp">Home</a></li>
        <li><a href="flightInfo.jsp" class="active">Flight</a></li>
        <li><a href="login.jsp">Login</a></li>
      </ul>
    </nav>
    
    <!-- Registration Form -->
	<div class="container">
		<div class="card" id="login">
		  <div class="card-header">
		    Registration
		  </div>
		  <div class="card-body">
		  	<div class='error-message'></div>
		  	<form method="post" action="#" class="registration-form">
			    <div class="mb-3">
				  <label for="" class="form-label">First Name</label>
				  <input type="text" class="form-control"
				  	name="firstName" 
				  	placeholder="Enter your first name"				  	
				  	autocomplete="off" 
				  	/>
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Last Name</label>
	  				<input type="text" class="form-control"
	  				 name="lastName"
	  				 placeholder="Enter your last name"
	  				 autocomplete="off" 
	  				 />
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Email Address</label>
	  				<input type="email" class="form-control"
	  				 name="email"
	  				 placeholder="Enter your email address"
	  				 autocomplete="off" 
	  				 />
				</div>
				<div class="mb-3">
	  				<label for="" class="form-label">Password</label>
	  				<input type="text" class="form-control"
	  				 name="password"
	  				 placeholder="Enter your password"
	  				 autocomplete="off" 
	  				 />
				</div>						
				<button type="submit" class="btn btn-success" id="registerBtn">Sign up</button>
				<button type="reset" class="btn btn-success">Clear</button>	
				<div>
					<a href="#" data-bs-toggle="modal" data-bs-target="#paymentModal">Already have an account! Login</a>
				</div>	
			</form>
		  </div>
		</div>
	</div>
	
	<!-- Login Form -->
	<div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		     	<div class="modal-header">
		        <h5 class="modal-title" id="">Login</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		      	<div class='login-error-message'></div>
		      	<form class="login-form">
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
		  				<input type="text" class="form-control"
		  				 name="password"
		  				 placeholder="Enter your password"
		  				 autocomplete="off" 
		  				 />
					</div>
				</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary" id="loginBtn">Submit</button>
		      </div>
		    </div>
		  </div>
	</div>
	
	<script>
		const registrationForm = document.querySelector('.registration-form');
		const loginForm = document.querySelector('.login-form');
		const errorMsg = document.querySelector('.error-message');	
		const loginErrMsg = document.querySelector('.login-error-message');
		const loginBtn = document.querySelector('#loginBtn');
		
		loginBtn.addEventListener('click', function(e){
			e.preventDefault();
			loginErrMsg.textContent = "";
			const email = loginForm.email.value.trim();
			const password = loginForm.password.value.trim();
			
			if(email === '' || password === ''){
				console.log('Please fill all required fields');
				return;
			}
			
			const obj = {
				email,
				password
			};
			
			obj["type"] = "userLogin";
			
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
					const userId = data.userId;
					const flightId = new URLSearchParams(window.location.search).get('flightId');
					window.location.href = 'order.jsp?flightId=' + flightId + '&userId=' + data.userId;
				}else{
					loginErrMsg.textContent = "Invalid combination of email and password";
				}
			})
			
		});
				
		registrationForm.addEventListener('submit', function(e){
			e.preventDefault();
			errorMsg.textContent = "";
			
			const firstName = registrationForm.firstName.value;
			const lastName = registrationForm.lastName.value;
			const email = registrationForm.email.value;
			const password = registrationForm.password.value;
			const flightId = new URLSearchParams(window.location.search).get('flightId');
			
			const obj = {
					firstName,
					lastName,
					email,
					password,				
			};
			
			obj['flightId'] = flightId;
			obj['type'] = 'registration';
			
			const isEmpty = Object.values(obj).some(v => v === '');
						
			if(isEmpty){
				errorMsg.textContent = 'please fill all required fields!';
				return;
			}
			
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
					if(data.causeRoot === 'duplicate email address')
						errorMsg.textContent = 'Email address already exists';
				}else{
					window.location.href = 'order.jsp?flightId=' + flightId + '&userId=' + data.userId;
				}
			})
		});
	</script>	
</body>
</html>