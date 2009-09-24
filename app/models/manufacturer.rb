# == Schema Information
# Schema version: 20090921145038
#
# Table name: manufacturers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Manufacturer < ActiveRecord::Base
  validates_presence_of :name
  has_many :shoe_types
end
