importer :belboon do
  desc 'Import affiliate data from belboon/adbutler'
  
  file Dir.glob("data/belboon/*.csv")
  col_sep "\t"
  quote_char "'"

  before do
    BelboonProduct.delete_all
  end

  foreach_file do |file|
    puts "importing all belboon products from #{file} .."
    
    foreach do |row|
      print '.'
      BelboonProduct.create(
        :belboon_productnumber    => row[:belboon_productnumber],
        :belboon_programid        => row[:belboon_programid],
        :productnumber            => row[:productnumber],
        :ean                      => row[:ean],
        :productname              => row[:productname],
        :manufacturername         => row[:manufacturername],
        :brandname                => row[:brandname],
        :currentprice             => row[:currentprice],
        :oldprice                 => row[:oldprice],
        :currency                 => row[:currency],
        :validfrom                => row[:validfrom],
        :validuntil               => row[:validuntil],
        :deeplinkurl              => row[:deeplinkurl],
        :basketurl                => row[:basketurl],
        :imagesmallurl            => row[:imagesmallurl],
        :imagesmallheight         => row[:imagesmallheight],
        :imagesmallwidth          => row[:imagesmallwidth],
        :imagebigurl              => row[:imagebigurl],
        :imagebigheight           => row[:imagebigheight],
        :imagebigwidth            => row[:imagebigwidth],
        :productcategory          => row[:productcategory],
        :belboonproductcategory   => row[:belboonproductcategory],
        :productkeywords          => row[:productkeywords],
        :productdescriptionshort  => row[:productdescriptionshort],
        :productdescriptionslong  => row[:productdescriptionslong],
        :lastupdate               => row[:lastupdate],
        :shipping                 => row[:shipping],
        :availability             => row[:availability],
        :option1 => row[:option1],
        :option2 => row[:option2],
        :option3 => row[:option3],
        :option4 => row[:option4],
        :option5 => row[:option5] )
    end
  end
end

