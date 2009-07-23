require 'rubygems'

require 'nokogiri'
require 'open-uri'

#doc = Nokogiri::HTML(open('http://www.tennis-warehouse.com/TWInt/Twint_Pages/shoe.html'))
doc = Nokogiri::HTML(open('./shoe.html'))

men = []
manufacturer = nil
doc.css('td.Standard table table')[0].css('tr').each{|tr| 
  
  line = []
  
  tr.children.each_with_index{|td,i| 
    txt=td.content.gsub(/\s/,'')
    if txt.size > 0  
      line << txt
    end
  } 
    
  if line and line[0] != 'Men' and line.size > 0 
    if line.size == 1 
      manufacturer = []
      manufacturer[0] = line[0] 
      manufacturer[1] = {} 
    else
      size = line[0]
      line.delete_at 0
      manufacturer[1][size] = line
      men << manufacturer unless men.include? manufacturer
    end
  end
}
puts men.to_yaml

#['Nike' {:usa => [36, 46, 45] :eur =>[37, 46, 47]}]