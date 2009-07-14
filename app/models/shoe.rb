class Shoe < ActiveRecord::Base
  belongs_to :feet
  validates_presence_of :manufacturer, :model, :size
  
end
