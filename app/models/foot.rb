require 'shoe'

class Foot 
  include CouchPotato::Persistence
  
  property :shoes, :default => []
  property :searched_shoe, :type => SearchedShoe
  
  view :all, :key => :created_at
  
  view :fitting, :type => :raw, 
    :map =>'
      function(doc) {
        for each (var a in doc.shoes) 
          for each (var b in doc.shoes) 
            if (a != b) 
              emit([a.manufacturer, b.manufacturer, a.model, b.model, a.size],b.size-a.size);
      }', 
    :reduce => '
      function (key, values, rereduce) {
        var result = {size_sum:0, num_feet:0}

        if(rereduce){
          for each (var intermediate in values) {
              result.size_sum += intermediate.size_sum
              result.num_feet += intermediate.num_feet        
          }
        } else {
          for each (var size in values) {
            result.size_sum += size
            result.num_feet++
          }
        }    
        return result
      }', 
    :group => true
#    :results_filter => lambda{|rows| rows['rows'].map{|row| Fitting.new(row['key'], row['value'])}}

  
end
