require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Array do
  
  it "should compute the average correctly" do
    [1]           .mean_average.should == 1
    [1,3]         .mean_average.should == 2
    [5,2,3,4,1]   .mean_average.should == 3
    [1,2,3,4,5,6] .mean_average.should == 3.5
    [3,4,4,4,5,10].mean_average.should == 5
    [3,4,4,4,5,16].mean_average.should == 6
  end
    
  it "should compute the median correctly" do
    [1]           .median.should == 1
    [1,3]         .median.should == 2
    [5,2,3,4,1]   .median.should == 3
    [1,2,3,4,5,6] .median.should == 3.5
    [3,4,4,4,5,10].median.should == 4
    [3,4,4,4,5,16].median.should == 4
  end
  
end