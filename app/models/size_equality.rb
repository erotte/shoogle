
class SizeEquality < ActiveRecord::Base
  belongs_to :foot
  belongs_to :similar_foot, :class_name => 'Foot'
end