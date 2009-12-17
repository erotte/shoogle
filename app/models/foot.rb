# == Schema Information
# Schema version: 20090921145038
#
# Table name: feet
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  gender     :string(255)
#

class Foot < ActiveRecord::Base
  has_many :shoes
  has_many :direct_matches
  has_many :fitting_shoe_types, :through => :direct_matches, :source => :shoe_type, :group =>  "shoe_types.id"
  has_many :transposed_matches
  has_many :size_equalities
  has_many :similar_feet, :through => :size_equalities
  
  has_one  :searched_shoe
  
  accepts_nested_attributes_for :shoes, :allow_destroy => true
  accepts_nested_attributes_for :searched_shoe, :allow_destroy => true


  def shoes_of_similar_feet
    Shoe.of_equal_sized_feet self.id
  end

  def fitting_shoes
    fitting = fitting_shoe_types.map do |shoe_type|
      Forecast.new :foot => self, :model => shoe_type.model, :manufacturer => shoe_type.manufacturer.name
    end
    fitting.sort{ |a,b| b.direct_matches <=> a.direct_matches }
  end

  def fitting args
    Forecast.new :foot => self, :manufacturer => args[:manufacturer], :model => args[:model]
  end
end
