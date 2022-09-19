const form = document.querySelector('form');
const successMsg = document.querySelector('.success-message');

form.addEventListener('submit', function(e){
	e.preventDefault();
	const properties = ['id', 'flightName', 'fromCity', 'toCity', 'date', 'time', 'duration', 'airportName', 'price', 'description'];
	const obj = {};
	let temp = "";
	
	properties.forEach((prop) => {
		if(prop === 'date'){
			temp += form[prop].value + " ";
		}else if(prop === 'time'){
			temp += form[prop].value + ":00";
		}else{
			obj[prop] = form[prop].value;
		}	
	});
	
	
	obj["type"] = "addFlight";
	obj["date"] = temp;
	
	fetch('AdminActionServlet', {
		method: 'post',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},
		body: new URLSearchParams(obj).toString()
	})
	.then(response => response.json())
	.then(data => {
		if(data.success){
			successMsg.textContent = 'Data added successfully';
			form.reset();
		}
	});
});