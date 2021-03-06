/**	toggle default value of input field 
 example to place in $(document).ready():
 $('input#searchValue').toggleDefaultValue();
 */
(function($) {
	jQuery.fn.toggleDefaultValue = function() {
		if ($(this).length < 1) 
			return;
		$(this).focus(function() {
			if ($(this).val() == this.defaultValue){
				$(this).val("");
				$(this).toggleClass("passive")
			}	
		});
		$(this).blur(function() {
			if ($(this).val().replace(/\s/, "") == "") {
				$(this).val(this.defaultValue);
				$(this).toggleClass("passive")
			}
		});
	};
})(jQuery);

(function($) {
	jQuery.fn.shoe_completer = function() {
    this.each(function(i, that) {
			var $manufacturer = $('input.manufacturer', $(that))
			var $model = $('input.model', $(that))
			var manufacturer_value = function(){return $manufacturer.val()};
			$manufacturer.autocomplete("/manufacturers.js");
			$model.autocomplete("/shoe_types/models.js", {
				extraParams: {
				 	manufacturer: function(){ return $manufacturer.val()}
				}
			})
    });
    return this;
	}
})(jQuery);


(function($) {
	jQuery.fn.highlight = function() {
		$(this).animate({backgroundColor: '#ffb429'}, 150)
		.animate({backgroundColor: 'transparent', opacity: 1}, 300, 'swing')
	}
})(jQuery);


/**
 * Enables or disables any matching elements.
 */
$.fn.disable = function() {
    $(this).attr('disabled', "disabled").addClass('disabled')
};
$.fn.enable = function() {
    $(this).removeAttr('disabled').removeClass('disabled')
};
