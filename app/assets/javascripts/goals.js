$(document).ready(function() {
	$("#edit_title").click(function(){
		$("#goal_title").focus();
	});
	$(".add_user").click(function(e){
		$(e.target).toggleClass("added");
	});
});
