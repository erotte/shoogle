class Foot < ActiveRecord::Base
  GENDER = {'m' => 'Herrengröße', 'f' => "Frauengröße"}
  has_many :shoes       
  accepts_nested_attributes_for :shoes #, :reject_if  => :all_blank?
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
    
    model_to_shoes = {}
    
    shoes_of_similar_feet.each{ |shoe|
      key = shoe.model+"--"+shoe.manufacturer
      
      model_to_shoes[key] = [] unless model_to_shoes[key]
      model_to_shoes[key] << shoe
    }
    
    model_to_shoes.values.map{ |shoes|
      shoe = shoes.first
      avg_size = shoes.inject(0){|sum, s| sum + s.size } / shoes.size
        
      shoe.size = avg_size
      shoe
    }
  end
end
