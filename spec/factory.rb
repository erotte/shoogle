module Factory
  @no_generator = 'factory-00000001'

  def self.shoe attributes={}
    defaults = {
            :manufacturer => Factory.numbered("manufacturer-name"),
            :model => Factory.numbered("model-name"),
            :size => Factory.random_size
    }
    shoe = Shoe.new defaults.merge(attributes)
    shoe
  end

  def self.new_number
    @no_generator.succ!.dup
  end

  private

  def self.random_size
    (8..46).to_a.rand
  end

  def self.numbered string
    "#{string}-#{Factory.new_number}" 
  end
  

end
