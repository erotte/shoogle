class RecommendationResult < Struct.new(:manufacturer, :model, :num_feet)

  def full_shoe_name
    "#{manufacturer} #{model}"
  end

  def affiliate_shoes
    AffiliateShoe.find(:model => model, :manufacturer => manufacturer)
  end
  
end
