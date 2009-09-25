class ShoeSize 
  
  def initialize size_string, manufacturer=nil
      @size_string, @manufacturer = size_string, manufacturer
  end
  
  def value
    @size_string.gsub(',', '.').to_f
  end
  
  
end
