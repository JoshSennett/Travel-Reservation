function showSearchOptions(){
	document.getElementById("search_dropdown").classList.toggle("show");
}
window.onclick = function(event){
	if(event.target.matches(".dropButton") == false){
		if(document.getElementById("search_dropdown").classList.contains("show"))
		document.getElementById("search_dropdown").classList.remove("show");
	}
}
function selectOption(option){
	document.getElementById("search_dropbutton").innerHTML = option;
	document.getElementById("search_option").setAttribute("value",option);
}
function selectFlightOption(option){
	document.getElementById("search_dropbutton").innerHTML = option;
	document.getElementById("search_option_flight").setAttribute("value",option);
}