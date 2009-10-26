class CreateBelboonProduct < ActiveRecord::Migration
  def self.up
    create_table :belboon_products do |t|
      t.string :belboon_productnumber
      t.string :belboon_programid
      t.string :productnumber
      t.string :ean
      t.string :productname
      t.string :manufacturername
      t.string :brandname
      t.string :currentprice
      t.string :oldprice
      t.string :currency
      t.string :validfrom
      t.string :validuntil
      t.string :deeplinkurl
      t.string :basketurl
      t.string :imagesmallurl
      t.string :imagesmallheight
      t.string :imagesmallwidth
      t.string :imagebigurl
      t.string :imagebigheight
      t.string :imagebigwidth
      t.string :productcategory
      t.string :belboonproductcategory
      t.string :productkeywords
      t.string :productdescriptionshort
      t.string :productdescriptionslong
      t.string :lastupdate
      t.string :shipping
      t.string :availability
      t.string :option1
      t.string :option2
      t.string :option3
      t.string :option4
      t.string :option5
    end
  end

  def self.down
    drop_table :belboon_products
  end
end
