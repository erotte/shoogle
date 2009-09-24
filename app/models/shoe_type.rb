# == Schema Information
# Schema version: 20090921145038
#
# Table name: shoe_types
#
#  id              :integer         not null, primary key
#  manufacturer_id :integer
#  model           :string(255)
#  article_number  :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class ShoeType < ActiveRecord::Base
  belongs_to :manufacturer
  has_many :shoes
  
  validates_associated :manufacturer
  validates_presence_of :model
end
