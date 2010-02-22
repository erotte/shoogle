
class ShoeType < ActiveRecord::Base
  belongs_to :manufacturer
  has_many :shoes
  has_many :direct_matches
  has_many :transposed_matches
  
  validates_associated :manufacturer
  validates_presence_of :model
end
