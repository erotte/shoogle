require File.expand_path(File.dirname(__FILE__) + '/../../../lib/import/affilinet_row_handler')
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe AffilinetRowHandler do
  
  before(:each) do
    @handler = AffilinetRowHandler.new
  end
  
  describe "when importing a shoe" do
    before(:each) do
      @row = {
        :title => "Blowfish Stiefeletten Boots HOBBIT",
        :displayprice => "39.00 EUR",
        :img_url => "http://i1.ztatic.de/large/B/L/BL1-f21-0009-19__default__1.jpg",
        :deeplink1 => "http://partners.webmasterplan.com/click.asp?ref=535368&site=5643&type=text&tnb=1&diurl=http://www.zalando.de/blowfish-hobbit-short-boot-canvas-khaki.html?cg=03&ch=03",
        :productcategoryname => "Schuhe > Damenschuhe > Stiefeletten > Ankle Boots",
        :available_sizes => "38"
      }
    end

    it "should remove categories from product name" do
      doc = @handler.handle @row
      doc.productname.should eql("Blowfish HOBBIT")
    end

    it "should remove skip words like Flache Elegante Damen Sportliche" do
      @row[:title] = "Blowfish Flache Elegante Damen Sportliche Stiefeletten Boots HOBBIT"
      doc = @handler.handle @row
      doc.productname.should eql("Blowfish HOBBIT")
    end

    it "should use the 'catalog'-size instead of 'large' for images" do
      doc = @handler.handle @row
      doc.imagesmallurl.should eql("http://i1.ztatic.de/catalog/B/L/BL1-f21-0009-19__default__1.jpg")
    end
  end
  
  describe "when importing a shoe for children" do
    
    it "should ignore row" do
      @row = {
        :title => "Emu Jungenschuhe Kleinkinder (2-4J) BOOTIE HI",
        :displayprice => "29.00 EUR",
        :img_url => "http://i1.ztatic.de/large/B/L/BL1-f21-0009-19__default__1.jpg",
        :deeplink1 => "http://partners.webmasterplan.com/click.asp?ref=535368&site=5643&type=text&tnb=1&diurl=http://www.zalando.de/blowfish-hobbit-short-boot-canvas-khaki.html?cg=03&ch=03",
        :productcategoryname => "Schuhe > Kinderschuhe > Jungenschuhe > Kleinkinder (2-4J)",
        :available_sizes => "17 18 19"
      }
      doc = @handler.handle @row
      doc.should be_nil
    end
    
  end
  
end