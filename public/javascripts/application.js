// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
	$(".foot_shoes_form .remove_shoe:first").hide()
  
	init_autocompletion()
	
	$('#manufacturer').val("Hersteller").addClass('disabled')
	$('#manufacturer').click(function(){
		$(this).val("").removeClass('disabled')
	})
	
	$('#model').val("Modell").addClass('disabled')
	$('#model').click(function(){
		$(this).val("").removeClass('disabled')
	})
	
	$('#forecast_foot_submit').click(function(){
		if ($('#foot_fields').is(':hidden')){ 
			$('#foot_fields').fadeIn() 
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

// Muss zunächst direkt als Funktionsaufruf in das onClick-Attribut, da sont nach jeder Aktion neu initialisiert werden müsste.
// $('#add_shoe_fields').click( 
add_shoe_fields =	function(event){
		cloned_row = $('#insert_shoe_button_row').prev().clone(true) 
		$('input', cloned_row ).val("")
		rows_size =  $(".shoe_row").length
		cloned_row = cloned_row.html().replace(/\[\d\]/g, "["+rows_size+"]").replace(/_\d_/g, "_"+rows_size+"_").replace(/value="[^"]*"/g, 'value=""')
		$('#insert_shoe_button_row').before('<div class="shoe_row">'+cloned_row+'</div>').prev().hide().slideDown(100)
		init_autocompletion()
		return false
		// event.preventDefault()
	}
remove_shoe_fields = function(elem){
	 $(elem).parent('.shoe_row').slideUp(100, function(){$(this).remove()})
}