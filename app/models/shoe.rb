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

  validates_presence_of :size, :model, :manufacturer
    
  attr_writer :model, :manufacturer
  before_save :assign_model_and_manufacturer_name
  
  named_scope :grouped_by_shoe_type, :group => :shoe_type
  named_scope :of_equal_sized_feet, lambda{ |foot_id| { 
    :joins => 'JOIN size_equalities ON shoes.foot_id = size_equalities.similar_foot_id',
    :conditions => ['size_equalities.foot_id = ?', foot_id]
  }}
  
  def manufacturer
    @manufacturer ||= try(:shoe_type).try(:manufacturer).try(:name)
  end

  def model
    @model ||= try(:shoe_type).try(:model)
  end
  
  private 
    
  def assign_model_and_manufacturer_name
    if @model.present? and @manufacturer.present?
      manufacturer = Manufacturer.find_or_create_by_name(@manufacturer)
      self.shoe_type = ShoeType.find_or_create_by_model_and_manufacturer_id(@model, manufacturer.id)
    end
  end

end
