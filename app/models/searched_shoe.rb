class SearchedShoe
  attr_accessor :model, :manufacturer
  
  def initialize args
    @model, @manufacturer = args[:model]
  end
end