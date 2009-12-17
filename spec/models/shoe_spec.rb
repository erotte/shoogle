require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Shoe do
  before(:each) do
    @valid_attributes = {
      :manufacturer => "Adidas",
      :model => "Samba",
      :size => "12.5"
    }
  end

  it "should create a new instance given valid attributes" do
    shoe = Shoe.new(@valid_attributes)
    shoe.manufacturer.should_not be_nil
    shoe.model.should_not be_nil
    shoe.size.should_not be_nil
  end



end
