const form = document.querySelector('form');

form.addEventListener('submit', function(e){
	e.preventDefault();
	const obj = {};
	const formData = new FormData(this);
	let temp = "";
	
	for(const [key, value] of formData.entries()){
		if(key === 'date'){
			temp += value + " ";
			continue;
		}
		
		if(key === 'time'){
			temp += value;
			continue;
		}
		
		obj[key] = value;
	}
	
	obj['type'] = 'edit';
	obj['date'] = temp;
	
	fetch('AdminActionServlet', {
		method: 'post',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},
		body: new URLSearchParams(obj).toString()
	})
	.then(response => response.json())
	.then(data => {
		if(data.success) location.href = 'flightReport.jsp';
	});		
});