class Foot < ActiveRecord::Base
  has_many :shoes       
  accepts_nested_attributes_for :shoes
end
