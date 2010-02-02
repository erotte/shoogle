class ManufacturerForecast < ForecastRenderer
  
  def fetch_direct_matches
    @foot.direct_matches.find_all_by_manufacturer_name @manufacturer
  end
  
  def fetch_transposed_matches
    @foot.transposed_matches.find_all_by_manufacturer_name @manufacturer
  end

end