importer :belboon do
  desc 'Import affiliate data from belboon/adbutler'
  file Dir.glob("data/belboon/*.csv")
  
  col_sep "\t"

  foreach_file do |file|
    puts "importing #{file}.."
    
    foreach do |row|
      puts row.to_yaml
    end
  end
end
