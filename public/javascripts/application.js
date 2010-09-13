// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery.ajaxSetup({
    'beforeSend': function(xhr) {
        xhr.setRequestHeader('Accept', 'text/javascript')
    }
})

$(document).ready(function() {

    init_shoe_completer()
    init_feedback_slider()
    $("input.passive").toggleDefaultValue();
    $('#step-1').show("drop", { direction: "up", duration: 1200 })
//    $('#feedback input[type=submit]').live('click', function(event){
//       $(this).disable();
//       return true;
//    })

})

init_shoe_completer = function(){
	$('.shoe_completer').shoe_completer();
}

shoe_add_success = function(that) {
    $('.manufacturer, .model, .size', $(that.target)).val('');
    $('.manufacturer').focus();
}

init_feedback_slider = function(){
    $('#feedback_toggle').toggle(
        function() {
            $('#feedback.sidebar')
            .animate({left:0})
            .css({'position': 'absolute', 'top':$(this).offset().top+'px'})
        },
        function() {
            $('#feedback.sidebar')
            .animate(
                {left: -$('#feedback.sidebar').outerWidth()},
                function() {
                    $(this).animate({'top':140+$(window).scrollTop()+'px'}, function(){
                        $(this).css({'position':'fixed', top:140})
                    })
                }
             )
        }
    )
}
