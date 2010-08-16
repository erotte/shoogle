class Shoe 
  include CouchPotato::Persistence

  property :size, :type => Float
  property :sizes
  property :model
  property :manufacturer
  property :approved

  validates_presence_of :manufacturer, :message => "Bitte gib einen Hersteller ein"
  validates_presence_of :model, :message => "Bitte gib ein Schuhmodell ein"
  validates_presence_of :size, :message => "Bitte gib eine Größe ein" 

  view :recommended, :type => :raw,
    :map => '
      function(doc) {
        for each (var a in doc.shoes)
          for each (var b in doc.shoes)
            if (a.manufacturer != b.manufacturer || a.model != b.model)
              emit([a.manufacturer, a.model, b.manufacturer, b.model], 1);
              
      }',
    :reduce => '
      function (key, values) {
        return sum(values)
      }',
    :group => true,
    :results_filter => lambda{|results| results['rows'].map{|row| RecommendationResult.new(row['key'][2], row['key'][3], row['value'].to_i)}}

    view :names_by_start_of_name, :type => :raw,
      :map => '
        function(doc) {
          if (doc.ruby_class == "Foot")
            for each (var shoe in doc.shoes)
              for each (var word in shoe.model.toLowerCase().split(" "))
                for(var length=1; length<word.length; length++)
                  emit([word.substring(0,length), shoe.manufacturer, shoe.model], shoe.model)
        }',
      :reduce => '
        function(key, values, combine){
          return values[0]
        }',
      :group => true,
      :results_filter => lambda{|results| results['rows'].map{|row| row['value']}}

    view :unapproved, :type => :raw,
      :map => '
        function(doc) {
          if (doc.ruby_class == "Foot")
            for each (var shoe in doc.shoes)
              if (shoe.approved)
                emit([shoe.manufacturer, shoe.model], true)
              else
                emit([shoe.manufacturer, shoe.model], false)
        }',
      :reduce => '
        function(key, values) {
          for each (value in values) {
            if (value) return true
          }
          return false
        }'
        
  def self.unapproved_names
    CouchPotato.database.view( Shoe.unapproved(:group => true))["rows"].select{|row| not row["value"]}.map{|row| row["key"]}
  end
  
  def self.unapproved_by_model_and_manufacturer params
    CouchPotato.database.view( 
      Shoe.unapproved(:key => [params[:manufacturer], params[:model]], :reduce => false, :include_docs => true))["rows"].map{|row| row["doc"]}  
  end
        
  def recommended
    CouchPotato.database.view( Shoe.recommended(:startkey => [@manufacturer, @model],
                                                :endkey   => [@manufacturer, @model, {}] ))
  end
  
  def set_sizes
    self.sizes = {( has_eur_size? ? :eur : :us ) => @size}
  end

  def has_eur_size?
    @size > 25
  end

end
