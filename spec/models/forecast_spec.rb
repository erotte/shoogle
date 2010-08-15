require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Forecast do

  it "should not fail when computing average of shoesize if there are no shoesizes for given unit" do
    foot = mock("Mock of Foot")
    foot.stub!(:direct_matches).and_return({})
    foot.stub!(:transposed_matches).and_return({})
    foot.stub!(:manufacturer_matches).and_return({})
    foot.stub!(:shoes).and_return []
    
    Forecast.new(:foot => foot).average_shoe_size.should eql(nil)
    
  end
end