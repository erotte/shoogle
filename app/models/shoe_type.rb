class ShoeType < ActiveRecord::Base
  belongs_to :manufacturer
  has_many :shoes
  
  validates_associated :manufacturer
  validates_presence_of :model
end
