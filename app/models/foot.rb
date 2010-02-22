
class Foot 
  include CouchPotato::Persistence
  
  property :shoes
  property :searched_shoe, :type => SearchedShoe
end
