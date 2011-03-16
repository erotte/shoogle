class Shoe

  SIZE_REGEXP = /^\d{1,2}(,|.)?(\d{1,2}?|\s?(\d\/\d|&.{6};))$/ # 42, 42,5, 42.5, 42 1/2, 42 &frac12;
  include CouchPotato::Persistence
  include ActionView::Helpers::NumberHelper

  property :size, :type => Float
  property :size_string
  property :sizes
  property :model
  property :manufacturer
  property :approved

  before_save :set_sizes
# TODO
#  validates_presence_of :manufacturer, :message => "Bitte gib einen Hersteller ein"
#  validates_presence_of :size_string, :message => "Bitte gib eine Größe ein"
#  validates_format_of :size_string, :with => SIZE_REGEXP, :message => "Bitte gib die Größe mit einer, maximal zwei Nachkommastellen an, z.B. 10, 10.5,  44,5, 43.66. "

  view :recommended, :type => :raw,
    :map => <<-JS,
      function(doc) {
        for each (var a in doc.shoes)
          for each (var b in doc.shoes)
            if (a.manufacturer != b.manufacturer || a.model != b.model)
              emit([a.manufacturer, a.model, b.manufacturer, b.model], 1);
              
      }
      JS
    :reduce =><<-JS,
      function (key, values) {
        return sum(values)
      }
      JS
    :group => true,
    :results_filter =>  lambda{ |results| 
                          results['rows'].map do |row| 
                            RecommendationResult.new(row['key'][2], row['key'][3], row['value'].to_i)
                          end
                        }

    view :names_by_start_of_name, :type => :raw,
      :map => <<-JS,
        function(doc) {
          if (doc.ruby_class == "Foot")
            for each (var shoe in doc.shoes)
              if (shoe.approved)
                for each (var word in shoe.model.toLowerCase().split(" "))
                  for(var length=1; length<word.length; length++)
                    emit([word.substring(0,length), shoe.manufacturer, shoe.model], shoe.model)
        }
        JS
      :reduce => <<-JS,
        function(key, values){
          return values[0]
        }
        JS
      :group => true,
      :results_filter => lambda{|results| results['rows'].map{|row| row['value']}}

    view :unapproved, :type => :raw,
      :map => <<-JS,
        function(doc) {
          if (doc.ruby_class == "Foot")
            for each (var shoe in doc.shoes)
              if (shoe.approved)
                emit([shoe.manufacturer, shoe.model], true)
              else
                emit([shoe.manufacturer, shoe.model], false)
        }
        JS
      :reduce => <<-JS
        function(key, values) {
          for each (value in values) {
            if (value) return true
          }
          return false
        }
        JS
        
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

  def size= value
    @size = SizeFormatter.new(value).to_f
  end

  def set_sizes
    self.size = SizeFormatter.new(size_string).to_f  if size_string.present?
    self.sizes = {( has_eur_size? ? :eur : :us ) => @size}
  end

  def has_eur_size?
    @size.to_i > 25
  end

end
