class Shoe < ActiveRecord::Base
  belongs_to :foot
  validates_presence_of :manufacturer, :model, :size
  validates_numericality_of :size
end
