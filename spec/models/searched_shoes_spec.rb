require 'spec_helper'

describe SearchedShoes do
  before(:each) do
    @valid_attributes = {
      :manufacturer_name => "value for manufacturer_name",
      :model_name => "value for model_name"
    }
  end

  it "should create a new instance given valid attributes" do
    SearchedShoes.create!(@valid_attributes)
  end
end
