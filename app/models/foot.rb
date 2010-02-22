
class Foot 
  include CouchPotato::Persistence
  
  property :shoes, :default => []
  property :searched_shoe, :type => SearchedShoe
  
end
