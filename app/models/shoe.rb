class Shoe < ActiveRecord::Base
  belongs_to :foot
  belongs_to :shoe_type
  
  accepts_nested_attributes_for :shoe_type, 
    :allow_destroy => true, 
    :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }
    
  validates_presence_of :size
  validates_numericality_of :size
  
  attr_writer :model, :manufacturer
  after_save :assign_model_and_manufacturer_name
  
  
  def manufacturer
    shoe_type.manufacturer.name if shoe_type and shoe_type.manufacturer
  end

  def model
    shoe_type.model if shoe_type
  end
  
  private 
    
  def assign_model_and_manufacturer_name
    manufacturer = Manufacturer.find_or_create_by_name(@manufacturer)
    self.shoe_type = ShoeType.find_or_create_by_model_and_manufacturer_id(@model, manufacturer.id)
  end    
  
end
