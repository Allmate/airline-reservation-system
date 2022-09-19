const form = document.querySelector('form');

const loginBtn = form.querySelector('#loginBtn');
const errorMsg = document.querySelector('.error-message');

const validateEmail = (email) => {
  return String(email)
    .toLowerCase()
    .match(
      /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    );
};

loginBtn.addEventListener('click', function(e){
	e.preventDefault();
	const email = form.email.value;
	const password = form.password.value;
	
	if(email === '' || password === ''){
		errorMsg.textContent = 'Please fill all required fields';
		return;
	}
	
	if(!validateEmail(email)){
		errorMsg.textContent = 'Invalid email address';
		return;
	}
	
	fetch('ActionServlet', {
		method: 'post',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},
		body: `email=${email}&password=${password}&type=adminLogin`
	})
	.then(response => response.json())
	.then(data => {
		if(data.success){
			window.location.href = "/Airline_Reservation_System/admin/index.jsp";
		}else{
			errorMsg.textContent = "Invalid combination of email and password";
		}
	})
	
	
});

