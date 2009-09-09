class Foot < ActiveRecord::Base
  GENDER = {'m' => 'Herrengröße', 'f' => "Frauengröße"}
  has_many :shoes       
  accepts_nested_attributes_for :shoes, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }
  
  validates_associated :shoes
  
  def self.similar_feet another_foot 
    self.find_by_sql "
      select f.* from feet as f, shoes as a, shoes as b 
      where a.size = b.size 
      and a.shoe_type_id = b.shoe_type_id
      and a.foot_id != b.foot_id
      and b.foot_id = #{another_foot.id}
      and f.id = a.foot_id;"
  end
  
  def shoes_of_similar_feet
    Foot.similar_feet(self).collect(&:shoes).flatten
  end
  
  def fitting_shoes
    group_by_shoe_type(shoes_of_similar_feet).map{ |shoes|
      Forecast.new :model => shoes.first.shoe_type.model, :manufacturer => shoes.first.shoe_type.manufacturer.name, :size => shoes.map(&:size).median, :direct_matches => shoes.size
    }
  end
  
  def fitting args
    result = connection.execute "
      select s.size, a.size, b.size from shoes as s, manufacturers as sm, shoe_types as st, shoes as a, shoes as b
      where sm.name = '#{args[:manufacturer]}'
      and st.model = '#{args[:model]}'
      and sm.id = st.manufacturer_id
      and st.id = s.shoe_type_id
      and a.shoe_type_id = b.shoe_type_id
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
  
  def group_by_shoe_type shoes
    shoe_type_to_shoes = {}
    
    shoes.each{ |shoe|
      key = shoe.shoe_type_id
      shoe_type_to_shoes[key] = [] unless shoe_type_to_shoes[key]
      shoe_type_to_shoes[key] << shoe
    }
    shoe_type_to_shoes.values
  end
end
