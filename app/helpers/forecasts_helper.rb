module ForecastsHelper
  def rating_as_text
    case @forecast.rating
      when 3 then "mit Sicherheit" 
      when 2 then "bestimmt" 
      when 1 then "wahrscheinlich" 
      else "vielleicht"
    end
  end

  def rating_as_sign
    good_stars = '*' *  @forecast.rating
    bad_stars = '*' *  (@forecast.max_rating + 1 - @forecast.rating)
    
    "<span class='good_stars'>#{good_stars}</span><span class='bad_stars'>#{bad_stars}</span>"
  end
end