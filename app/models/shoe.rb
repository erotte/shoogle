class Shoe < ActiveRecord::Base
  belongs_to :foot
  belongs_to :shoe_type
  
  accepts_nested_attributes_for :shoe_type, 
    :allow_destroy => true, 
    :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }
    
  validates_presence_of :size
  validates_numericality_of :size
  
  def manufacturer
    shoe_type.manufacturer.name if shoe_type and shoetype.manufactuerer
  end
  
  def manufacturer=(name)
    shoe_type.manufacturer = Manufacturer.get_or_create_by_name name
  end
  
  def model
    shoe_type.model if shoe_type
  end
  
  def model=(name)
    shoe_type = ShoeType.get_or_create_by_model name
  end
  
end
