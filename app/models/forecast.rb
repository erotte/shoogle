class Forecast

  attr_accessor :size, 
    :average_shoe_size,
    :direct_matches, :direct_matches_size, 
    :transposed_matches, :transposed_matches_size,
    :manufacturer_matches, :manufacturer_matches_size
  
  def initialize params
    @foot = params[:foot]
    compute_average_size
    (@direct_matches_size, @direct_matches) = compute_size_and_count(@foot.direct_matches.values)
    (@transposed_matches_size, @transposed_matches) = compute_size_and_count(@foot.transposed_matches.values)
    (@manufacturer_matches_size, @manufacturer_matches) = compute_size_and_count(@foot.manufacturer_matches.values)
    choose_recommended_size
  end
  
  def choose_recommended_size
    @size = @direct_matches_size || @transposed_matches_size || @manufacturer_matches_size || @average_shoe_size
  end

  def compute_average_size
    @average_shoe_size = @foot.shoes.map{|shoe| shoe.sizes["eur"]}.compact.mean_average
  end
  
  def compute_size_and_count matches
    matches = matches.reject{|match| match.unit != "eur"}
    count = 0
    shoe_size = nil
    matches.each do |match|
      shoe_size ||= 0
      shoe_size += match.size
      count += match.num_feet
    end
    shoe_size /= matches.size if matches.size > 1
    shoe_size = round shoe_size
    [shoe_size, count]
  end

  def round(f, digits=2)
    return unless f
    factor = (10 ** digits).to_f
    (f * factor).round / factor
  end
  
  def has_model?
    model.present?
  end
  
  def model
    @foot.searched_shoe.model_name
  end

  def manufacturer
    @foot.searched_shoe.manufacturer_name
  end

  def rating
    case @direct_matches
      when 0    then 0 
      when 1..3 then 1
      when 4..7 then 2
      else 3
    end
  end

  def max_rating
   3
  end
  
  def log msg, matches 
    matches.each do |match|
      Rails.logger.debug "#{msg} #{match.inspect}"
    end
  end

end