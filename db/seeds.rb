
manufacturer_names = YAML.load(File.open(File.dirname(__FILE__) + "/../data/sneaker_manufacturer_names.yml"))['manufacturer_names']
manufacturer_names.uniq!

manufacturer_names.each do |name|
  Manufacturer.find_or_create_by_name name 
end

