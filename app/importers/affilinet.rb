
# 
# - - :artnumber
#   - AD1-0003-10
# - - :title
#   - Adidas Damenschuhe Sneaker NIZZA HIGH SLEEK
# - - :description_short
#   - Design Sneaker von adidas Originals - NIZZA HIGH SLEEK grauer Stoffsneaker. Topaktuelle Sneaker versandkostenfrei bei zalando.de bestellen - we serve shoes!
# - - :displayprice
#   - 59.00 EUR
# - - :img_url
#   - http://i1.ztatic.de/large/A/D/AD1-0003-10__default__1.jpg
# - - :deeplink1
#   - http://partners.webmasterplan.com/click.asp?ref=535368&site=5643&type=text&tnb=1&diurl=http://www.zalando.de/adidas-nizza-high-sneaker-grau.html?cg=03&ch=03
# - - :productcategoryid
#   - 32436492
# - - :productcategoryname
#   - Schuhe > Damenschuhe > Sneaker
# - - :color
#   - grau
# - - :lieferzeit
#   - 1-2 Tage
# - - :wichtigste_produkteigenschaften_aufzahlungspunkt_1
#   - Sneaker mit grauem Flanell|Originals Sleek-Series
# - - :wichtigste_produkteigenschaften_aufzahlungspunkt_2
#   - Textil
# - - :wichtigste_produkteigenschaften_aufzahlungspunkt_3
#   - "Innenmaterial: Textilfutter"
# - - :wichtigste_produkteigenschaften_aufzahlungspunkt_4
#   - "Decksohle: Textil"
# - - :wichtigste_produkteigenschaften_aufzahlungspunkt_5
#   - abriebfester Gummi
# - - :available_sizes
#   - 38
# - - :virtual_top10ofbrand
#   - 0
# - - :virtual_top25
#   - 0



importer :affilinet do
  desc 'Import affiliate data from belboon/adbutler'

  
  file Dir.glob("data/aff100.csv")
  col_sep ';'
  quote_char '"'

  # before do
  #   AffiliateShoe.delete_all
  # end


  foreach_file do |file|
    puts "importing all affilinet products from #{file} .."

    row_index = 1
    foreach do |row|
      row_index += 1

      categories = row[:productcategoryname].split('>').map(&:strip!)
      sex = if categories[1] == 'Damenschuhe'
        'female'
      elsif categories[1] == 'Herrenschuhe'
        'male'
      else
        'unisex'
      end
      
      categories.shift
      
      brand_and_model = row[:title].split(categories.join(' ')).map(&:strip!)

      product = AffiliateShoe.new(
        :productname              => brand_and_model.join(' '),
        :price                    => row[:displayprice],
        :deeplinkurl              => row[:deeplink1],
        :imagesmallurl            => row[:img_url],
        :manufacturer             => brand_and_model.first,
        :sex                      => sex
      )
#      CouchPotato.database.save_document product
      puts product.inspect
      puts
    end

  end
  
  
end
