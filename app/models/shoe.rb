# == Schema Information
# Schema version: 20090921145038
#
# Table name: shoes
#
#  id           :integer         not null, primary key
#  size         :float
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  foot_id      :integer
#  shoe_type_id :integer
#

class Shoe < ActiveRecord::Base
  belongs_to :foot
  belongs_to :shoe_type
  composed_of :formatted_size, :class_name => 'ShoeSize', :mapping => %w(size value)
  validates_associated :shoe_type
  
  validates_presence_of :size
  validates_numericality_of :size
  
  attr_writer :model, :manufacturer
  before_save :assign_model_and_manufacturer_name
  
  
  def manufacturer
    shoe_type.manufacturer.name if shoe_type and shoe_type.manufacturer
  end

  def model
    shoe_type.model if shoe_type
  end
  
  private 
    
  def assign_model_and_manufacturer_name
    if @model.present? and @manufacturer.present?
      manufacturer = Manufacturer.find_or_create_by_name(@manufacturer)
      self.shoe_type = ShoeType.find_or_create_by_model_and_manufacturer_id(@model, manufacturer.id)
    end
  end    
  
end
