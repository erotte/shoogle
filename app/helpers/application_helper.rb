# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def debug_toggle(object)
    out =   content_tag :div, debug(object), :style => 'display:none', :class => "debug" 
    out +=  content_tag :small, link_to_function( "debug", '$(this).closest("div").find(".debug").toggle("normal")')  
    out 
  end
  
  def uniq_error_messages_for object
    return "" if !object || object.errors.empty?
    s = '<ul class="errorList">'
    object.errors.collect {|e| e[1] }.sort.uniq.each do |error|
    s << "<li>#{error}</li>"
    end
    s << '</ul>'
    s
  end
end
