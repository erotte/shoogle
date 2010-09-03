# Methods added to this helper will be available to all templates in the application.
include LayoutHelper

module ApplicationHelper

  def debug_toggle(object)
    out =   content_tag :div, debug(object), :style => 'display:none', :class => "debug"
    out +=  content_tag :small, link_to_function("debug", '$(this).closest("div").find(".debug").toggle("normal")')
    out
  end

  def uniq_error_messages_for object
    return "" if !object || object.errors.empty?
    s = '<ul class="errorList">'
    object.errors.errors.values.flatten.uniq.each do |error|
      s << "<li>#{error}</li>"
    end
    s << '</ul>'
    s
  end

  def render_price price
    number_to_currency(price, :unit => "&euro;", :separator => ",", :format => "%n %u")
  end

  def pageless(total_pages, url=nil)
    opts = {
            :totalPages => total_pages,
            :url        => url,
            :loaderMsg  => 'weitere Daten werden geladen &hellip;'
    }

    content_for :bottom do
      out =  javascript_include_tag 'jquery.plugins/jquery.pageless.js'
      out += javascript_tag("$(document).ready(function () { $('#results').pageless(#{opts.to_json});})")
    end
  end

end
