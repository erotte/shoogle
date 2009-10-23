class FootCheck
  
  def initialize params
    @foot = params[:foot]
  end
  
  def forecast_for shoe
    forecasts ||= {}
    forecasts[shoe] || forecasts[shoe] = Forecast.new( 
      :ignore_own_match => true, 
      :foot => @foot, 
      :model => shoe.shoe_type.model, 
      :manufacturer => shoe.shoe_type.manufacturer.name)
  end
  
end