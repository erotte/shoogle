module ForecastsHelper
  def rating_as_text
    case @forecast.rating
      when 5 then "mit Sicherheit" 
      when 4 then "sehr wahrscheinlich" 
      when 3 then "bestimmt" 
      when 2 then "wahrscheinlich" 
      when 1 then "vermutlich" 
      else "vielleicht"
    end
  end

  def rating_as_sign
    good_stars = '*' * (@forecast.rating + 1)
    bad_stars  = '*' * (@forecast.max_rating - @forecast.rating)
    
    "<span class='good_stars'>#{good_stars}</span><span class='bad_stars'>#{bad_stars}</span>"
  end
  
  def shoes_blank?
    @foot.shoes.delete_if{|shoe| shoe.new_record?}.blank?
  end

  def first_shoe?
    @foot.shoes.delete_if{|shoe| shoe.new_record?}.size == 1
  end

  def result_info
    "( direkte Treffer: #{@forecast.direct_matches} ergeben #{@forecast.direct_matches_size},
    umgerechnete Treffer: #{@forecast.transposed_matches} ergeben #{@forecast.transposed_matches_size},
    Marken-Treffer: #{@forecast.manufacturer_matches} ergeben #{@forecast.manufacturer_matches_size}, 
    durchschnittliche Schuhgröße: #{@forecast.average_shoe_size})"

  end

  def add_target_shoe_form 
    remote_form_for( :foot, :url => {:action => 'add_target_shoe'}, :update => 'forecast_shoes_form', :complete => '$("#forecast_shoes_form").show(); $("#foot_fields input.manufacturer").focus(); $("#search_shoes_submit").val("Ändern")', :html => {:class => "foot_shoes_form", :id => "searched_shoe_form" }) 
  end
  
end
