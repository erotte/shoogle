class Forecast < CouchRest::Model::Base

  attr_accessor :size, 
    :average_shoe_size,
    :direct_matches, :direct_matches_size, 
    :transposed_matches, :transposed_matches_size,
    :manufacturer_matches, :manufacturer_matches_size
    :unit
  
  def initialize params
    @foot = params[:foot]
    @unit = :eur and compute_forecast
    @unit = :us  and compute_forecast if not_enough_matches
    choose_unit_of_most_shoes(:eur, :us) and compute_forecast if not_enough_matches
    choose_recommended_size
  end

  def not_enough_matches
    direct_matches == 0 && transposed_matches == 0
  end
  
  def compute_forecast
    compute_average_size
    (@direct_matches_size, @direct_matches)             = compute_size_and_count(@foot.direct_matches.values)
    (@transposed_matches_size, @transposed_matches)     = compute_size_and_count(@foot.transposed_matches.values)
    (@manufacturer_matches_size, @manufacturer_matches) = compute_size_and_count(@foot.manufacturer_matches.values)    
  end
  
  def compute_size_and_count matches
    per_unit = matches.select{|match| match.unit == @unit.to_s}
    count = 0
    shoe_size = nil
    per_unit.each do |match|
      shoe_size ||= 0
      shoe_size += match.size
      count += match.num_feet
    end
    shoe_size /= per_unit.size if per_unit.size > 1
    shoe_size = round shoe_size
    [shoe_size, count]
  end

  def choose_recommended_size
    @size = @direct_matches_size || @transposed_matches_size || @manufacturer_matches_size || @average_shoe_size
  end

  def choose_unit_of_most_shoes(unit1, unit2)
    @foot.shoes.select{|s| s.sizes[unit1.to_s]}.size >= @foot.shoes.select{|s| s.sizes[unit2.to_s]}.size ? @unit = unit1 : @unit = unit2
  end
  
  def compute_average_size
    @average_shoe_size = round(@foot.shoes.map{|shoe| shoe.sizes[@unit.to_s]}.compact.mean_average)
  end
  
  def round(f, digits=2)
    return unless f.is_a? Numeric and not f.nan?
    factor = (10 ** digits).to_f
    (f * factor).round / factor
  end
  
  def has_model?
    model.present?
  end
  
  def has_eur_size?
    @unit == :eur
  end
  
  def model
    @foot.searched_shoe.model_name
  end

  def manufacturer
    @foot.searched_shoe.manufacturer_name
  end

  def rating
    case (@direct_matches * 4 + @transposed_matches * 2 + @manufacturer_matches)
      when     0  then 0 
      when  1..10 then 1
      when 11..20 then 2
      when 21..30 then 3
      when 31..50 then 4
      else 5
    end
  end

  def max_rating
   5
  end
  
  def log msg, matches 
    matches.each do |match|
      Rails.logger.debug "#{msg} #{match.inspect}"
    end
  end

end
