const form = document.querySelector("form");


form.onsubmit = (event) => {
	event.preventDefault();
	const from = form.from.value.trim();
	const destincation = form.destincation.value.trim();
	const date = form.date.value.trim();
	
	if(!from  || !destincation || !date){
		document.querySelector('.error-message').textContent = 'All fields are required!';
		return;
	}else{
		fetch('ActionServlet', {
			method: 'post',
			headers: {
				'Content-Type': 'application/x-www-form-urlencoded'
			},
			body: `from=${from}&destincation=${destincation}&date=${date}&type=search`
		})
		.then(response => response.text())
		.then(text => {
			document.querySelector('#flight-table tbody').innerHTML = text;
		});
	}
	
};

document.querySelector('table').addEventListener('click', function(e){
	const target = e.target;
	
	if(target.classList.contains("order-btn")){
		const id = target.id.split("-")[2];
		
		window.location.href = `registration.jsp?flightId=${id}`;
	}
});