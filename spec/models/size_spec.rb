require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Size" do

  it "should extract an integer" do
    size = Size.new "11,5"
    size.integer.should be 11
    size = Size.new "11.5"
    size.integer.should be 11
    size = Size.new 11.5
    size.integer.should be 11
    size = Size.new "44 2/3"
    size.integer.should be 44
  end

  it "should extract a fraction" do
    Size.new("11,5").fraction.should eql 0.5
    Size.new("11.5").fraction.should eql 0.5
    Size.new(11.5).fraction.should eql 0.5
    Size.new(11.0).fraction.should eql 0.0
    Size.new("11.0").fraction.should eql 0.0
    Size.new("11,0").fraction.should eql 0.0
    Size.new("11").fraction.should eql 0.0
    Size.new(11).fraction.should eql 0.0
    Size.new("44 2/3").fraction.should eql 2/3.to_f
  end

  it "should return a valid size string" do
    Size.new("11,5").to_s.should eql "11.5"
    Size.new("11.5").to_s.should eql "11.5"
    Size.new(11.5).to_s.should eql "11.5"
    Size.new(11.0).to_s.should eql "11"
    Size.new("11.0").to_s.should eql "11"
    Size.new("11.33").to_s.should eql "11.33"
    Size.new("44 2/3").to_s.should eql "44.67"
  end

  it "should return valid floats as well" do
    Size.new("11,5").to_f.should eql 11.5
    Size.new("11.5").to_f.should eql 11.5
    Size.new(11.5).to_f.should eql 11.5
    Size.new(11.0).to_f.should eql 11.0
    Size.new("11.0").to_f.should eql 11.0
    Size.new("11.33").to_f.should eql 11.33
    Size.new("44 2/3").to_f.should eql (44.0 + 2/3.to_f)
  end
end
