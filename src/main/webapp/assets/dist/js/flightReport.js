const form = document.querySelector('form');
const container = document.querySelector('.container');
const deleteBtn = document.querySelector('#deleteBtn');

form.addEventListener('submit', function(e){
	e.preventDefault();
	
	const flightName = form.flightName.value;
	const flightId = form.id.value;
	
	fetch('AdminActionServlet', {
		method: 'post',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},
		body: `id=${flightId}&flightName=${flightName}&type=search`
	})
	.then(response => response.text())
	.then(text => {
		document.querySelector('tbody').innerHTML = text;
	})
});

container.addEventListener('click', function(e){
	const target = e.target;
	if(target.classList.contains("edit-btn")){
		const id = e.target.id.split("-")[2];
		window.location.href = `flightEdit.jsp?id=${id}`;
	}
});

deleteBtn.addEventListener('click', function(){	
	let str = "idKeys=";
	const idKeys = [];
	document.querySelectorAll('input[type="checkbox"]:checked').forEach((element) => {
		const id = element.value.split("-")[1];
		idKeys.push(id);
		str += `${id}-`;
	});
	
	let query = str.substring(0, str.length - 1) + "&type=delete";
	
	console.log(query);
	
	fetch('AdminActionServlet', {
		method: 'post',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},
		body: query
	})
	.then(response => response.json())
	.then(data => {
		if(data.success){
			for(const id of idKeys){
				document.querySelector(`tr#row-${id}`).remove();
			}
		}
	})
	
});