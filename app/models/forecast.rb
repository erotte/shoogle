class Forecast
  attr_accessor :manufacturer, :model, :size, :direct_matches, :transposed_matches

  def initialize params = {}
    @manufacturer = params[:manufacturer]
    @model = params[:model]
    @size = params[:size]
    @direct_matches = params[:direct_matches] ? params[:direct_matches] : 0
    @transposed_matches = params[:transposed_matches] ? params[:transposed_matches] : 0
  end
  
  def rating
    case @direct_matches
      when 8..100 then 3
      when 4..7 then 2
      when 1..3 then 1
      else 0
    end
  end

  def rating_as_text
    case rating
      when 3 then "mit Sicherheit" 
      when 2 then "bestimmt" 
      when 1 then "wahrscheinlich" 
      else "vielleicht"
    end
  end

  
  def rating_as_sign
    '*' *  rating + '°' *  -(rating - 4)
  end
end