class ShoeSize
  include CouchPotato::Persistence
  property :eu_size, :type => Float
  property :us_size, :type => Float
  before_save :assign_sizes

  def assign_sizes
  end

  def to_s
    eu_size || us_size
  end

end
