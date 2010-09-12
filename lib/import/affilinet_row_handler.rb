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
SKIP_WORDS = ["Flache","Sportliche", "Elegante", "Klassische", "herbstkollektionen", "herren", "damen", "Herren", "Damen"]
class AffilinetRowHandler
  def handle row
    
    categories = row[:productcategoryname].gsub(/\>/, ' ').split(' ').map(&:strip)
    
    return nil if categories.include? 'Kinderschuhe'
    
    sex = if categories[1] == 'Damenschuhe'
      'female'
    elsif categories[1] == 'Herrenschuhe'
      'male'
    else
      'unisex'
    end

    splitted_name = row[:title].gsub(/ - .*$/, '').split(' ').map(&:strip)
    splitted_name = splitted_name - categories - SKIP_WORDS
    

    affiliate_shoe = AffiliateShoe.new(
      :productname              => splitted_name.join(' '),
      :price                    => row[:displayprice],
      :deeplinkurl              => row[:deeplink1],
      :imagesmallurl            => row[:img_url].gsub(/\.ztatic.de\/large\//,".ztatic.de/catalog/"),
  #       :manufacturer             => row[:title].split(categories.join(' ')).map(&:strip!).first,
      :sex                      => sex
    )

    affiliate_shoe
  end
end