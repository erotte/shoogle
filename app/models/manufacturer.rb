
class Manufacturer
  include CouchPotato::Persistence
  
  property :name
  validates_presence_of :name
end
