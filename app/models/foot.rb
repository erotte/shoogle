class Foot < ActiveRecord::Base
  GENDER = {'m' => 'Herrengröße', 'f' => "Frauengröße"}
  has_many :shoes       
  accepts_nested_attributes_for :shoes
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
      Shoe.new :model => shoes.first.model, :manufacturer => shoes.first.manufacturer, :size => shoes.map(&:size).median
    }
  end
  
  def fitting args
    result = fitting_shoes.select{ |shoe| shoe.model == args[:model] and shoe.manufacturer == args[:manufacturer] }  
    unless result.empty?
      result.first
    else 
      Shoe.new :model => args[:model], :manufacturer => args[:manufacturer], :size  => shoes.map(&:size).mean_average
    end
  end
 
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
