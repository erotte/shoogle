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
    group_by_model(shoes_of_similar_feet).map{ |shoes|   
      Shoe.new :model => shoes.first.model, :manufacturer => shoes.first.manufacturer, :size => avg_of(shoes.map(&:size))
    }
  end
  
  def fitting args
    result = fitting_shoes.select{ |shoe| shoe.model == args[:model] and shoe.manufacturer == args[:manufacturer] }  
    result.first if result
  end

  def avg_of values
    values.inject(0.0){|sum, val| sum + val } / values.size
  end

  def median_of values
    values.sort!
    s = values.size

    if s == 1
      values.first
    elsif (s % 2) == 1
      values[ (s-1)/2 ]
    else
      ( values[ (s-1)/2 ] + values[ s/2 ] ) / 2.0
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
