class Foot < ActiveRecord::Base
  has_many :shoes       
  accepts_nested_attributes_for :shoes #, :reject_if  => :all_blank?
  validates_associated :shoes
end
