
importer :belboon do
  desc 'Import affiliate data from belboon/adbutler'
  
  file Dir.glob("data/belboon/*_alle.csv")
  col_sep ','
  quote_char '"'

  before do
    AffiliateShoe.delete_all
  end


  foreach_file do |file|
    puts "importing all belboon products from #{file} .."

    row_index = 1
    foreach do |row|
      row_index += 1
      puts "importing line: #{row_index}"
      lowercase_line = row.to_s.downcase
      
      if (lowercase_line.include?('schuhe') || lowercase_line.include?('sneaker'))  
        
        sex = 'unisex'
        sex = 'man' if (lowercase_line.include? 'herren')
        sex = 'woman' if (lowercase_line.include? 'damen')
        
        product = AffiliateShoe.new(
          :productname              => row[:product_title],
          :price                    => row[:price],
          :validfrom                => row[:valid_from],
          :validuntil               => row[:valid_to],
          :deeplinkurl              => row[:deeplink_url],
          :imagesmallurl            => row[:image_small_url],
          :imagebigurl              => row[:image_big_url],
          :keywords                 => row[:keywords],
          :descriptionshort         => row[:product_description_short],
          :descriptionslong         => row[:product_description_long  ],
          :sex                      => sex
        )
        CouchPotato.database.save_document product
      end
    end
  end
end

