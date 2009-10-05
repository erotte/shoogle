# == Schema Information
# Schema version: 20090921145038
#
# Table name: feet
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  gender     :string(255)
#

class Foot < ActiveRecord::Base
  has_many :shoes
  has_many :direct_matches
  has_many :transposed_matches
  
  accepts_nested_attributes_for :shoes, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }
  
  validates_associated :shoes
  
  named_scope :similar_feet, lambda { |foot_id| {
    :joins => "join shoes as other on feet.id = other.foot_id 
               join shoes as mine  on other.size = mine.size 
                 and other.shoe_type_id = mine.shoe_type_id 
                 and mine.foot_id   = #{foot_id} 
                 and other.foot_id != #{foot_id}" }}

  validates_presence_of :shoes
  
  def shoes_of_similar_feet
    Foot.similar_feet(self.id).collect(&:shoes).flatten
  end
  
  def fitting_shoes
    group_by_shoe_type(shoes_of_similar_feet).map do |shoes|
      Forecast.new :model => shoes.first.shoe_type.model, :manufacturer => shoes.first.shoe_type.manufacturer.name, :size => shoes.map(&:size).median, :direct_matches => shoes.size
    end
  end
  
  def fitting args
    directs = direct_matches.find_all_by_manufacturer_name_and_model_name args[:manufacturer], args[:model]
    transposed = transposed_matches.find_all_by_manufacturer_name_and_model_name args[:manufacturer], args[:model]
    
    if directs.any?
      Forecast.new :model => args[:model], 
                   :manufacturer => args[:manufacturer], 
                   :size  => directs.map(&:size).median, 
                   :direct_matches => directs.size, 
                   :transposed_matches => transposed.size
    else
      Forecast.new :model => args[:model], 
                   :manufacturer => args[:manufacturer], 
                   :size  => shoes.map(&:size).mean_average
    end
  end
  
  private 
  
  def group_by_shoe_type shoes
    shoe_type_to_shoes = {}
    
    shoes.each do |shoe|
      key = shoe.shoe_type_id
      shoe_type_to_shoes[key] = [] unless shoe_type_to_shoes[key]
      shoe_type_to_shoes[key] << shoe
    end
    shoe_type_to_shoes.values
  end
end
