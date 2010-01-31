class ForecastRenderer
  # TODO rendert nicht nur sondern berechnet auch. das sollten zwei verschiedene klassen machen SRP!
  
  attr_accessor :manufacturer, :model, :size, 
    :average_shoe_size,
    :direct_matches, :direct_matches_size, 
    :transposed_matches, :transposed_matches_size
  
  def initialize params
    @foot = params[:foot]
    @manufacturer = params[:manufacturer]
    @model = params[:model]

    compute_average_size
    compute_direct_matches
    compute_transposed_matches
    choose_recommended_size
  end
  
  def compute_direct_matches
    matches = fetch_direct_matches
    log("direct matches", matches)
    @direct_matches_size = matches.map(&:size).median if matches.any?
    @direct_matches = matches.size
  end

  def compute_transposed_matches
    matches = fetch_transposed_matches
    log("transposed matches", matches)
    @transposed_matches_size = matches.map(&:transposed_size).median if matches.any?
    @transposed_matches = matches.size
  end

  def compute_average_size
    @average_shoe_size = exclude_us_sizes(@foot.shoes).map(&:size).mean_average
  end
  
  def exclude_us_sizes shoes
    shoes.reject{|shoe| shoe.size < 30}
  end

  def choose_recommended_size
    size = @direct_matches_size || @transposed_matches_size || @average_shoe_size
    @size = round(size, 2)
  end

  def round(f, digits)
    factor = (10 ** digits).to_f
    (f * factor).round / factor
  end
  
  def has_model?
    @model.present?
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