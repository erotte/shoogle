
class Foot 
  include CouchPotato::Persistence
  
  property :shoes, :default => []
  property :searched_shoe, :type => SearchedShoe
  property :user, :type => User
#  before_save :adjust_shoe_sizes
  view :all, :key => :created_at
  
  view :fitting, :type => :raw, 
    :map =>'
      function(doc) {
        if (doc.ruby_class == "Foot")
          for each (var a in doc.shoes) 
            for each (var b in doc.shoes) 
              if (a != b && a.size > 30 && b.size > 30) 
                emit([a.manufacturer, b.manufacturer, a.model, b.model, a.size],b.size-a.size);
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
      }', # bsp: {"rows"=>[{"value"=>{"size_sum"=>-0.5, "num_feet"=>1} 
    :results_filter => lambda{|result| result['rows'].first['value'] if result['rows'].first}
      

  def direct_matches
    matches = {}
    shoes.each do |shoe|
      key = [shoe.manufacturer, searched_shoe.manufacturer_name, shoe.model, searched_shoe.model_name, shoe.size]
      result_hash = db.view(Foot.fitting(:key => key, :group => true))
      matches[key] = Match.new(result_hash, shoe.size) if result_hash
    end if searched_shoe.model_name.present?
    matches
  end

  def transposed_matches
    matches = {}
    shoes.each do |shoe|
      key = [shoe.manufacturer, searched_shoe.manufacturer_name, shoe.model, searched_shoe.model_name]
      result_hash = db.view(Foot.fitting(:startkey => key, :group_level => 4, :limit => 1))
      matches[key] = Match.new(result_hash, shoe.size) if result_hash
    end if searched_shoe.model_name.present?
    matches
  end

  def manufacturer_matches
    matches = {}
    shoes.each do |shoe|
      key = [shoe.manufacturer, searched_shoe.manufacturer_name]
      result_hash = db.view(Foot.fitting(:startkey => key, :group_level => 2, :limit => 1))
      matches[key] = Match.new(result_hash, shoe.size) if result_hash
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

  private

  def adjust_shoe_sizes
    shoes.each do |shoe|
      shoe.adjust_size_type
    end
  end

  def db
    CouchPotato.database
  end
  
end
