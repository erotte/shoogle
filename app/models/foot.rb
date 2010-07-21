
class Foot 
  include CouchPotato::Persistence
  
  property :shoes, :default => []
  property :searched_shoe, :type => SearchedShoe
  property :user, :type => User

  before_save :set_shoe_sizes

  view :all, :key => :created_at
  
  view :fitting, :type => :raw, 
    :map =>'
      function(doc) {
        if (doc.ruby_class == "Foot")
          for each (var a in doc.shoes) 
            for each (var b in doc.shoes) 
              if (a != b && a.sizes && b.sizes)
                for (var unit in a.sizes)
                  if (b.sizes[unit])
                    emit([unit, a.manufacturer, b.manufacturer, a.model, b.model, a.sizes[unit]], 
                         b.sizes[unit]-a.sizes[unit]);
      }', 
    :reduce => '
      function (key, values, combine) {
        var result = {size_sum:0, num_feet:0}

        if(combine){
          for each (var intermediate_result in values) {
              result.size_sum += intermediate_result.size_sum
              result.num_feet += intermediate_result.num_feet        
          }
        } else {
          for each (var size in values) {
            result.size_sum += size
            result.num_feet++
          }
        }    
        return result
      }'
      

  def direct_matches
    matches = {}
    shoes.each do |shoe|
      key = ["eur", shoe.manufacturer, searched_shoe.manufacturer_name, shoe.model, searched_shoe.model_name, shoe.size]
      result = db.view(Foot.fitting(:key => key, :group => true))
      matches[key] = Match.new(result["rows"].first["value"], shoe.size) if result["rows"].first and key === result["rows"].first["key"]
    end if searched_shoe.model_name.present?
    matches
  end

  def transposed_matches
    matches = {}
    shoes.each do |shoe|
      key = ["eur", shoe.manufacturer, searched_shoe.manufacturer_name, shoe.model, searched_shoe.model_name]
      result = db.view(Foot.fitting(:startkey => key, :group_level => 5, :limit => 1))
      matches[key] = Match.new(result["rows"].first["value"], shoe.size) if result["rows"].first and key === result["rows"].first["key"]
    end if searched_shoe.model_name.present?
    matches
  end

  def manufacturer_matches
    matches = {}
    shoes.each do |shoe|
      key = ["eur", shoe.manufacturer, searched_shoe.manufacturer_name]
      result = db.view(Foot.fitting(:startkey => key, :group_level => 3, :limit => 1))
      matches[key] = Match.new(result["rows"].first["value"], shoe.size) if result["rows"].first and key === result["rows"].first["key"]
    end
    matches
  end

  def recommended_shoes
    result = []
    shoes.each do |shoe|
      result << shoe.recommended
    end
    result.flatten.sort{|a,b| a.num_feet <=> b.num_feet}.reverse
  end

  def valid?
    searched_shoe and searched_shoe.valid?
  end

  def set_shoe_sizes
    shoes.each do |shoe|
      shoe.set_sizes
    end
  end
  
  private
  
  def db
    CouchPotato.database
  end
end
