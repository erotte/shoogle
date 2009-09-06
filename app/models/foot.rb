class Foot < ActiveRecord::Base
  GENDER = {'m' => 'Herrengröße', 'f' => "Frauengröße"}
  has_many :shoes       
  accepts_nested_attributes_for :shoes, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }
  
  validates_associated :shoes
  
  def self.similar_feet another_foot 
    self.find_by_sql "
      select f.* from feet as f, shoes as a, shoes as b 
      where a.size = b.size 
      and a.model = b.model
      and a.manufacturer = b.manufacturer 
      and a.foot_id != b.foot_id
      and b.foot_id = #{another_foot.id}
      and f.id = a.foot_id;"
  end
  
  def shoes_of_similar_feet
    Foot.similar_feet(self).collect(&:shoes).flatten
  end
  
  def fitting_shoes
    group_by_model(shoes_of_similar_feet).map{ |shoes|   
      Forecast.new :model => shoes.first.model, :manufacturer => shoes.first.manufacturer, :size => shoes.map(&:size).median, :direct_matches => shoes.size
    }
  end
  
  def fitting args
    result = connection.execute "
      select s.size, a.size, b.size from shoes as s, shoes as a, shoes as b
      where s.manufacturer = '#{args[:manufacturer]}'
      and s.model = '#{args[:model]}'
      and a.model = b.model
      and a.manufacturer = b.manufacturer 
      and s.foot_id  = a.foot_id
      and a.foot_id != b.foot_id 
      and b.foot_id  = #{id};"
      
    if result.any?
      direct_matches = 0
      transposed_matches = 0
      sizes = result.map{ |row| 
        searched = row[0].to_f
        other = row[1].to_f
        mine = row[2].to_f 
        
        if mine == other
          direct_matches += 1
        else
          transposed_matches +=1
        end
        
        searched + mine - other
      }
      Forecast.new :model => args[:model], :manufacturer => args[:manufacturer], :size  => sizes.median, :direct_matches => shoes.size, :transposed_matches => transposed_matches
    else
      Forecast.new :model => args[:model], :manufacturer => args[:manufacturer], :size  => shoes.map(&:size).mean_average
    end
  end
  
  private 
  
  def group_by_model shoes
    model_to_shoes = {}
    
    shoes.each{ |shoe|
      key = shoe.model+"--"+shoe.manufacturer
      model_to_shoes[key] = [] unless model_to_shoes[key]
      model_to_shoes[key] << shoe
    }
    model_to_shoes.values
  end
end
