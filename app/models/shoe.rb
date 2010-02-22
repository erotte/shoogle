
class Shoe 
  include CouchPotato::Persistence

  property :size
  property :model
  property :manufacturer
  
  validates_presence_of :model
  validates_presence_of :manufacturer
  validates_presence_of :size
  validates_numericality_of :size
end
