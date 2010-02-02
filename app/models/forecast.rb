class Forecast < ForecastRenderer
  
  def fetch_direct_matches
    @foot.direct_matches.find_all_by_manufacturer_name_and_model_name @manufacturer, @model
  end
  
  def fetch_transposed_matches
    @foot.transposed_matches.find_all_by_manufacturer_name_and_model_name @manufacturer, @model    
  end
    
end