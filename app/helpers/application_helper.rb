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

  def formatted_size shoe
    number_with_precision( shoe.size, :precision => 2, :separator => ".", :strip_insignificant_zeros => true)
  end

  def size_code shoe
    shoe.has_eur_size? ? 'EUR' : 'US'
  end

  def pretty_size size_string
    entities_list = {
      "1/2" => '&frac12;',  # One half
      "1/4" => '&frac14;',  # One quarter
      "3/4" => '&frac34;',  # Three quarters
      "1/3" => '&#x2153;',  # One third
      "2/3" => '&#x2154;',  # Two thirds
      "1/5" => '&#x2155;',  # One fifth
      "2/5" => '&#x2156;',  # Two fifths
      "3/5" => '&#x2157;',  # Three fifths
      "4/5" => '&#x2158;',  # Four fifths
      "1/6" => '&#x2159;',  # One sixth
      "5/6" => '&#x215A;',  # Five sixths
      "1/8" => '&#x215B;',  # One eighth
      "3/8" => '&#x215C;',  # Three eighths
      "5/8" => '&#x215D;',  # Five eighths
      "7/8" => '&#x215E;'   # Seven eighths
    }
    entities_list.each do |key, value|
      size_string.gsub!(key, value)
    end
    size_string
  end

end
