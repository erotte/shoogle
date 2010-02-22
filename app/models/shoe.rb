
class Shoe 
  include CouchPotato::Persistence

  property :size
  property :model
  property :manufacturer, :type => Manufacturer
end
