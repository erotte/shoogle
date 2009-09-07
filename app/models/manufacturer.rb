class Manufacturer < ActiveRecord::Base
  validate_presence_of :name
  has_many :shoe_types
end
