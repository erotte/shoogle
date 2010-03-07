class ForecastRenderer
  # TODO rendert nicht nur sondern berechnet auch. das sollten zwei verschiedene klassen machen SRP!
  # TODO weltschlimmster code, refactoring!
  attr_accessor :size, 
    :average_shoe_size,
    :direct_matches, :direct_matches_size, 
    :transposed_matches, :transposed_matches_size,
    :manufacturer_matches, :manufacturer_matches_size
  
  def initialize params
    @foot = params[:foot]
    compute_average_size
    compute_direct_matches
    compute_transposed_matches
    compute_manufacturer_matches
    choose_recommended_size
  end
  
  def compute_direct_matches
    @direct_matches = 0
    matches = @foot.direct_matches.values
    matches.each do |match|
      @direct_matches_size ||= 0
      @direct_matches_size += match.size
      @direct_matches += match.num_feet
    end
    @direct_matches_size /= matches.size if matches.size > 1
    @direct_matches_size = round @direct_matches_size
    log("direct matches", matches)
  end

  def compute_transposed_matches
    @transposed_matches = 0
    matches = @foot.transposed_matches.values
    matches.each do |match|
      @transposed_matches_size ||= 0
      @transposed_matches_size += match.size
      @transposed_matches += match.num_feet
    end
    @transposed_matches_size /= matches.size if matches.size > 1  
    @transposed_matches_size = round @transposed_matches_size 
    log("transposed matches", matches)
  end

  def compute_manufacturer_matches
    @manufacturer_matches = 0
    matches = @foot.manufacturer_matches.values
    matches.each do |match|
      @manufacturer_matches_size ||= 0
      @manufacturer_matches_size += match.size
      @manufacturer_matches += match.num_feet
    end
    @manufacturer_matches_size /= matches.size if matches.size > 1  
    @manufacturer_matches_size = round @manufacturer_matches_size 
    log("manufacturer matches", matches)
  end

  def compute_average_size
    @average_shoe_size = exclude_us_sizes(@foot.shoes).map(&:size).mean_average
  end
  
  def exclude_us_sizes shoes
    shoes.reject{|shoe| shoe.size < 30}
  end

  def choose_recommended_size
    @size = @direct_matches_size || @transposed_matches_size || @manufacturer_matches_size || @average_shoe_size
  end

  def round(f, digits=2)
    factor = (10 ** digits).to_f
    (f * factor).round / factor if f
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
    return 3 if @direct_matches > 3
    case @direct_matches
      when 4..7 then 2
      when 1..3 then 1
      else 0
    end
  end

  def max_rating
   3
  end

  def belboon_product
   products = BelboonProduct.named(@manufacturer).named(@model)
   products.first if products.any?
  end
  
  def log msg, matches 
    matches.each do |match|
      Rails.logger.debug "#{msg} #{match.inspect}"
    end
  end

end