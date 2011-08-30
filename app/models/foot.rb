class Foot < CouchRest::Model::Base
  property :shoes, [Shoe]
  property :searched_shoe, SearchedShoe
  property :user, User

  before_save :set_shoe_sizes

  design do

    #view :all, :key => :created_at

    view :fitting, :raw => true,
      :map => <<-JS,
        function(doc) {
          if (doc.ruby_class == "Foot" || doc.type == "Foot")
            for each (var a in doc.shoes)
              for each (var b in doc.shoes)
                if (a != b && a.sizes && b.sizes)
                  for (var unit in a.sizes)
                    if (b.sizes[unit])
                      emit([unit, a.manufacturer, b.manufacturer, a.model, b.model, a.sizes[unit]],
                           b.sizes[unit]-a.sizes[unit]);
        }
        JS
      :reduce => <<-JS
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
        }
        JS

  end

  def direct_matches
    matches = {}
    shoes.each do |shoe|
      if shoe.model.present?
        shoe.sizes.each do |unit, size|
          key = [unit.to_s, shoe.manufacturer, searched_shoe.manufacturer_name, shoe.model, searched_shoe.model_name, shoe.sizes[unit]]
          result = db.view(Foot.fitting(:key => key, :group => true))["rows"].first
          if result and key === result["key"]
            matches[key] = Match.new(result["value"], size, unit) 
          end
        end
      end
    end if searched_shoe.model_name.present?
    matches
  end

  def transposed_matches
    matches = {}
    shoes.each do |shoe|
      if shoe.model.present?
        shoe.sizes.each do |unit, size|
          key = [unit.to_s, shoe.manufacturer, searched_shoe.manufacturer_name, shoe.model, searched_shoe.model_name]
          result = db.view(Foot.fitting(:startkey => key, :group_level => 5, :limit => 1))["rows"].first
          if result and key === result["key"]
            matches[key] = Match.new(result["value"], size, unit) 
          end
        end
      end
    end if searched_shoe.model_name.present?
    matches
  end

  def manufacturer_matches
    matches = {}
    shoes.each do |shoe|
      shoe.sizes.each do |unit, size|
        key = [unit.to_s, shoe.manufacturer, searched_shoe.manufacturer_name]
        result = db.view(Foot.fitting(:startkey => key, :group_level => 3, :limit => 1))["rows"].first
        if result and key === result["key"]
          matches[key] = Match.new(result["value"], size, unit) 
        end
      end
    end
    matches
  end

  def recommended_shoes
    all = {}
    shoes.each do |shoe|
      shoe.recommended.each do |recommendation|
        shoe_name = recommendation.full_shoe_name
        if all[shoe_name]
          sum = recommendation.num_feet + all[shoe_name].num_feet
          recommendation = RecommendationResult.new(recommendation.manufacturer, recommendation.model, sum)
        end
        all[shoe_name] = recommendation
      end
    end
    all.values.sort_by{|recommendation| recommendation.num_feet}.reverse
    all.values.sort_by{|recommendation| recommendation.affiliate_shoes.size}.reverse
  end

  def valid?
    searched_shoe and searched_shoe.valid?
  end

  def has_valid_shoes?
    shoes.size > 0 and shoes.each(&:valid?)
  end


  def set_shoe_sizes
    shoes.each do |shoe|
      shoe.set_sizes
    end
  end


end
