require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchedShoe do
  before(:each) do
    @valid_attributes = {
      :manufacturer_name => "value for manufacturer_name",
      :model_name => "value for model_name"
    }
  end

  it "should create a new instance given valid attributes" do
    searched_shoe = SearchedShoe.new(@valid_attributes)
    searched_shoe.manufacturer_name.should_not be_nil
    searched_shoe.model_name.should_not be_nil
  end
end
