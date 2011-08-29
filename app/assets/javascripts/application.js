// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
// require_tree ./jquery.plugins
// require_tree .

// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
$('#new_foot')
  .live('ajax:complete', function(evt, data, status, xhr){
    $('#panel').html(data.responseText);
    $('#add_shoe_form').show();
    // do something with 'data' response object
  })
      //
      //              $('#losjetzt_eingeben').show('drop', { direction: 'up' });
      //              $('#search_shoes_submit').val('Ändern');
      //              $('#foot_fields input.manufacturer').focus();
      //              init_shoe_completer()
      //             ",

//    init_shoe_completer()
    init_feedback_slider()
//    $("input.passive").toggleDefaultValue();
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
