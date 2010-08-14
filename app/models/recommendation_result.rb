class RecommendationResult < Struct.new(:manufacturer, :model, :num_feet)
  def full_shoe_name
    "#{manufacturer} #{model}"
  end
end