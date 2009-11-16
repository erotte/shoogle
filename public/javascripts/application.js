// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery.ajaxSetup({
'beforeSend': function(xhr){xhr.setRequestHeader('Accept','text/javascript')}
})

$(document).ready(function(){
  
	init_autocompletion();
	// $("input.passive").click(function(){return console.debug(this)});
	$("input.passive").toggleDefaultValue();
	
})	

init_autocompletion = function() {
	$("input.manufacturer").autocomplete("/manufacturers.js");
	$("input.model").autocomplete("/shoe_types/models.js", {
		extraParams: {
		 	manufacturer: function() { 
				return $('.manufacturer', $(this).parents('.shoe_row')).val()
			}
		}
	})
}
