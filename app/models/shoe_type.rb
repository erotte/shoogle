class ShoeType < ActiveRecord::Base
  belongs_to :manufacturer
  has_many :shoes
  
  validates_presence_of :model
  
  accepts_nested_attributes_for :manufacturer,
    :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }
end
