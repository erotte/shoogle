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
    good_stars = '*' * (@forecast.rating + 1)
    bad_stars = '*' *  (@forecast.max_rating - @forecast.rating)
    
    "<span class='good_stars'>#{good_stars}</span><span class='bad_stars'>#{bad_stars}</span>"
  end
  
  def shoes_blank?
    @foot.shoes.delete_if{|shoe| shoe.new_record?}.blank?
  end

  def first_shoe?
    @foot.shoes.delete_if{|shoe| shoe.new_record?}.size == 1
  end


end