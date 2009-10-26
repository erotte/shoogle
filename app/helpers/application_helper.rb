# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def debug_toggle(object)
    out =   content_tag :div, debug(object), :style => 'display:none', :id => "debug" 
    out +=  content_tag :small, link_to_function( "debug", '$("#debug").toggle("normal")')  
    out 
  end
    
end
