require 'rubygems'

require 'nokogiri'
require 'open-uri'


#brand = "Nike"
#pages = 97

#brand = "Puma"
#pages = 63

#brand = "Vans"
#pages = 2

brand = "Converse"
pages = 13


models = []
puts "starting to fetch #{pages} pages"
pages.times do |i|
  url = "http://www.findyoursneakers.com/Browse//Brand/#{brand}/?p=Page#{i+1}"
  puts "fetching #{url}"
  doc = Nokogiri::HTML(open(url))
  doc.css('a.naam-sneaker').each do |a|
    models << a.text.strip
  end
end
puts "done"

YAML::dump( models.sort.uniq,  File.new("#{brand.downcase}.yml", 'w'))

