
importer :belboon do
  desc 'Import affiliate data from belboon/adbutler'
  
  file Dir.glob("data/belboon/*.csv")
  col_sep "\t"
  quote_char "'"

  before do
    AffiliateShoe.delete_all
  end

  foreach_file do |file|
    puts "importing all belboon products from #{file} .."
    # system "cp #{file} #{file}.src"
    # system "iconv -c -t UTF-8 -f ISO-8859-1 #{file}.src > #{file}"
    row_index = 1
    foreach do |row|
      row_index += 1
      puts "importing line: #{row_index}"
      
      if (row[:deeplinkurl].include? 'schuhe')  
        product = AffiliateShoe.new(
          :productname              => row[:productname],
          :price                    => row[:currentprice],
          :validfrom                => row[:validfrom],
          :validuntil               => row[:validuntil],
          :deeplinkurl              => row[:deeplinkurl],
          :imagesmallurl            => row[:imagesmallurl],
          :imagebigurl              => row[:imagebigurl],
          :keywords                 => row[:productkeywords],
          :descriptionshort         => row[:productdescriptionshort],
          :descriptionslong         => row[:productdescriptionslong],
          :male => row[:deeplinkurl].include?('herren')
        )
        CouchPotato.database.save_document product
      end
    end
  end
end

