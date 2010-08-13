class Match
  attr_accessor :num_feet, :size, :size_diff, :unit 
  
  def initialize result_hash, size, unit
    @num_feet = result_hash['num_feet']
    @size_diff = result_hash['size_sum'] / @num_feet
    @size = size + @size_diff
    @unit = unit
  end
  
end