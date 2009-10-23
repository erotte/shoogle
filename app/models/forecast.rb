class Forecast
  attr_accessor :manufacturer, :model, :size, 
    :average_shoe_size,
    :direct_matches, :direct_matches_size, 
    :transposed_matches, :transposed_matches_size

  def initialize params
    @foot = params[:foot]
    @manufacturer = params[:manufacturer]
    @model = params[:model]
    @ignore_own_match = params[:ignore_own_match] || false
    
    compute_average_size
    compute_direct_matches
    compute_transposed_matches
    
    choose_recommended_size
  end
  
  def compute_average_size
    @average_shoe_size = @foot.shoes.map(&:size).mean_average
  end
  
  def compute_direct_matches
    matches = if @ignore_own_match
      @foot.direct_matches.find_all_by_manufacturer_name_and_model_name @manufacturer, @model, 
        :conditions => ["foot_id != ?", @foot.id]
    else
      @foot.direct_matches.find_all_by_manufacturer_name_and_model_name @manufacturer, @model
    end
    @direct_matches_size = matches.map(&:size).median if matches.any?
    @direct_matches = matches.size
  end
  
  def compute_transposed_matches
    matches = if @ignore_own_match 
      @foot.transposed_matches.find_all_by_manufacturer_name_and_model_name @manufacturer, @model, 
        :conditions => ["foot_id != ?", @foot.id]
    else
      @foot.transposed_matches.find_all_by_manufacturer_name_and_model_name @manufacturer, @model    
    end
    @transposed_matches_size = matches.map(&:transposed_size).median if matches.any?
    @transposed_matches = matches.size
  end
  
  def choose_recommended_size
    @size = @direct_matches_size || @transposed_matches_size || @average_shoe_size
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