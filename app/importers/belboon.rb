
importer :belboon do
  desc 'Import affiliate data from belboon/adbutler'

  
  file Dir.glob("data/belboon/*.csv")
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
      
      lowercase_line = row.to_s.downcase
      
      if (row[:belboon_programid] != "14332" && (lowercase_line.include?('schuhe') || lowercase_line.include?('sneaker')))  
        puts "importing line: #{row_index}" 
        is_female = lowercase_line.include?('damen')  || lowercase_line.include?(' woman ') || lowercase_line.include?(' women ')
        is_male   = lowercase_line.include?('herren') || lowercase_line.include?(' man ')   || lowercase_line.include?(' men ')
        
        puts "hermaphrodite" if is_female and is_male
        
        sex = if is_female
          'female'
        elsif is_male
          'male'
        else
          'unisex'
        end
        
        manufacturer = row[:brand].downcase
        manufacturer = row[:manufacturer].downcase if manufacturer == 'NULL'
        
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
          :descriptionslong         => row[:product_description_long],
          :manufacturer             => manufacturer,
          :sex                      => sex
        )
        CouchPotato.database.save_document product
      end
    end

  end
  
  
end

