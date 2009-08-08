require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Fixnum do
  it "should know when its odd" do
    1.odd?.should be_true
  end
  
  it "should know when its not odd" do
    2.odd?.should be_false
  end
end