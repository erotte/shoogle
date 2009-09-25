class Forecast
  attr_accessor :manufacturer, :model, :size, :direct_matches, :transposed_matches

  def initialize params = {}
    @manufacturer = params[:manufacturer]
    @model = params[:model]
    @size = params[:size]
    @direct_matches = params[:direct_matches] ? params[:direct_matches] : 0
    @transposed_matches = params[:transposed_matches] ? params[:transposed_matches] : 0
  end
  
  def rating_as_text
    case @direct_matches
      when 8..100 then "mit Sicherheit" 
      when 4..7 then "bestimmt" 
      when 1..3 then "wahrscheinlich" 
      else "vielleicht"
    end
  end
end