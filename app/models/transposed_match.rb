
class TransposedMatch < ActiveRecord::Base
  belongs_to :foot
  belongs_to :shoe_type
  
  def transposed_size
    size + size_of_this - size_of_other
  end
end