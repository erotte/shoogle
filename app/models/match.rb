class Match
  attr_accessor :num_feet, :size, :size_diff
  
  def initialize result_hash, size
    @num_feet = result_hash['num_feet']
    @size_diff = result_hash['size_sum'] / @num_feet
    @size = size + @size_diff
  end
  
end