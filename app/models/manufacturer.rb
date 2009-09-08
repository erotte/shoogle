class Manufacturer < ActiveRecord::Base
  validates_presence_of :name
  has_many :shoe_types
end
