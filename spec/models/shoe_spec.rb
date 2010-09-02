require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
describe Shoe do
  before(:each) do
    @valid_attributes = {
      :manufacturer => "Adidas",
      :model => "Samba",
      :size => "12.5"
    }
    @test_db = stub_db
  end

  it "should create a new instance given valid attributes" do
    shoe = Shoe.new(@valid_attributes)
    shoe.manufacturer.should_not be_nil
    shoe.model.should_not be_nil
    shoe.size.should_not be_nil
  end

#  DB  mit "stub_db" in before() wegstubben funktioniert,
# aber wie teste ich z.B. Valierungen explizit?
  
  it "should save a shoe" do
    shoe = Shoe.new(@valid_attributes)
    @test_db.should_receive(:save_document)
    @test_db.save_document(shoe)
    @test_db.should_receive(:load).and_return(instance_of(Shoe))
    reloaded_shoe = @test_db.load(shoe.id)
    reloaded_shoe.should_not be_nil
  end

  it "should not save a invalid shoe" do
    shoe = Shoe.new(@valid_attributes.merge(:size => nil))
    shoe.size.should be_nil
    @test_db.should_receive(:save_document!)
    @test_db.save_document!(shoe)
    @test_db.should_receive(:load)
    reloaded_shoe = @test_db.load(shoe.id)
    reloaded_shoe.should be_nil
  end

  it "should format shoe size" do
    shoe = Shoe.new(@valid_attributes.merge(:size => 11.5))
    shoe.size.should eql(11.5)
    shoe = Shoe.new(@valid_attributes.merge(:size => "11,5"))
    shoe.size.should eql(11.5)
    shoe = Shoe.new(@valid_attributes.merge(:size => "11.5"))
    shoe.size.should eql(11.5)
    shoe = Shoe.new(@valid_attributes.merge(:size => nil))
    shoe.size.should be_nil
    shoe = Shoe.new(@valid_attributes.merge(:size => 0))
    shoe.size.should be_nil
  end

end
