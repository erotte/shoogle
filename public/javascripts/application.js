// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery.ajaxSetup({
'beforeSend': function(xhr){xhr.setRequestHeader('Accept','text/javascript')}
})

$(document).ready(function(){
  
	init_autocompletion();
	$("input.passive").toggleDefaultValue();
  init_searched_shoe_toggles()	
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

init_searched_shoe_toggles = function(){
	$('#toggle_model_search').click( function(event){
		event.preventDefault()
		$clicked_link = $(this);
		$('span.model', $(this).closest('form')).toggle(0, function(){
			linktext = $(this).is(":visible") ? "nur nach Marke suchen" : "Hersteller und Modell suchen"
				$clicked_link.text(linktext).highlight();
		})
	})
}