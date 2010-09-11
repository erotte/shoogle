// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery.ajaxSetup({
    'beforeSend': function(xhr) {
        xhr.setRequestHeader('Accept', 'text/javascript')
    }
})

$(document).ready(function() {
    $('#feedback_toggle').toggle(
                                function() {
                                    $('#feedback.sidebar').animate({left:0})
                                },
                                function() {
                                    $('#feedback.sidebar').animate({left: -$('#feedback.sidebar').outerWidth() })
                                }
            )
    $('.shoe_completer').shoe_completer();
    $("input.passive").toggleDefaultValue();
    $('#step-1').show("drop", { direction: "up", duration: 1200 })
    $('#feedback input[type=submit]').live('click', function(event){
       $(this).disable();
    })

})


shoe_add_success = function(that) {
    $('.manufacturer, .model, .size', $(that.target)).val('');
    $('.manufacturer').focus();
}


