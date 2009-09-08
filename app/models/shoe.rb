class Shoe < ActiveRecord::Base
  belongs_to :foot
  belongs_to :shoe_type
  
  accepts_nested_attributes_for :shoe_type, 
    :allow_destroy => true, 
    :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }
    
  validates_presence_of :size
  validates_numericality_of :size
  
  def manufacturer
    shoe_type.manufacturer.name if shoe_type and shoe_type.manufacturer
  end
  
  def manufacturer=(name)
    self.shoe_type = ShoeType.new unless shoe_type 
    self.shoe_type.manufacturer = Manufacturer.find_or_create_by_name name
  end
  
  def model
    shoe_type.model if shoe_type
  end
  
  def model=(model)
    if self.shoe_type
      self.shoe_type.model = model
    else
      self.shoe_type = ShoeType.find_or_create_by_model name 
    end
  end
  
end
