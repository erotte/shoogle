
manufacturer_names = YAML.load(File.open(File.dirname(__FILE__) + "/../data/sneaker_manufacturer_names.yml"))['manufacturer_names']
manufacturer_names.uniq!

manufacturer_names.each do |name|
  manufacturer = Manufacturer.new
  manufacturer.name = name
  CouchPotato.database.save_document manufacturer
end

