class SearchedShoe 
  include CouchPotato::Persistence
  
  property :model_name
  property :manufacturer_name
  
  validates_presence_of :model_name

end
