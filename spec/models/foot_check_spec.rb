require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FootCheck do
  
  fixtures :shoes, :feet, :shoe_types, :manufacturers
  
  
  before(:each) do
    @foot = feet :arbo
    @airforce = shoes :airforce
    @adilow   = shoes :adilow
    @court    = shoes :nikecourt
    @check = FootCheck.new :foot => @foot
  end
  
  it "should recommend average shoe size of own foot for nike air force 1 because no similar foot can be found" do
    @check.forecast_for(@airforce).size.should == 46
  end

  it "should recommend average shoe size of own foot for nike court tradition because no similar foot can be found" do
    @check.forecast_for(@court).size.should == 46
  end
  
  it "should recommend average shoe size of own foot for adi low because no similar foot can be found" do
    @check.forecast_for(@adilow).size.should == 46 
  end
end