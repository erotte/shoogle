require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchedShoe do
  before(:each) do
    @valid_attributes = {
      :manufacturer_name => "value for manufacturer_name",
      :model_name => "value for model_name"
    }
  end

  it "should create a new instance given valid attributes" do
    SearchedShoe.create!(@valid_attributes)
  end
end
