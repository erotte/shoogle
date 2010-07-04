class FootCheck
  
  def initialize params
    @foot = params[:foot]
  end
  
  def forecast_for shoe
    forecasts ||= {}
    forecasts[shoe] ||= SelfCheckForecast.new( 
      :foot => @foot, 
      :model => shoe.model,
      :manufacturer => shoe.manufacturer)
    forecasts[shoe]
  end
  
  def forecasts
    @foot.shoes.map{|shoe| forecast_for shoe}
  end
  
end
