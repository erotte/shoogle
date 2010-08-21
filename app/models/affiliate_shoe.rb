class AffiliateShoe 
    include CouchPotato::Persistence
  
    property :productname
    property :price
    property :validfrom
    property :validuntil
    property :deeplinkurl
    property :imagesmallurl
    property :imagebigurl
    property :keywords
    property :descriptionshort
    property :descriptionslong
    property :male

    view :all, :key => :created_at

    view :by_words_of_name, :type => :custom, :include_docs => true,
      :map => <<-JS
        function(doc) {
          if (doc.ruby_class != "AffiliateShoe") return

          var all_subgroups_of = function(list){
            for( var j = list.length, i = ( 1 << list.length ) - 1, r = new Array(i);i; ) 
              for( r[--i] = [], j = list.length; j; i + 1 & 1 << --j && ( r[i].push(list[j]) ) );
            return r
          }

          var txt = doc.productname.replace(/[!.\-\/,;]+/g, " ").replace(/[ ]+/g, " ").toLowerCase()
          var found = {}
          var uniq_words = []
          var skip = {"schuhe":1, "topseller":1, "fashion":1, "edelsneaker":1, "stiefel":1, "damen":1, "damenschuhe":1, "woman":1, "herren":1, "herrenschuhe":1, "man":1, "schwarz":1, "sneakers":1, "sneaker":1, "silber":1, "silver":1, "von":1, "für":1, "by":1, "blue":1, "blau":1, "black":1, "pink":1, "weiß":1, "weiss":1, "white":1, "grey":1, "rot":1, "red":1, "orange":1, "violet":1,  "und":1,  "mit":1}
          for each (var word in txt.split(" ")) {
            if (!skip[word] && !found[word]) {
              found[word] = 1 
              uniq_words.push(word)
            }
          }

          for each (var group in all_subgroups_of(uniq_words)) {
            emit(group.sort(), doc._id)
          }
        } JS
        
    #
    # example: AffiliateShoe.find_by :model => 'trainer', :manufacturer => 'Puma'
    #    
    def self.find args
      key = []
      key +=  args[:model].gsub(/[!.\-\/,;]+/, " ").split(" ") if args[:model]
      key += args[:manufacturer].gsub(/[!.\-\/,;]+/, " ").split(" ") if args[:manufacturer]
      CouchPotato.database.view(by_words_of_name(:key => key.map(&:downcase).sort))
    end

    def self.delete_all
      CouchPotato.database.view(all).each{|d| CouchPotato.database.destroy_document d}
    end
end