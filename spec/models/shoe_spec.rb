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
    shoe.size_type.should be_nil
    @test_db.should_receive(:save_document!)
    @test_db.save_document!(shoe)
    @test_db.should_receive(:load)
    reloaded_shoe = @test_db.load(shoe.id)
    reloaded_shoe.should be_nil
  end

  it "should adjust the shoe size type" do
    shoe = Shoe.new(@valid_attributes.merge(:size => "11"))
    @test_db.should_receive(:save_document!)
    @test_db.should_receive(:load)
    @test_db.should_receive(:adjust_size_type)
    @test_db.save_document!(shoe)
    reloaded_shoe = @test_db.load(shoe.id)
    p reloaded_shoe

  end


#   Das hier läuft nicht
#   Spec::Mocks::MockExpectationError: Stub "couch_potato_test" received unexpected message :info with (no args)
#  it 'should save' do
#    couchrest_db = stub 'couch_potato_test'
#    database = CouchPotato::Database.new couchrest_db
#    shoe = Shoe.new
#    couchrest_db.should_receive(:save_document)
#    database.save_document shoe
#  end

end
