require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ShoeSize do
  before(:each) do
    @valid_attributes = {
      
    }
  end
  
  it "should initialize from a comma seperated size string to a float value" do
    ShoeSize.new("45,5").should_not be_nil
    ShoeSize.new("45,5").value.should == 45.5 
    ShoeSize.new("43").value.should == 43 
  end
end
