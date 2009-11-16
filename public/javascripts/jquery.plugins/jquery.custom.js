/**	toggle default value of input field 
 example to place in $(document).ready():
 $('input#searchValue').toggleDefaultValue();
 */
(function($) {
	jQuery.fn.toggleDefaultValue = function() {
		if ($(this).length < 1) 
			return;
		$(this).focus(function() {
			$(this).val( $(this).val() == this.defaultValue ?	"" : null);
		});
		$(this).blur(function() {
			strg = $(this).val().replace(/\s/, "") == "" ? this.defaultValue : $(this).val();
			$(this).val(strg) 
		});
	};
})(jQuery);