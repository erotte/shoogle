class Shoe 
  include CouchPotato::Persistence

  property :size, :type => Float
  property :model
  property :manufacturer
  
  validates_presence_of :model
  validates_presence_of :manufacturer
  validates_presence_of :size
  validates_numericality_of :size
  
  class RecommendationResult < Struct.new(:manufacturer, :model, :num_feet);end
  
  view :recommended, :type => :raw,
    :map => '
      function(doc) {
        for each (var a in doc.shoes)
          for each (var b in doc.shoes)
            if(a.manufacturer != b.manufacturer && a.model != b.model)
              emit([a.manufacturer, a.model, b.manufacturer, b.model], 1);
      }',
    :reduce => '
      function (key, values) {
        return sum(values)
      }',
    :group => true,
    :results_filter => lambda{|results| results['rows'].map{|row| RecommendationResult.new(row['key'][2], row['key'][3], row['value'].to_i)}}
    
  def recommended
    CouchPotato.database.view( Shoe.recommended(:startkey => [@manufacturer, @model], 
                                                 :endkey   => [@manufacturer, @model, {}] ))
  end
  
  
end
