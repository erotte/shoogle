require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchedShoe do
  before(:each) do
    @valid_attributes = {
      
    }
  end
  
  it "should initialize with valid attributes" do
    searched_shoe = SearchedShoe.new(:manufacturer => "Adidas", :model => "Samba")
    searched_shoe.should_not be_nil
    searched_shoe.manufacturer.should == "Adidas"
    searched_shoe.model.should == "Samba"
  end

  it "should pseudo-validate attributes with manufacturer as minimum requirement" do
    SearchedShoe.new(:manufacturer => "Adidas", :model => "").valid?.should == true
    SearchedShoe.new(:manufacturer => "Adidas", :model => "Samba").valid?.should == true
    SearchedShoe.new(:manufacturer => "", :model => "Samba").valid?.should == false
    SearchedShoe.new(:manufacturer => "", :model => "").valid?.should == false
  end
  
  
end
