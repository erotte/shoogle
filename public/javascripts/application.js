// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery.ajaxSetup({
'beforeSend': function(xhr){xhr.setRequestHeader('Accept','text/javascript')}
})

$(document).ready(function(){
  
	init_autocompletion()
	
	$('#forecast_new_foot_submit').click(function(){
		if ($('#forecast_new_foot_fields').is(':hidden')){ 
			$('#forecast_new_foot_fields').fadeIn() 
			return false 
		}
	})
})	

init_autocompletion = function() {
	$(".manufacturer").autocomplete("/manufacturers.js")
	
	$(".model").each(function(i){
		$(this).autocomplete("/shoe_types/models.js", {
			extraParams: {
		  	manufacturer: function() { 
					return $($('.manufacturer')[i]).val()
				}
		  }
		})
	})
}

