class Manufacturer
  include CouchPotato::Persistence
  
  property :name
  validates_presence_of :name
  
  view :by_start_of_name, :type => :raw,
    :map => <<-JS
      function(doc) {
        if (doc.ruby_class == "Manufacturer")
          for each (var word in doc.name.toLowerCase().split(" "))
            for(var length=1; length<word.length; length++)
              emit(word.substring(0,length), doc.name)
      } JS
      ,
    :results_filter => lambda{|results| results['rows'].map{|row| m = Manufacturer.new; m.name=row['value']; m}}
end
