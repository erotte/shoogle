class SearchedShoe 
  include CouchPotato::Persistence
  
  property :manufacturer_name
  property :model_name
  
  validates_presence_of :manufacturer_name

end
