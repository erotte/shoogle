require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "SizeFormatter" do

  it "should extract an integer" do
    size = SizeFormatter.new "11,5"
    size.integer.should be 11
    size = SizeFormatter.new "11.5"
    size.integer.should be 11
    size = SizeFormatter.new 11.5
    size.integer.should be 11
    size = SizeFormatter.new "44 2/3"
    size.integer.should be 44
  end

  it "should extract a fraction" do
    SizeFormatter.new("11,5").fraction.should eql 0.5
    SizeFormatter.new("11.5").fraction.should eql 0.5
    SizeFormatter.new(11.5).fraction.should eql 0.5
    SizeFormatter.new(11.0).fraction.should eql 0.0
    SizeFormatter.new("11.0").fraction.should eql 0.0
    SizeFormatter.new("11,0").fraction.should eql 0.0
    SizeFormatter.new("11").fraction.should eql 0.0
    SizeFormatter.new(11).fraction.should eql 0.0
    SizeFormatter.new("44 2/3").fraction.should eql 2/3.to_f
  end

  it "should return a valid size string" do
    SizeFormatter.new("11,5").to_s.should eql "11.5"
    SizeFormatter.new("11.5").to_s.should eql "11.5"
    SizeFormatter.new(11.5).to_s.should eql "11.5"
    SizeFormatter.new(11.0).to_s.should eql "11"
    SizeFormatter.new("11.0").to_s.should eql "11"
    SizeFormatter.new("11.33").to_s.should eql "11.33"
    SizeFormatter.new("44 2/3").to_s.should eql "44.67"
  end

  it "should return valid floats as well" do
    SizeFormatter.new("11,5").to_f.should eql 11.5
    SizeFormatter.new("11.5").to_f.should eql 11.5
    SizeFormatter.new(11.5).to_f.should eql 11.5
    SizeFormatter.new(11.0).to_f.should eql 11.0
    SizeFormatter.new("11.0").to_f.should eql 11.0
    SizeFormatter.new("11.33").to_f.should eql 11.33
    SizeFormatter.new("44 2/3").to_f.should eql((44.0 + 2/3.to_f))
  end
end
