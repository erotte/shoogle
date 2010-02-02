class FootCheck
  
  def initialize params
    @foot = params[:foot]
  end
  
  def forecast_for shoe
    forecasts ||= {}
    forecasts[shoe] ||= SelfCheckForecast.new( 
      :foot => @foot, 
      :model => shoe.shoe_type.model, 
      :manufacturer => shoe.shoe_type.manufacturer.name)
    forecasts[shoe]
  end
  
  def forecasts
    @foot.shoes.map{|shoe| forecast_for shoe}
  end
  
end