// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery.ajaxSetup({
	'beforeSend': function(xhr){xhr.setRequestHeader('Accept','text/javascript')}
})

$(document).ready(function(){
  
	init_autocompletion();
	$("input.passive").toggleDefaultValue();
  init_searched_shoe_toggles();
  init_searched_shoe_radio_toggles()	
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

init_searched_shoe_radio_toggles = function(){
	
  var $searched_shoe_form = $('#searched_shoe_form')
  var $shoe_row = $('.shoe_row', $searched_shoe_form)
	$("#with_searched_shoe_false").change(function(event){
    this.checked ? $shoe_row.hide('normal') : $shoe_row.show('normal') 
    $('input[type=text]', $searched_shoe_form).attr('disabled', 'disabled')	 
	})
  $("#with_searched_shoe_true").change(function(event){
    this.checked ? $shoe_row.show('normal') : $shoe_row.hide('normal') 
    $('input[type=text]', $searched_shoe_form).removeAttr('disabled')	 	 
	})
}

init_searched_shoe_toggles = function(){
	$('#toggle_model_search').click( function(event){
		event.preventDefault()
		var $clicked_link = $(this);
		$('span.model', $(this).closest('form')).toggle(0, function(){
			var linktext = $(this).is(":visible") ? "nur nach Marke suchen" : "Hersteller und Modell suchen"
			var intro = $(this).is(":visible") ? "In welcher Größe passt mir von " : "Im welcher Größe passen mir Schuhe vom Hersteller"
				$clicked_link.text(linktext).highlight();
				$("#searched_shoe_intro").text(intro).highlight();
		})
	});

	
}