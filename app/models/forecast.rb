class Forecast
  attr_accessor :manufacturer, :model, :size, :direct_matches, :transposed_matches
  
  def initialize params = {}
    @manufacturer = params[:manufacturer]
    @model = params[:model]
    @size = params[:size]
    @direct_matches = params[:direct_matches] ? params[:direct_matches] : 0
    @transposed_matches = params[:transposed_matches] ? params[:transposed_matches] : 0
  end
end