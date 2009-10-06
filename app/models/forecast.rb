class Forecast
  attr_accessor :manufacturer, :model, :size, 
    :average_shoe_size,
    :direct_matches, :direct_matches_size, 
    :transposed_matches, :transposed_matches_size

  def initialize params
    @foot = params[:foot]
    @manufacturer = params[:manufacturer]
    @model = params[:model]
    
    @average_shoe_size = @foot.shoes.map(&:size).mean_average

    direct_matches = @foot.direct_matches.find_all_by_manufacturer_name_and_model_name @manufacturer, @model
    @direct_matches_size = direct_matches.map(&:size).median if direct_matches.any?
    @direct_matches = direct_matches.size

    transposed_matches = @foot.transposed_matches.find_all_by_manufacturer_name_and_model_name @manufacturer, @model    
    if transposed_matches.any?
      transposed_sizes = transposed_matches.map do |transposed_match|
        transposed_match.size + transposed_match.size_of_this - transposed_match.size_of_other
      end
      @transposed_matches_size = transposed_sizes.median 
    end
    
    @transposed_matches = transposed_matches.size
    
    @size = if direct_matches.any?
      @direct_matches_size
    elsif transposed_matches.any?
      @transposed_matches_size
    else
      @average_shoe_size
    end
  end
  
  def rating
    case @direct_matches
      when 8..100 then 3
      when 4..7 then 2
      when 1..3 then 1
      else 0
    end
  end

  def max_rating
    3
  end
end